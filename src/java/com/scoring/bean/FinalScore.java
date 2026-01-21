package com.scoring.bean;

import java.sql.Timestamp;

public class FinalScore {

    private int finalScoreID;
    private int sessionID;
    private double scoreDifficultyBody;
    private double scoreDifficultyApparatus;
    private double scoreDTotal;
    private double scoreArtistic;
    private double scoreExecution;
    private double technicalDeduction;
    private double lineDeduction;
    private double timeDeduction;
    private double finalScore;
    private Timestamp calculatedAt;

    public FinalScore() {
    }

    public FinalScore(int sessionID) {
        this.sessionID = sessionID;
    }

    public int getFinalScoreID() {
        return finalScoreID;
    }

    public void setFinalScoreID(int finalScoreID) {
        this.finalScoreID = finalScoreID;
    }

    public int getSessionID() {
        return sessionID;
    }

    public void setSessionID(int sessionID) {
        this.sessionID = sessionID;
    }

    public double getScoreDifficultyBody() {
        return scoreDifficultyBody;
    }

    public void setScoreDifficultyBody(double scoreDifficultyBody) {
        this.scoreDifficultyBody = scoreDifficultyBody;
    }

    public double getScoreDifficultyApparatus() {
        return scoreDifficultyApparatus;
    }

    public void setScoreDifficultyApparatus(double scoreDifficultyApparatus) {
        this.scoreDifficultyApparatus = scoreDifficultyApparatus;
    }

    public double getScoreDTotal() {
        return scoreDTotal;
    }

    public void setScoreDTotal(double scoreDTotal) {
        this.scoreDTotal = scoreDTotal;
    }

    public double getScoreArtistic() {
        return scoreArtistic;
    }

    public void setScoreArtistic(double scoreArtistic) {
        this.scoreArtistic = scoreArtistic;
    }

    public double getScoreExecution() {
        return scoreExecution;
    }

    public void setScoreExecution(double scoreExecution) {
        this.scoreExecution = scoreExecution;
    }

    public double getTechnicalDeduction() {
        return technicalDeduction;
    }

    public void setTechnicalDeduction(double technicalDeduction) {
        this.technicalDeduction = technicalDeduction;
    }

    public double getLineDeduction() {
        return lineDeduction;
    }

    public void setLineDeduction(double lineDeduction) {
        this.lineDeduction = lineDeduction;
    }

    public double getTimeDeduction() {
        return timeDeduction;
    }

    public void setTimeDeduction(double timeDeduction) {
        this.timeDeduction = timeDeduction;
    }

    public double getFinalScore() {
        return finalScore;
    }

    public void setFinalScore(double finalScore) {
        this.finalScore = finalScore;
    }

    public Timestamp getCalculatedAt() {
        return calculatedAt;
    }

    public void setCalculatedAt(Timestamp calculatedAt) {
        this.calculatedAt = calculatedAt;
    }

    public double getTotalDeductions() {
        return technicalDeduction + lineDeduction + timeDeduction;
    }

    public String getFormattedFinalScore() {
        return String.format("%.3f", finalScore);
    }

    public String getFormattedDTotal() {
        return String.format("%.3f", scoreDTotal);
    }

    public String getFormattedArtistic() {
        return String.format("%.3f", scoreArtistic);
    }

    public String getFormattedExecution() {
        return String.format("%.3f", scoreExecution);
    }
}
