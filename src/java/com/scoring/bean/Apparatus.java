/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.scoring.bean;

/**
 *
 * @author USER
 */
public class Apparatus {

 int apparatusID;
 String apparatusName;
 double apparatusDifficulty, apparatusExecution, apparatusArtistic;

 public Apparatus(String apparatusName) {
  this.apparatusName = apparatusName;
 }

 public Apparatus(int apparatusID, String apparatusName) {
  this.apparatusName = apparatusName;
  this.apparatusID = apparatusID;
 }

 public int getApparatusID() {
  return apparatusID;
 }

 public void setApparatusID(int apparatusID) {
  this.apparatusID = apparatusID;
 }

 public String getApparatusName() {
  return apparatusName;
 }

 public void setApparatusName(String apparatusName) {
  this.apparatusName = apparatusName;
 }

 public double getApparatusDifficulty() {
  return apparatusDifficulty;
 }

 public void setApparatusDifficulty(double apparatusDifficulty) {
  this.apparatusDifficulty = apparatusDifficulty;
 }

 public double getApparatusExecution() {
  return apparatusExecution;
 }

 public void setApparatusExecution(double apparatusExecution) {
  this.apparatusExecution = apparatusExecution;
 }

 public double getApparatusArtistic() {
  return apparatusArtistic;
 }

 public void setApparatusArtistic(double apparatusArtistic) {
  this.apparatusArtistic = apparatusArtistic;
 }

}
