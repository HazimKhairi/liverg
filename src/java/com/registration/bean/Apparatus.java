/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.registration.bean;

import com.connection.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Meow
 */
public class Apparatus {
 //Database Connection
 DBConnect db = new DBConnect();
 Connection con = db.getConnection();
 //PreparedStatement
 PreparedStatement pstm;
 //ResultQuery
 ResultSet rs;
 String userRole = "";
 int apparatusID;
 String apparatusName;
 Double apparatusDifficulty, apparatusExecution, apparatusArtistic;

 public Apparatus() {
 }

 public Apparatus(int apparatusID, String apparatusName, Double apparatusDifficulty, Double apparatusExecution, Double apparatusArtistic) {
  this.apparatusID = apparatusID;
  this.apparatusName = apparatusName;
  this.apparatusDifficulty = apparatusDifficulty;
  this.apparatusExecution = apparatusExecution;
  this.apparatusArtistic = apparatusArtistic;
 }

 public int getApparatusID() {
  return apparatusID;
 }

 public String getApparatusName() {
  return apparatusName;
 }

 public Double getApparatusDifficulty() {
  return apparatusDifficulty;
 }

 public Double getApparatusExecution() {
  return apparatusExecution;
 }

 public Double getApparatusArtistic() {
  return apparatusArtistic;
 }

 public void setApparatusID(int apparatusID) {
  this.apparatusID = apparatusID;
 }

 public void setApparatusName(String apparatusName) {
  this.apparatusName = apparatusName;
 }

 public void setApparatusDifficulty(Double apparatusDifficulty) {
  this.apparatusDifficulty = apparatusDifficulty;
 }

 public void setApparatusExecution(Double apparatusExecution) {
  this.apparatusExecution = apparatusExecution;
 }

 public void setApparatusArtistic(Double apparatusArtistic) {
  this.apparatusArtistic = apparatusArtistic;
 }
}
