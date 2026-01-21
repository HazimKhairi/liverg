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
public class Coach {
 //Database Connection

 DBConnect db = new DBConnect();
 Connection con = db.getConnection();
 //PreparedStatement
 PreparedStatement pstm;
 //ResultQuery
 ResultSet rs;
 String userRole = "";

 String coachName, coachPOD, fisioName, fisioPOD, coachIC, fisioIC;

 public Coach() {
 }

 public Coach(String coachIC, String fisioIC, String coachName, String coachPOD, String fisioName, String fisioPOD) {
  this.coachIC = coachIC;
  this.fisioIC = fisioIC;
  this.coachName = coachName;
  this.coachPOD = coachPOD;
  this.fisioName = fisioName;
  this.fisioPOD = fisioPOD;
 }

 public String getUserRole() {
  return userRole;
 }

 public String getCoachIC() {
  return coachIC;
 }

 public String getFisioIC() {
  return fisioIC;
 }

 public String getCoachName() {
  return coachName;
 }

 public String getCoachPOD() {
  return coachPOD;
 }

 public String getFisioName() {
  return fisioName;
 }

 public String getFisioPOD() {
  return fisioPOD;
 }

 public void setUserRole(String userRole) {
  this.userRole = userRole;
 }

 public void setCoachIC(String coachIC) {
  this.coachIC = coachIC;
 }

 public void setFisioIC(String fisioIC) {
  this.fisioIC = fisioIC;
 }

 public void setCoachName(String coachName) {
  this.coachName = coachName;
 }

 public void setCoachPOD(String coachPOD) {
  this.coachPOD = coachPOD;
 }

 public void setFisioName(String fisioName) {
  this.fisioName = fisioName;
 }

 public void setFisioPOD(String fisioPOD) {
  this.fisioPOD = fisioPOD;
 }

 public void addCoach(String coachIC, String fisioIC, String coachName, String coachPOD, String fisioName, String fisioPOD) throws SQLException {

  String sql = "INSERT INTO COACH(coachIC,fisioIC,coachName,coachPOD,fisioName,fisioPOD) VALUES (?,?,?,?,?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setString(1, coachIC);
  pstm.setString(2, fisioIC);
  pstm.setString(3, coachName);
  pstm.setString(4, coachPOD);
  pstm.setString(5, fisioName);
  pstm.setString(6, fisioPOD);
  pstm.executeUpdate();
 }
}
