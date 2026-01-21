/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registration.bean;

import com.connection.DBConnect;
import java.sql.*;

/**
 *
 * @author Meow
 */
public class Team {

 //Database Connection
 DBConnect db = new DBConnect();
 Connection con = db.getConnection();
 //PreparedStatement
 PreparedStatement pstm;
 //ResultQuery
 ResultSet rs;
 String userRole = "";

 //Variable Declaration
 int teamID, createdBy;
 String teamName, coachIC, orgUsername, orgPassword, orgStatus;

 public Team() {
 }

 public Team(int teamID, String coachIC, String teamName) {
  this.teamID = teamID;
  this.coachIC = coachIC;
  this.teamName = teamName;
 }

 public Team(int teamID, String teamName, String coachIC, String orgUsername, String orgPassword, String orgStatus, int createdBy) {
  this.teamID = teamID;
  this.teamName = teamName;
  this.coachIC = coachIC;
  this.orgUsername = orgUsername;
  this.orgPassword = orgPassword;
  this.orgStatus = orgStatus;
  this.createdBy = createdBy;
 }

 public int getTeamID() {
  return teamID;
 }

 public String getCoachIC() {
  return coachIC;
 }

 public String getTeamName() {
  return teamName;
 }

 public void setTeamID(int teamID) {
  this.teamID = teamID;
 }

 public void setCoachIC(String coachIC) {
  this.coachIC = coachIC;
 }

 public void setTeamName(String teamName) {
  this.teamName = teamName;
 }

 public String getOrgUsername() {
  return orgUsername;
 }

 public void setOrgUsername(String orgUsername) {
  this.orgUsername = orgUsername;
 }

 public String getOrgPassword() {
  return orgPassword;
 }

 public void setOrgPassword(String orgPassword) {
  this.orgPassword = orgPassword;
 }

 public String getOrgStatus() {
  return orgStatus;
 }

 public void setOrgStatus(String orgStatus) {
  this.orgStatus = orgStatus;
 }

 public int getCreatedBy() {
  return createdBy;
 }

 public void setCreatedBy(int createdBy) {
  this.createdBy = createdBy;
 }

 public void addTeam(String coachIC, String teamName) throws SQLException {

  String sql = "INSERT INTO TEAM(teamName,coachIC) VALUES (?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setString(1, teamName);
  pstm.setString(2, coachIC);
  pstm.executeUpdate();
 }

 //Add Team with Organization credentials (used by Super Admin)
 public void addTeamWithOrg(String teamName, String coachIC, String orgUsername, String orgPassword, int createdBy) throws SQLException {
  String sql = "INSERT INTO TEAM(teamName, coachIC, orgUsername, orgPassword, orgStatus, createdBy) VALUES (?,?,?,?,?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setString(1, teamName);
  pstm.setString(2, coachIC);
  pstm.setString(3, orgUsername);
  pstm.setString(4, orgPassword);
  pstm.setString(5, "active");
  pstm.setInt(6, createdBy);
  pstm.executeUpdate();
 }

 //Organization Login
 public boolean orgLogin(String username, String password) throws SQLException {
  pstm = con.prepareStatement("SELECT teamID FROM TEAM WHERE orgUsername = ? AND orgPassword = ? AND orgStatus = 'active'");
  pstm.setString(1, username);
  pstm.setString(2, password);
  rs = pstm.executeQuery();

  boolean loggedIn = rs.next();
  if (loggedIn) {
   userRole = "organization";
  }
  return loggedIn;
 }

 //Store Team ID by Org Login
 public int StoreTeamIDByOrg(String username, String password) throws SQLException {
  pstm = con.prepareStatement("SELECT teamID FROM TEAM WHERE orgUsername = ? AND orgPassword = ? AND orgStatus = 'active'");
  pstm.setString(1, username);
  pstm.setString(2, password);
  rs = pstm.executeQuery();

  if (rs.next()) {
   return rs.getInt("teamID");
  } else {
   return -1;
  }
 }
}
