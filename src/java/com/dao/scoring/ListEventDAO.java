/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao.scoring;

import com.connection.DBConnect;
import com.scoring.bean.Event;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

/**
 *
 * @author USER
 */
public class ListEventDAO {
        DBConnect db = new DBConnect();
        
           public List<Event> allEvent(){
         List<Event> events = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement("SELECT * FROM EVENT")) {

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                  int eventID = rs.getInt("eventID");
                        int clerkID = rs.getInt("clerkID");
                String eventName = rs.getString("eventName");
                        String eventDate = rs.getString("eventDate");
             

                events.add(new Event(eventID,clerkID,eventName,eventDate));
            }

        } catch (SQLException e) {
            printSQLException(e);
        }
        return events;
    }
                    
    public List<Event> listEvent(int eventID){
         List<Event> events = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement("SELECT * FROM EVENT WHERE eventID = ? ")) {

            pst.setInt(1, eventID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                        int clerkID = rs.getInt("clerkID");
                String eventName = rs.getString("eventName");
                        String eventDate = rs.getString("eventDate");
             

                events.add(new Event(eventID,clerkID,eventName,eventDate));
            }

        } catch (SQLException e) {
            printSQLException(e);
        }
        return events;
    }
    
       public Event getEventById(int eventID) {
        String sql = "SELECT * FROM EVENT WHERE eventID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, eventID);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                Event event = new Event(
                    rs.getInt("eventID"),
                    rs.getInt("clerkID"),
                    rs.getString("eventName"),
                    rs.getString("eventDate")
                );
                try {
                    event.setHasJuryScreen(rs.getBoolean("hasJuryScreen"));
                    event.setJuryAccessCode(rs.getString("juryAccessCode"));
                } catch (SQLException e) {
                    // Columns may not exist yet
                }
                return event;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    public Event getEventByJuryCode(String juryCode) {
        String sql = "SELECT * FROM EVENT WHERE juryAccessCode = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, juryCode);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                Event event = new Event(
                    rs.getInt("eventID"),
                    rs.getInt("clerkID"),
                    rs.getString("eventName"),
                    rs.getString("eventDate")
                );
                try {
                    event.setHasJuryScreen(rs.getBoolean("hasJuryScreen"));
                    event.setJuryAccessCode(rs.getString("juryAccessCode"));
                } catch (SQLException e) {
                    // Columns may not exist yet
                }
                return event;
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    public void updateJurySettings(int eventID, boolean hasJuryScreen, String juryAccessCode) {
        String sql = "UPDATE EVENT SET hasJuryScreen = ?, juryAccessCode = ? WHERE eventID = ?";

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setBoolean(1, hasJuryScreen);
            pst.setString(2, juryAccessCode);
            pst.setInt(3, eventID);
            pst.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());

                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
