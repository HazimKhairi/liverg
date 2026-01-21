package com.dao.scoring;

import com.connection.DBConnect;
import com.scoring.bean.JudgePositionType;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class JudgePositionTypeDAO {

    DBConnect db = new DBConnect();

    public List<JudgePositionType> getAllPositions() {
        List<JudgePositionType> positions = new ArrayList<>();
        String sql = "SELECT * FROM JUDGE_POSITION_TYPE ORDER BY displayOrder";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                JudgePositionType pos = extractPositionFromResultSet(rs);
                positions.add(pos);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return positions;
    }

    public List<JudgePositionType> getPositionsByPanel(int panelNumber) {
        List<JudgePositionType> positions = new ArrayList<>();
        String sql = "SELECT * FROM JUDGE_POSITION_TYPE WHERE panelNumber = ? ORDER BY displayOrder";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, panelNumber);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                JudgePositionType pos = extractPositionFromResultSet(rs);
                positions.add(pos);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return positions;
    }

    public List<JudgePositionType> getPositionsByCategory(String category) {
        List<JudgePositionType> positions = new ArrayList<>();
        String sql = "SELECT * FROM JUDGE_POSITION_TYPE WHERE category = ? ORDER BY displayOrder";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, category);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                JudgePositionType pos = extractPositionFromResultSet(rs);
                positions.add(pos);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return positions;
    }

    public JudgePositionType getPositionByCode(String positionCode) {
        String sql = "SELECT * FROM JUDGE_POSITION_TYPE WHERE positionCode = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, positionCode);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return extractPositionFromResultSet(rs);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    public JudgePositionType getPositionById(int positionTypeID) {
        String sql = "SELECT * FROM JUDGE_POSITION_TYPE WHERE positionTypeID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, positionTypeID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return extractPositionFromResultSet(rs);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    public List<JudgePositionType> getActivePositionsForEvent(int eventID) {
        List<JudgePositionType> positions = new ArrayList<>();
        String sql = "SELECT jpt.* FROM JUDGE_POSITION_TYPE jpt " +
                     "JOIN EVENT_JUDGE_CONFIG ejc ON jpt.positionTypeID = ejc.positionTypeID " +
                     "WHERE ejc.eventID = ? AND ejc.isActive = 1 " +
                     "ORDER BY jpt.displayOrder";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                JudgePositionType pos = extractPositionFromResultSet(rs);
                positions.add(pos);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return positions;
    }

    public void configurePositionForEvent(int eventID, int positionTypeID, boolean isActive) {
        String sql = "INSERT INTO EVENT_JUDGE_CONFIG (eventID, positionTypeID, isActive) VALUES (?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE isActive = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            pst.setInt(2, positionTypeID);
            pst.setBoolean(3, isActive);
            pst.setBoolean(4, isActive);
            pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void configureAllPositionsForEvent(int eventID, int panelNumber) {
        String sql = "INSERT INTO EVENT_JUDGE_CONFIG (eventID, positionTypeID, isActive) " +
                     "SELECT ?, positionTypeID, 1 FROM JUDGE_POSITION_TYPE WHERE panelNumber = ? " +
                     "ON DUPLICATE KEY UPDATE isActive = 1";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            pst.setInt(2, panelNumber);
            pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    private JudgePositionType extractPositionFromResultSet(ResultSet rs) throws SQLException {
        JudgePositionType pos = new JudgePositionType();
        pos.setPositionTypeID(rs.getInt("positionTypeID"));
        pos.setPositionCode(rs.getString("positionCode"));
        pos.setPositionName(rs.getString("positionName"));
        pos.setPanelNumber(rs.getInt("panelNumber"));
        pos.setCategory(rs.getString("category"));
        pos.setScoreMin(rs.getDouble("scoreMin"));
        pos.setScoreMax(rs.getDouble("scoreMax"));
        pos.setIsRequired(rs.getBoolean("isRequired"));
        pos.setDisplayOrder(rs.getInt("displayOrder"));
        return pos;
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
