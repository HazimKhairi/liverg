/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.scoring.bean;

import java.util.Arrays;

/**
 *
 * @author USER
 */
public class Score {

    int scoreID, judgeID;
    private int gymnastID;
    double scoreD1, scoreD2, scoreD3, scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction;

    public Score(int scoreID) {
        this.scoreID = scoreID;
    }

    public Score(double scoreD1, double scoreD2, double scoreD3, double scoreD4, double scoreA1, double scoreA2, double scoreA3, double scoreE1, double scoreE2, double scoreE3, double technicalDeduction, int gymnastID) {

        this.scoreD1 = scoreD1;
        this.scoreD2 = scoreD2;
        this.scoreD3 = scoreD3;
        this.scoreD4 = scoreD4;
        this.scoreA1 = scoreA1;
        this.scoreA2 = scoreA2;
        this.scoreA3 = scoreA3;
        this.scoreE1 = scoreE1;
        this.scoreE2 = scoreE2;
        this.scoreE3 = scoreE3;
        this.gymnastID = gymnastID;
        this.technicalDeduction = technicalDeduction;
    }

    public Score(double scoreD1, double scoreD2, double scoreD3, double scoreD4, double scoreA1, double scoreA2, double scoreA3, double scoreE1, double scoreE2, double scoreE3, double technicalDeduction, int gymnastID, int judgeID) {

        this.scoreD1 = scoreD1;
        this.scoreD2 = scoreD2;
        this.scoreD3 = scoreD3;
        this.scoreD4 = scoreD4;
        this.scoreA1 = scoreA1;
        this.scoreA2 = scoreA2;
        this.scoreA3 = scoreA3;
        this.scoreE1 = scoreE1;
        this.scoreE2 = scoreE2;
        this.scoreE3 = scoreE3;
        this.gymnastID = gymnastID;
        this.technicalDeduction = technicalDeduction;
        this.judgeID = judgeID;
    }

    public double getScoreD3() {
        return scoreD3;
    }

    public void setScoreD3(double scoreD3) {
        this.scoreD3 = scoreD3;
    }

    public double getScoreD4() {
        return scoreD4;
    }

    public void setScoreD4(double scoreD4) {
        this.scoreD4 = scoreD4;
    }

    public int getScoreID() {
        return scoreID;
    }

    public void setScoreID(int scoreID) {
        this.scoreID = scoreID;
    }

    public int getJudgeID() {
        return judgeID;
    }

    public void setJudgeID(int judgeID) {
        this.judgeID = judgeID;
    }

    public double getScoreD1() {
        return scoreD1;
    }

    public void setScoreD1(double scoreD1) {
        this.scoreD1 = scoreD1;
    }

    public double getScoreD2() {
        return scoreD2;
    }

    public void setScoreD2(double scoreD2) {
        this.scoreD2 = scoreD2;
    }

    public double getScoreA1() {
        return scoreA1;
    }

    public void setScoreA1(double scoreA1) {
        this.scoreA1 = scoreA1;
    }

    public double getScoreA2() {
        return scoreA2;
    }

    public void setScoreA2(double scoreA2) {
        this.scoreA2 = scoreA2;
    }

    public double getScoreA3() {
        return scoreA3;
    }

    public void setScoreA3(double scoreA3) {
        this.scoreA3 = scoreA3;
    }

    public double getScoreE1() {
        return scoreE1;
    }

    public void setScoreE1(double scoreE1) {
        this.scoreE1 = scoreE1;
    }

    public double getScoreE2() {
        return scoreE2;
    }

    public void setScoreE2(double scoreE2) {
        this.scoreE2 = scoreE2;
    }

    public double getScoreE3() {
        return scoreE3;
    }

    public void setScoreE3(double scoreE3) {
        this.scoreE3 = scoreE3;
    }

    public double getTechnicalDeduction() {
        return technicalDeduction;
    }

    public void setTechnicalDeduction(double technicalDeduction) {
        this.technicalDeduction = technicalDeduction;
    }

    public double getAverageD1andD2() {
        if (scoreD1 == 0) {
            return scoreD2;
        } else if (scoreD2 == 0) {
            return scoreD1;
        } else {
            return (scoreD1 + scoreD2) / 2;
        }
    }

    public double getAverageD3andD4() {

        if (scoreD3 == 0) {
            return scoreD4;
        } else if (scoreD4 == 0) {
            return scoreD3;
        } else {
            return (scoreD3 + scoreD4) / 2;
        }

    }

    public double totalScoreD() {
        return getAverageD1andD2() + getAverageD3andD4();
    }

    public double getMiddleAScoreA() {

        if (scoreA1 == 0 && scoreA2 == 0) {
            return scoreA3;
        } else if (scoreA1 == 0 && scoreA3 == 0) {
            return scoreA2;
        } else if (scoreA2 == 0 && scoreA3 == 0) {
            return scoreA1;
        } else {

            double[] aScores = {scoreA1, scoreA2, scoreA3};
            Arrays.sort(aScores);
            int middleIndex = aScores.length / 2;

            return aScores[middleIndex];
        }
    }

    public double getMiddleEScore() {

        if (scoreE1 == 0 && scoreE2 == 0) {
            return scoreE3;
        } else if (scoreE1 == 0 && scoreE3 == 0) {
            return scoreE2;
        } else if (scoreE2 == 0 && scoreE3 == 0) {
            return scoreE1;
        } else {

            double[] aScores = {scoreE1, scoreE2, scoreE3};
            Arrays.sort(aScores);
            int middleIndex = aScores.length / 2;
            return aScores[middleIndex];
        }
    }

    public double getTotalDplusE() {

        return getMiddleEScore() + getMiddleAScoreA();
    }

    public String getTotalScore() {
        return String.format("%.2f", totalScoreD() + 10 - getMiddleEScore() + 10 - getMiddleAScoreA());
    }

    public double getFinalScore() {

        return Double.parseDouble(getTotalScore()) - getTechnicalDeduction();
    }

    public int getGymnastID() {
        return gymnastID;
    }

    public void setGymnastID(int gymnastID) {
        this.gymnastID = gymnastID;
    }

}
