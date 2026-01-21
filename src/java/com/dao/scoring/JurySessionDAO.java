package com.dao.scoring;

import com.connection.DBConnect;
import com.scoring.bean.JurySession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class JurySessionDAO {

    DBConnect db = new DBConnect();

    public JurySession getCurrentSession(int eventID) {
        String sql = "SELECT js.*, g.gymnastName, a.apparatusName, t.teamName, sl.gymnastID, sl.apparatusID " +
                     "FROM JURY_SESSION js " +
                     "JOIN START_LIST sl ON js.startListID = sl.startListID " +
                     "JOIN GYMNAST g ON sl.gymnastID = g.gymnastID " +
                     "JOIN APPARATUS a ON sl.apparatusID = a.apparatusID " +
                     "JOIN TEAM t ON g.teamID = t.teamID " +
                     "WHERE js.eventID = ? AND js.sessionStatus IN ('WAITING', 'SCORING', 'SUBMITTED') " +
                     "ORDER BY js.createdAt DESC LIMIT 1";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return extractSessionFromResultSet(rs);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    public JurySession getSessionById(int sessionID) {
        String sql = "SELECT js.*, g.gymnastName, a.apparatusName, t.teamName, sl.gymnastID, sl.apparatusID " +
                     "FROM JURY_SESSION js " +
                     "JOIN START_LIST sl ON js.startListID = sl.startListID " +
                     "JOIN GYMNAST g ON sl.gymnastID = g.gymnastID " +
                     "JOIN APPARATUS a ON sl.apparatusID = a.apparatusID " +
                     "JOIN TEAM t ON g.teamID = t.teamID " +
                     "WHERE js.sessionID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, sessionID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return extractSessionFromResultSet(rs);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    public List<JurySession> getSessionsByEvent(int eventID) {
        List<JurySession> sessions = new ArrayList<>();
        String sql = "SELECT js.*, g.gymnastName, a.apparatusName, t.teamName, sl.gymnastID, sl.apparatusID " +
                     "FROM JURY_SESSION js " +
                     "JOIN START_LIST sl ON js.startListID = sl.startListID " +
                     "JOIN GYMNAST g ON sl.gymnastID = g.gymnastID " +
                     "JOIN APPARATUS a ON sl.apparatusID = a.apparatusID " +
                     "JOIN TEAM t ON g.teamID = t.teamID " +
                     "WHERE js.eventID = ? " +
                     "ORDER BY js.createdAt DESC";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                sessions.add(extractSessionFromResultSet(rs));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return sessions;
    }

    public int createSession(int eventID, int startListID) {
        String sql = "INSERT INTO JURY_SESSION (eventID, startListID, sessionStatus) VALUES (?, ?, 'WAITING')";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pst.setInt(1, eventID);
            pst.setInt(2, startListID);
            pst.executeUpdate();

            ResultSet rs = pst.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return -1;
    }

    public void updateSessionStatus(int sessionID, String status) {
        String sql = "UPDATE JURY_SESSION SET sessionStatus = ?";

        if ("SCORING".equals(status)) {
            sql += ", startedAt = ?";
        } else if ("SUBMITTED".equals(status)) {
            sql += ", submittedAt = ?";
        } else if ("FINALIZED".equals(status)) {
            sql += ", finalizedAt = ?";
        }

        sql += " WHERE sessionID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, status);

            if ("SCORING".equals(status) || "SUBMITTED".equals(status) || "FINALIZED".equals(status)) {
                pst.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                pst.setInt(3, sessionID);
            } else {
                pst.setInt(2, sessionID);
            }

            pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void startScoring(int sessionID) {
        updateSessionStatus(sessionID, JurySession.STATUS_SCORING);
    }

    public void submitSession(int sessionID) {
        updateSessionStatus(sessionID, JurySession.STATUS_SUBMITTED);
    }

    public void finalizeSession(int sessionID) {
        updateSessionStatus(sessionID, JurySession.STATUS_FINALIZED);
    }

    public JurySession createOrGetCurrentSession(int eventID) {
        JurySession current = getCurrentSession(eventID);
        if (current != null) {
            return current;
        }

        StartListDAO startListDAO = new StartListDAO();
        var nextEntry = startListDAO.getNextUnscored(eventID);
        if (nextEntry != null) {
            int sessionID = createSession(eventID, nextEntry.getStartListID());
            return getSessionById(sessionID);
        }

        return null;
    }

    public boolean advanceToNextGymnast(int eventID) {
        JurySession current = getCurrentSession(eventID);
        if (current != null && !current.isFinalized()) {
            finalizeSession(current.getSessionID());
        }

        StartListDAO startListDAO = new StartListDAO();
        var nextEntry = startListDAO.getNextUnscored(eventID);
        if (nextEntry != null) {
            int newSessionID = createSession(eventID, nextEntry.getStartListID());
            return newSessionID > 0;
        }

        return false;
    }

    private JurySession extractSessionFromResultSet(ResultSet rs) throws SQLException {
        JurySession session = new JurySession();
        session.setSessionID(rs.getInt("sessionID"));
        session.setEventID(rs.getInt("eventID"));
        session.setStartListID(rs.getInt("startListID"));
        session.setSessionStatus(rs.getString("sessionStatus"));
        session.setStartedAt(rs.getTimestamp("startedAt"));
        session.setSubmittedAt(rs.getTimestamp("submittedAt"));
        session.setFinalizedAt(rs.getTimestamp("finalizedAt"));
        session.setCreatedAt(rs.getTimestamp("createdAt"));
        session.setGymnastName(rs.getString("gymnastName"));
        session.setApparatusName(rs.getString("apparatusName"));
        session.setTeamName(rs.getString("teamName"));
        session.setGymnastID(rs.getInt("gymnastID"));
        session.setApparatusID(rs.getInt("apparatusID"));
        return session;
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
