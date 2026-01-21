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
public class Clerk {

 //Database Connection
 DBConnect db = new DBConnect();
 Connection con = db.getConnection();
 //PreparedStatement
 PreparedStatement pstm;
 //ResultQuery
 ResultSet rs;
 String userRole = "";

 //Variable Declaration
 int clerkID;
 String clerkUsername, clerkPassword, clerkName;

 //Default Constructor
 public Clerk() {
 }

 //Normal Constructor
 public Clerk(int clerkID, String clerkName, String clerkUsername, String clerkPassword) {
  this.clerkName = clerkName;
  this.clerkID = clerkID;
  this.clerkUsername = clerkUsername;
  this.clerkPassword = clerkPassword;
 }

 //Getter Method
 public int getClerkID() {
  return clerkID;
 }

 public String getClerkUsername() {
  return clerkUsername;
 }

 public String getClerkPassword() {
  return clerkPassword;
 }

 public String getClerkName() {
  return clerkName;
 }

 //Setter Method
 public void setClerkID(int clerkID) {
  this.clerkID = clerkID;
 }

 public void setClerkName(String clerkName) {
  this.clerkName = clerkName;
 }

 public void setClerkUsername(String clerkUsername) {
  this.clerkUsername = clerkUsername;
 }

 public void setClerkPassword(String clerkPassword) {
  this.clerkPassword = clerkPassword;
 }

 //Clerk Login Query
 public boolean clerkLogin(String username, String password) throws SQLException {
  pstm = con.prepareStatement("SELECT * FROM CLERK WHERE clerkUsername = ? AND clerkPassword = ?");
  pstm.setString(1, username);
  pstm.setString(2, password);
  rs = pstm.executeQuery();

  boolean loggedIn = rs.next();

  if (loggedIn) {
   userRole = "clerk";
  }
  return loggedIn;
 }

 public void addClerk(String username, String name, String password, int userid) throws SQLException {

  String sql = "INSERT INTO CLERK(clerkUsername,clerkName,clerkPassword,staffID) VALUES (?,?,?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setString(1, username);
  pstm.setString(2, name);
  pstm.setString(3, password);
  pstm.setInt(4, userid);
  pstm.executeUpdate();
 }

// DAO
 public int StoreClerkID(String username, String password) throws SQLException {
  pstm = con.prepareStatement("SELECT clerkID FROM CLERK WHERE clerkUsername = ? AND clerkPassword = ?");
  pstm.setString(1, username);
  pstm.setString(2, password);
  rs = pstm.executeQuery();

  if (rs.next()) {
   return rs.getInt("clerkID");
  } else {
   return -1;
  }
 }
}
