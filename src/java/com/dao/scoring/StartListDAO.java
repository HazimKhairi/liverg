package com.dao.scoring;

import com.connection.DBConnect;
import com.scoring.bean.StartListEntry;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class StartListDAO {

    DBConnect db = new DBConnect();

    public List<StartListEntry> getStartListByEvent(int eventID) {
        List<StartListEntry> startList = new ArrayList<>();
        String sql = "SELECT sl.*, g.gymnastName, g.gymnastCategory, t.teamName, a.apparatusName, g.teamID " +
                "FROM START_LIST sl " +
                "JOIN GYMNAST g ON sl.gymnastID = g.gymnastID " +
                "JOIN TEAM t ON g.teamID = t.teamID " +
                "JOIN APPARATUS a ON sl.apparatusID = a.apparatusID " +
                "WHERE sl.eventID = ? " +
                "ORDER BY sl.competitionDay, sl.batchNumber, sl.startOrder";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                StartListEntry entry = extractEntryFromResultSet(rs);
                startList.add(entry);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return startList;
    }

    public List<StartListEntry> getStartListByEventAndDay(int eventID, int competitionDay) {
        List<StartListEntry> startList = new ArrayList<>();
        String sql = "SELECT sl.*, g.gymnastName, g.gymnastCategory, t.teamName, a.apparatusName, g.teamID " +
                "FROM START_LIST sl " +
                "JOIN GYMNAST g ON sl.gymnastID = g.gymnastID " +
                "JOIN TEAM t ON g.teamID = t.teamID " +
                "JOIN APPARATUS a ON sl.apparatusID = a.apparatusID " +
                "WHERE sl.eventID = ? AND sl.competitionDay = ? " +
                "ORDER BY sl.batchNumber, sl.startOrder";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            pst.setInt(2, competitionDay);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                StartListEntry entry = extractEntryFromResultSet(rs);
                startList.add(entry);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return startList;
    }

    public List<StartListEntry> getStartListByEventDayAndBatch(int eventID, int competitionDay, int batchNumber) {
        List<StartListEntry> startList = new ArrayList<>();
        String sql = "SELECT sl.*, g.gymnastName, g.gymnastCategory, t.teamName, a.apparatusName, g.teamID " +
                "FROM START_LIST sl " +
                "JOIN GYMNAST g ON sl.gymnastID = g.gymnastID " +
                "JOIN TEAM t ON g.teamID = t.teamID " +
                "JOIN APPARATUS a ON sl.apparatusID = a.apparatusID " +
                "WHERE sl.eventID = ? AND sl.competitionDay = ? AND sl.batchNumber = ? " +
                "ORDER BY sl.startOrder";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            pst.setInt(2, competitionDay);
            pst.setInt(3, batchNumber);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                StartListEntry entry = extractEntryFromResultSet(rs);
                startList.add(entry);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return startList;
    }

    public StartListEntry getStartListEntryById(int startListID) {
        String sql = "SELECT sl.*, g.gymnastName, g.gymnastCategory, t.teamName, a.apparatusName, g.teamID " +
                "FROM START_LIST sl " +
                "JOIN GYMNAST g ON sl.gymnastID = g.gymnastID " +
                "JOIN TEAM t ON g.teamID = t.teamID " +
                "JOIN APPARATUS a ON sl.apparatusID = a.apparatusID " +
                "WHERE sl.startListID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, startListID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return extractEntryFromResultSet(rs);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    public int generateStartListFromComposite(int eventID) {
        String sql = "INSERT INTO START_LIST (eventID, gymnastID, apparatusID, competitionDay, batchNumber, startOrder, randomSeed) "
                +
                "SELECT c.eventID, c.gymnastID, c.apparatusID, 1, 1, " +
                "ROW_NUMBER() OVER (ORDER BY RAND()), FLOOR(RAND() * 1000000) " +
                "FROM COMPOSITE c " +
                "WHERE c.eventID = ? AND c.scoreID IS NULL " +
                "AND NOT EXISTS (SELECT 1 FROM START_LIST sl WHERE sl.eventID = c.eventID " +
                "AND sl.gymnastID = c.gymnastID AND sl.apparatusID = c.apparatusID)";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            return pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
        return 0;
    }

    public int addToStartList(int eventID, int gymnastID, int apparatusID, int competitionDay, int batchNumber) {
        String getMaxOrderSql = "SELECT COALESCE(MAX(startOrder), 0) + 1 as nextOrder FROM START_LIST " +
                "WHERE eventID = ? AND competitionDay = ? AND batchNumber = ?";
        String insertSql = "INSERT INTO START_LIST (eventID, gymnastID, apparatusID, competitionDay, batchNumber, startOrder, randomSeed) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = db.getConnection()) {
            int nextOrder = 1;
            try (PreparedStatement pstMax = con.prepareStatement(getMaxOrderSql)) {
                pstMax.setInt(1, eventID);
                pstMax.setInt(2, competitionDay);
                pstMax.setInt(3, batchNumber);
                ResultSet rs = pstMax.executeQuery();
                if (rs.next()) {
                    nextOrder = rs.getInt("nextOrder");
                }
            }

            try (PreparedStatement pst = con.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                pst.setInt(1, eventID);
                pst.setInt(2, gymnastID);
                pst.setInt(3, apparatusID);
                pst.setInt(4, competitionDay);
                pst.setInt(5, batchNumber);
                pst.setInt(6, nextOrder);
                pst.setInt(7, new Random().nextInt(1000000));
                pst.executeUpdate();

                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return -1;
    }

    public void updateStartOrder(int startListID, int newOrder) {
        String sql = "UPDATE START_LIST SET startOrder = ? WHERE startListID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, newOrder);
            pst.setInt(2, startListID);
            pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void updateDayAndBatch(int startListID, int competitionDay, int batchNumber) {
        String sql = "UPDATE START_LIST SET competitionDay = ?, batchNumber = ? WHERE startListID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, competitionDay);
            pst.setInt(2, batchNumber);
            pst.setInt(3, startListID);
            pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void randomizeOrderInBatch(int eventID, int competitionDay, int batchNumber) {
        String sql = "UPDATE START_LIST sl " +
                "JOIN (SELECT startListID, ROW_NUMBER() OVER (ORDER BY RAND()) as newOrder " +
                "      FROM START_LIST WHERE eventID = ? AND competitionDay = ? AND batchNumber = ?) ranked " +
                "ON sl.startListID = ranked.startListID " +
                "SET sl.startOrder = ranked.newOrder, sl.randomSeed = FLOOR(RAND() * 1000000)";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            pst.setInt(2, competitionDay);
            pst.setInt(3, batchNumber);
            pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void finalizeStartList(int eventID) {
        String sql = "UPDATE START_LIST SET isFinalized = 1 WHERE eventID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void deleteStartListEntry(int startListID) {
        String sql = "DELETE FROM START_LIST WHERE startListID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, startListID);
            pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void clearStartListForEvent(int eventID) {
        String sql = "DELETE FROM START_LIST WHERE eventID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public StartListEntry getNextUnscored(int eventID) {
        String sql = "SELECT sl.*, g.gymnastName, g.gymnastCategory, t.teamName, a.apparatusName, g.teamID " +
                "FROM START_LIST sl " +
                "JOIN GYMNAST g ON sl.gymnastID = g.gymnastID " +
                "JOIN TEAM t ON g.teamID = t.teamID " +
                "JOIN APPARATUS a ON sl.apparatusID = a.apparatusID " +
                "LEFT JOIN JURY_SESSION js ON sl.startListID = js.startListID AND js.sessionStatus = 'FINALIZED' " +
                "WHERE sl.eventID = ? AND js.sessionID IS NULL " +
                "ORDER BY sl.competitionDay, sl.batchNumber, sl.startOrder " +
                "LIMIT 1";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return extractEntryFromResultSet(rs);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    private StartListEntry extractEntryFromResultSet(ResultSet rs) throws SQLException {
        StartListEntry entry = new StartListEntry();
        entry.setStartListID(rs.getInt("startListID"));
        entry.setEventID(rs.getInt("eventID"));
        entry.setGymnastID(rs.getInt("gymnastID"));
        entry.setApparatusID(rs.getInt("apparatusID"));
        entry.setCompetitionDay(rs.getInt("competitionDay"));
        entry.setBatchNumber(rs.getInt("batchNumber"));
        entry.setStartOrder(rs.getInt("startOrder"));
        entry.setRandomSeed(rs.getInt("randomSeed"));
        entry.setIsFinalized(rs.getBoolean("isFinalized"));
        entry.setGymnastName(rs.getString("gymnastName"));
        entry.setGymnastCategory(rs.getString("gymnastCategory"));
        try {
            entry.setGymnastSchool(rs.getString("gymnastSchool"));
        } catch (SQLException e) {
            // Ignore if column doesn't exist (e.g. in other queries)
        }
        entry.setTeamName(rs.getString("teamName"));
        entry.setApparatusName(rs.getString("apparatusName"));
        entry.setTeamID(rs.getInt("teamID"));
        return entry;
    }

    public List<StartListEntry> getStartList(int eventID, int day, int batch, int apparatusID, String category,
            String school) {
        List<StartListEntry> startList = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append(
                "SELECT sl.*, g.gymnastName, g.gymnastCategory, g.gymnastSchool, t.teamName, a.apparatusName, g.teamID, ");
        sql.append("COALESCE(fs.finalScore, 0) as finalScore ");
        sql.append("FROM START_LIST sl ");
        sql.append("JOIN GYMNAST g ON sl.gymnastID = g.gymnastID ");
        sql.append("JOIN TEAM t ON g.teamID = t.teamID ");
        sql.append("JOIN APPARATUS a ON sl.apparatusID = a.apparatusID ");
        sql.append("LEFT JOIN JURY_SESSION js ON sl.startListID = js.startListID ");
        sql.append("LEFT JOIN FINAL_SCORE fs ON js.sessionID = fs.sessionID ");
        sql.append("WHERE sl.eventID = ? ");

        if (day > 0)
            sql.append("AND sl.competitionDay = ? ");
        if (batch > 0)
            sql.append("AND sl.batchNumber = ? ");
        if (apparatusID > 0)
            sql.append("AND sl.apparatusID = ? ");
        if (category != null && !category.isEmpty())
            sql.append("AND g.gymnastCategory = ? ");
        if (school != null && !school.isEmpty())
            sql.append("AND g.gymnastSchool = ? ");

        sql.append("ORDER BY sl.competitionDay, sl.batchNumber, sl.startOrder");

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            pst.setInt(paramIndex++, eventID);
            if (day > 0)
                pst.setInt(paramIndex++, day);
            if (batch > 0)
                pst.setInt(paramIndex++, batch);
            if (apparatusID > 0)
                pst.setInt(paramIndex++, apparatusID);
            if (category != null && !category.isEmpty())
                pst.setString(paramIndex++, category);
            if (school != null && !school.isEmpty())
                pst.setString(paramIndex++, school);

            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                StartListEntry entry = extractEntryFromResultSet(rs);
                entry.setFinalScore(rs.getDouble("finalScore"));
                startList.add(entry);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return startList;
    }

    public int getMaxStartOrder(int eventID, int competitionDay, int batchNumber) {
        String sql = "SELECT COALESCE(MAX(startOrder), 0) as maxOrder FROM START_LIST " +
                "WHERE eventID = ? AND competitionDay = ? AND batchNumber = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            pst.setInt(2, competitionDay);
            pst.setInt(3, batchNumber);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt("maxOrder");
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return 0;
    }

    public boolean removeFromStartList(int startListID) {
        // Check if already scored
        String checkSql = "SELECT COUNT(*) FROM JURY_SESSION WHERE startListID = ? AND sessionStatus = 'FINALIZED'";
        String deleteSql = "DELETE FROM START_LIST WHERE startListID = ?";

        try (Connection con = db.getConnection()) {
            try (PreparedStatement checkPst = con.prepareStatement(checkSql)) {
                checkPst.setInt(1, startListID);
                ResultSet rs = checkPst.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    return false; // Already scored, cannot remove
                }
            }

            try (PreparedStatement pst = con.prepareStatement(deleteSql)) {
                pst.setInt(1, startListID);
                return pst.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return false;
    }

    public boolean randomizeUnscored(int eventID) {
        String sql = "UPDATE START_LIST sl " +
                "LEFT JOIN JURY_SESSION js ON sl.startListID = js.startListID AND js.sessionStatus = 'FINALIZED' " +
                "SET sl.startOrder = sl.startOrder, sl.randomSeed = FLOOR(RAND() * 1000000) " +
                "WHERE sl.eventID = ? AND js.sessionID IS NULL";

        // First, get all unscored entries grouped by day/batch
        String selectSql = "SELECT DISTINCT competitionDay, batchNumber FROM START_LIST sl " +
                "LEFT JOIN JURY_SESSION js ON sl.startListID = js.startListID AND js.sessionStatus = 'FINALIZED' " +
                "WHERE sl.eventID = ? AND js.sessionID IS NULL";

        try (Connection con = db.getConnection()) {
            List<int[]> dayBatches = new ArrayList<>();
            try (PreparedStatement selectPst = con.prepareStatement(selectSql)) {
                selectPst.setInt(1, eventID);
                ResultSet rs = selectPst.executeQuery();
                while (rs.next()) {
                    dayBatches.add(new int[] { rs.getInt("competitionDay"), rs.getInt("batchNumber") });
                }
            }

            for (int[] db : dayBatches) {
                randomizeOrderInBatch(eventID, db[0], db[1]);
            }
            return true;
        } catch (SQLException e) {
            printSQLException(e);
        }
        return false;
    }

    public int getOrCreateApparatusID(String apparatusName) {
        String selectSql = "SELECT apparatusID FROM APPARATUS WHERE apparatusName = ?";
        String insertSql = "INSERT INTO APPARATUS (apparatusName) VALUES (?)";

        try (Connection con = db.getConnection()) {
            try (PreparedStatement pst = con.prepareStatement(selectSql)) {
                pst.setString(1, apparatusName);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    return rs.getInt("apparatusID");
                }
            }

            try (PreparedStatement pst = con.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                pst.setString(1, apparatusName);
                pst.executeUpdate();
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return -1;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
            }
        }
    }
}
