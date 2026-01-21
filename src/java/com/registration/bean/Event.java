/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registration.bean;

import com.connection.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Meow
 */
public class Event {

 //Database Connection
 DBConnect db = new DBConnect();
 Connection con = db.getConnection();
 //PreparedStatement
 PreparedStatement pstm;
 //ResultQuery
 ResultSet rs;
 String userRole = "";

 int eventID, clerkID, teamID, createdBy;
 String eventName, eventPassword;
 boolean hasJuryScreen;
 String juryAccessCode;

 public Event() {
 }

 public Event(int eventID, int clerkID, String eventName, String eventPassword) {
  this.eventID = eventID;
  this.clerkID = clerkID;
  this.eventName = eventName;
  this.eventPassword = eventPassword;
 }

 public Event(int eventID, int clerkID, String eventName, String eventPassword, int teamID, int createdBy) {
  this.eventID = eventID;
  this.clerkID = clerkID;
  this.eventName = eventName;
  this.eventPassword = eventPassword;
  this.teamID = teamID;
  this.createdBy = createdBy;
 }

    public DBConnect getDb() {
        return db;
    }

    public void setDb(DBConnect db) {
        this.db = db;
    }

    public Connection getCon() {
        return con;
    }

    public void setCon(Connection con) {
        this.con = con;
    }

    public PreparedStatement getPstm() {
        return pstm;
    }

    public void setPstm(PreparedStatement pstm) {
        this.pstm = pstm;
    }

    public ResultSet getRs() {
        return rs;
    }

    public void setRs(ResultSet rs) {
        this.rs = rs;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public int getClerkID() {
        return clerkID;
    }

    public void setClerkID(int clerkID) {
        this.clerkID = clerkID;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getEventPassword() {
        return eventPassword;
    }

    public void setEventPassword(String eventPassword) {
        this.eventPassword = eventPassword;
    }

    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public boolean isHasJuryScreen() {
        return hasJuryScreen;
    }

    public void setHasJuryScreen(boolean hasJuryScreen) {
        this.hasJuryScreen = hasJuryScreen;
    }

    public String getJuryAccessCode() {
        return juryAccessCode;
    }

    public void setJuryAccessCode(String juryAccessCode) {
        this.juryAccessCode = juryAccessCode;
    }

 public boolean eventLogin(String eventName, String eventDate) throws SQLException {
  pstm = con.prepareStatement("SELECT * FROM EVENT WHERE eventName = ? AND eventDate = ?");
  pstm.setString(1, eventName);
  pstm.setString(2, eventDate);
  rs = pstm.executeQuery();

  boolean loggedIn = rs.next();
  if (loggedIn) {
   userRole = "clerk";
  }

  return loggedIn;
 }

 public void addEvent(String eventName, String eventDate, int userid) throws SQLException {

  String sql = "INSERT INTO EVENT(eventName,eventDate,clerkID) VALUES (?,?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setString(1, eventName);
  pstm.setString(2, eventDate);
  pstm.setInt(3, userid);
  pstm.executeUpdate();
 }

 //Add Event with Organization (used by Super Admin)
 public void addEventWithOrg(String eventName, String eventDate, int clerkID, int teamID, int createdBy) throws SQLException {
  String sql = "INSERT INTO EVENT(eventName, eventDate, clerkID, teamID, createdBy) VALUES (?,?,?,?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setString(1, eventName);
  pstm.setString(2, eventDate);
  pstm.setInt(3, clerkID);
  pstm.setInt(4, teamID);
  pstm.setInt(5, createdBy);
  pstm.executeUpdate();
 }

 //Add Event by Organization
 public void addEventByOrg(String eventName, String eventDate, int clerkID, int teamID) throws SQLException {
  String sql = "INSERT INTO EVENT(eventName, eventDate, clerkID, teamID) VALUES (?,?,?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setString(1, eventName);
  pstm.setString(2, eventDate);
  pstm.setInt(3, clerkID);
  pstm.setInt(4, teamID);
  pstm.executeUpdate();
 }

 public int StoreEvent(String eventName, String eventDate) throws SQLException {
  pstm = con.prepareStatement("SELECT eventID FROM EVENT WHERE eventName = ? AND eventDate = ?");
  pstm.setString(1, eventName);
  pstm.setString(2, eventDate);
  rs = pstm.executeQuery();

  if (rs.next()) {
   return rs.getInt("eventID");
  } else {
   return -1;
  }
 }
}
