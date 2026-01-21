/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.scoring.bean;

/**
 *
 * @author USER
 */
public class Judge {
    int judgeID;
    String judgeName,judgeNoIC,judgePOD;
    int teamID;

    public Judge(int judgeID, String judgeName, String judgeNoIC, String judgePOD) {
        this.judgeID = judgeID;
        this.judgeName = judgeName;
        this.judgeNoIC = judgeNoIC;
        this.judgePOD = judgePOD;
    }

    
    public int getJudgeID() {
        return judgeID;
    }

    public void setJudgeID(int judgeID) {
        this.judgeID = judgeID;
    }

    public String getJudgeName() {
        return judgeName;
    }

    public void setJudgeName(String judgeName) {
        this.judgeName = judgeName;
    }

    public String getJudgeNoIC() {
        return judgeNoIC;
    }

    public void setJudgeNoIC(String judgeNoIC) {
        this.judgeNoIC = judgeNoIC;
    }

    public String getJudgePOD() {
        return judgePOD;
    }

    public void setJudgePOD(String judgePOD) {
        this.judgePOD = judgePOD;
    }

    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }
    
    
}
