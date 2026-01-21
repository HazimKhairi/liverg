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
public class headJudge {

 //Database Connection
 DBConnect db = new DBConnect();
 Connection con = db.getConnection();
 //PreparedStatement
 PreparedStatement pstm;
 //ResultQuery
 ResultSet rs;
 String userRole = "";

 int headJudgeID, clerkID;
 String headUsername, headPassword;

 public headJudge() {
 }

 public headJudge(int headJudgeID, int clerkID, String headUsername, String headPassword) {
  this.headJudgeID = headJudgeID;
  this.clerkID = clerkID;
  this.headUsername = headUsername;
  this.headPassword = headPassword;
 }

 public int getHeadJudgeID() {
  return headJudgeID;
 }

 public int getClerkID() {
  return clerkID;
 }

 public String getHeadUsername() {
  return headUsername;
 }

 public String getHeadPassword() {
  return headPassword;
 }

 public void setHeadJudgeID(int headJudgeID) {
  this.headJudgeID = headJudgeID;
 }

 public void setClerkID(int clerkID) {
  this.clerkID = clerkID;
 }

 public void setHeadUsername(String headUsername) {
  this.headUsername = headUsername;
 }

 public void setHeadPassword(String headPassword) {
  this.headPassword = headPassword;
 }

 public boolean headjudgeLogin(String username, String password) throws SQLException {
  pstm = con.prepareStatement("SELECT * FROM HEADJUDGE WHERE headUsername = ? AND headPassword = ?");
  pstm.setString(1, username);
  pstm.setString(2, password);
  rs = pstm.executeQuery();

  boolean loggedIn = rs.next();
  if (loggedIn) {
   userRole = "headjudge";
  }

  return loggedIn;
 }

 public void addHeadJudge(String username, String name, String password, int userid) throws SQLException {

  String sql = "INSERT INTO HEADJUDGE(headUsername,headName,headPassword,clerkID) VALUES (?,?,?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setString(1, username);
  pstm.setString(2, name);
  pstm.setString(3, password);
  pstm.setInt(4, userid);
  pstm.executeUpdate();
 }

 public int StoreHeadID(String username, String password) throws SQLException {
  pstm = con.prepareStatement("SELECT headjudgeID FROM HEADJUDGE WHERE headUsername = ? AND headPassword = ?");
  pstm.setString(1, username);
  pstm.setString(2, password);
  rs = pstm.executeQuery();

  if (rs.next()) {
   return rs.getInt("headjudgeID");
  } else {
   return -1;
  }
 }
}
