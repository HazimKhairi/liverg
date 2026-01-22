package com.scoring.bean;

import java.sql.Timestamp;

public class StartListEntry {

    private int startListID;
    private int eventID;
    private int gymnastID;
    private int apparatusID;
    private int competitionDay;
    private int batchNumber;
    private int startOrder;
    private int randomSeed;
    private boolean isFinalized;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Related objects for display
    private String gymnastName;
    private String gymnastCategory;
    private String gymnastSchool;
    private String teamName;
    private String apparatusName;
    private int teamID;
    private double finalScore;

    public StartListEntry() {
    }

    public StartListEntry(int startListID, int eventID, int gymnastID, int apparatusID,
            int competitionDay, int batchNumber, int startOrder) {
        this.startListID = startListID;
        this.eventID = eventID;
        this.gymnastID = gymnastID;
        this.apparatusID = apparatusID;
        this.competitionDay = competitionDay;
        this.batchNumber = batchNumber;
        this.startOrder = startOrder;
    }

    public int getStartListID() {
        return startListID;
    }

    public void setStartListID(int startListID) {
        this.startListID = startListID;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public int getGymnastID() {
        return gymnastID;
    }

    public void setGymnastID(int gymnastID) {
        this.gymnastID = gymnastID;
    }

    public int getApparatusID() {
        return apparatusID;
    }

    public void setApparatusID(int apparatusID) {
        this.apparatusID = apparatusID;
    }

    public int getCompetitionDay() {
        return competitionDay;
    }

    public void setCompetitionDay(int competitionDay) {
        this.competitionDay = competitionDay;
    }

    public int getBatchNumber() {
        return batchNumber;
    }

    public void setBatchNumber(int batchNumber) {
        this.batchNumber = batchNumber;
    }

    public int getStartOrder() {
        return startOrder;
    }

    public void setStartOrder(int startOrder) {
        this.startOrder = startOrder;
    }

    public int getRandomSeed() {
        return randomSeed;
    }

    public void setRandomSeed(int randomSeed) {
        this.randomSeed = randomSeed;
    }

    public boolean isIsFinalized() {
        return isFinalized;
    }

    public void setIsFinalized(boolean isFinalized) {
        this.isFinalized = isFinalized;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getGymnastName() {
        return gymnastName;
    }

    public void setGymnastName(String gymnastName) {
        this.gymnastName = gymnastName;
    }

    public String getGymnastCategory() {
        return gymnastCategory;
    }

    public void setGymnastCategory(String gymnastCategory) {
        this.gymnastCategory = gymnastCategory;
    }

    public String getGymnastSchool() {
        return gymnastSchool;
    }

    public void setGymnastSchool(String gymnastSchool) {
        this.gymnastSchool = gymnastSchool;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public String getApparatusName() {
        return apparatusName;
    }

    public void setApparatusName(String apparatusName) {
        this.apparatusName = apparatusName;
    }

    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public double getFinalScore() {
        return finalScore;
    }

    public void setFinalScore(double finalScore) {
        this.finalScore = finalScore;
    }
}
