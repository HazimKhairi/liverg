package com.dao.scoring;

import com.connection.DBConnect;
import com.scoring.bean.JuryScore;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class JuryScoreDAO {

    DBConnect db = new DBConnect();

    public List<JuryScore> getScoresBySession(int sessionID) {
        List<JuryScore> scores = new ArrayList<>();
        String sql = "SELECT js.*, jpt.positionCode, jpt.positionName, jpt.category " +
                "FROM JURY_SCORE js " +
                "JOIN JUDGE_POSITION_TYPE jpt ON js.positionTypeID = jpt.positionTypeID " +
                "WHERE js.sessionID = ? " +
                "ORDER BY jpt.displayOrder";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, sessionID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                scores.add(extractScoreFromResultSet(rs));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return scores;
    }

    public List<JuryScore> getScoresBySessionAndCategory(int sessionID, String category) {
        List<JuryScore> scores = new ArrayList<>();
        String sql = "SELECT js.*, jpt.positionCode, jpt.positionName, jpt.category " +
                "FROM JURY_SCORE js " +
                "JOIN JUDGE_POSITION_TYPE jpt ON js.positionTypeID = jpt.positionTypeID " +
                "WHERE js.sessionID = ? AND jpt.category = ? " +
                "ORDER BY jpt.displayOrder";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, sessionID);
            pst.setString(2, category);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                scores.add(extractScoreFromResultSet(rs));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return scores;
    }

    public JuryScore getScoreByPositionCode(int sessionID, String positionCode) {
        String sql = "SELECT js.*, jpt.positionCode, jpt.positionName, jpt.category " +
                "FROM JURY_SCORE js " +
                "JOIN JUDGE_POSITION_TYPE jpt ON js.positionTypeID = jpt.positionTypeID " +
                "WHERE js.sessionID = ? AND jpt.positionCode = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, sessionID);
            pst.setString(2, positionCode);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return extractScoreFromResultSet(rs);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    public int submitScore(int sessionID, int positionTypeID, double scoreValue) {
        String sql = "INSERT INTO JURY_SCORE (sessionID, positionTypeID, scoreValue, submittedAt) " +
                "VALUES (?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE scoreValue = ?, submittedAt = ?, isOverridden = 0";

        Timestamp now = new Timestamp(System.currentTimeMillis());

        try (Connection con = db.getConnection();
                PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pst.setInt(1, sessionID);
            pst.setInt(2, positionTypeID);
            pst.setDouble(3, scoreValue);
            pst.setTimestamp(4, now);
            pst.setDouble(5, scoreValue);
            pst.setTimestamp(6, now);
            int rows = pst.executeUpdate();

            if (rows >= 0) {
                ResultSet rs = pst.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
                // Return row count, or 1 if rows is 0 (update with same values) to indicate
                // success
                return rows == 0 ? 1 : rows;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return -1;
    }

    public int submitScoreByPositionCode(int sessionID, String positionCode, double scoreValue) {
        JudgePositionTypeDAO positionDAO = new JudgePositionTypeDAO();
        var position = positionDAO.getPositionByCode(positionCode);
        if (position != null) {
            return submitScore(sessionID, position.getPositionTypeID(), scoreValue);
        }
        return -1;
    }

    public void overrideScore(int sessionID, int positionTypeID, double newScore, int staffID, String reason) {
        String sql = "UPDATE JURY_SCORE SET scoreValue = ?, isOverridden = 1, overriddenBy = ?, " +
                "overrideReason = ?, updatedAt = ? " +
                "WHERE sessionID = ? AND positionTypeID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setDouble(1, newScore);
            pst.setInt(2, staffID);
            pst.setString(3, reason);
            pst.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            pst.setInt(5, sessionID);
            pst.setInt(6, positionTypeID);
            pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public int getSubmittedScoreCount(int sessionID) {
        String sql = "SELECT COUNT(*) as count FROM JURY_SCORE WHERE sessionID = ? AND scoreValue IS NOT NULL";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, sessionID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return 0;
    }

    public int getRequiredScoreCount(int eventID) {
        String sql = "SELECT COUNT(*) as count FROM EVENT_JUDGE_CONFIG WHERE eventID = ? AND isActive = 1";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt("count");
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return 0;
    }

    public boolean areAllScoresSubmitted(int sessionID, int eventID) {
        int submitted = getSubmittedScoreCount(sessionID);
        int required = getRequiredScoreCount(eventID);
        return required > 0 && submitted >= required;
    }

    public List<String> getPendingPositions(int sessionID, int eventID) {
        List<String> pending = new ArrayList<>();
        String sql = "SELECT jpt.positionCode FROM EVENT_JUDGE_CONFIG ejc " +
                "JOIN JUDGE_POSITION_TYPE jpt ON ejc.positionTypeID = jpt.positionTypeID " +
                "LEFT JOIN JURY_SCORE js ON ejc.positionTypeID = js.positionTypeID AND js.sessionID = ? " +
                "WHERE ejc.eventID = ? AND ejc.isActive = 1 AND js.scoreValue IS NULL " +
                "ORDER BY jpt.displayOrder";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, sessionID);
            pst.setInt(2, eventID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                pending.add(rs.getString("positionCode"));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return pending;
    }

    public List<String> getSubmittedPositions(int sessionID) {
        List<String> submitted = new ArrayList<>();
        String sql = "SELECT jpt.positionCode FROM JURY_SCORE js " +
                "JOIN JUDGE_POSITION_TYPE jpt ON js.positionTypeID = jpt.positionTypeID " +
                "WHERE js.sessionID = ? AND js.scoreValue IS NOT NULL " +
                "ORDER BY jpt.displayOrder";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, sessionID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                submitted.add(rs.getString("positionCode"));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return submitted;
    }

    public void deleteScoresForSession(int sessionID) {
        String sql = "DELETE FROM JURY_SCORE WHERE sessionID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, sessionID);
            pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    private JuryScore extractScoreFromResultSet(ResultSet rs) throws SQLException {
        JuryScore score = new JuryScore();
        score.setJuryScoreID(rs.getInt("juryScoreID"));
        score.setSessionID(rs.getInt("sessionID"));
        score.setPositionTypeID(rs.getInt("positionTypeID"));

        double scoreVal = rs.getDouble("scoreValue");
        if (!rs.wasNull()) {
            score.setScoreValue(scoreVal);
        }

        score.setSubmittedAt(rs.getTimestamp("submittedAt"));
        score.setIsOverridden(rs.getBoolean("isOverridden"));

        int overriddenBy = rs.getInt("overriddenBy");
        if (!rs.wasNull()) {
            score.setOverriddenBy(overriddenBy);
        }

        score.setOverrideReason(rs.getString("overrideReason"));
        score.setPositionCode(rs.getString("positionCode"));
        score.setPositionName(rs.getString("positionName"));
        score.setCategory(rs.getString("category"));
        return score;
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
