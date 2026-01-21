/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.scoring.bean;

/**
 *
 * @author USER
 */
public class Team {
      int teamID,coachID,judgeID,gymnastID;
    String teamName,fisioIC,TcoachName,TfisioPOD,TfisioName,TcoachIC;

    public Team(String teamName, String fisioIC, String TcoachName, String TfisioName, String TcoachIC) {
        this.teamName = teamName;
        this.fisioIC = fisioIC;
        this.TcoachName = TcoachName;
        this.TfisioName = TfisioName;
        this.TcoachIC = TcoachIC;
    }

    
    public String getTcoachIC() {
        return TcoachIC;
    }

    public void setTcoachIC(String TcoachIC) {
        this.TcoachIC = TcoachIC;
    }

    public String getTfisioName() {
        return TfisioName;
    }

    public void setTfisioName(String TfisioName) {
        this.TfisioName = TfisioName;
    }

    public Team(int teamID,String teamName) {
        this.teamName = teamName;
        this.teamID = teamID;
    }

    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public int getCoachID() {
        return coachID;
    }

    public void setCoachID(int coachID) {
        this.coachID = coachID;
    }

    public int getJudgeID() {
        return judgeID;
    }

    public void setJudgeID(int judgeID) {
        this.judgeID = judgeID;
    }

    public int getGymnastID() {
        return gymnastID;
    }

    public void setGymnastID(int gymnastID) {
        this.gymnastID = gymnastID;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public String getFisioIC() {
        return fisioIC;
    }

    public void setFisioIC(String fisioIC) {
        this.fisioIC = fisioIC;
    }

    public String getTcoachName() {
        return TcoachName;
    }

    public void setTcoachName(String TcoachName) {
        this.TcoachName = TcoachName;
    }

    public String getTfisioPOD() {
        return TfisioPOD;
    }

    public void setTfisioPOD(String TfisioPOD) {
        this.TfisioPOD = TfisioPOD;
    }
    
    
}
