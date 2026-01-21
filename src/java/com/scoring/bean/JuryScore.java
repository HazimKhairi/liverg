package com.scoring.bean;

import java.sql.Timestamp;

public class JuryScore {

    private int juryScoreID;
    private int sessionID;
    private int positionTypeID;
    private Double scoreValue;
    private Timestamp submittedAt;
    private boolean isOverridden;
    private Integer overriddenBy;
    private String overrideReason;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Related data for display
    private String positionCode;
    private String positionName;
    private String category;

    public JuryScore() {
    }

    public JuryScore(int sessionID, int positionTypeID, Double scoreValue) {
        this.sessionID = sessionID;
        this.positionTypeID = positionTypeID;
        this.scoreValue = scoreValue;
        this.submittedAt = new Timestamp(System.currentTimeMillis());
    }

    public JuryScore(int juryScoreID, int sessionID, int positionTypeID, Double scoreValue,
                     Timestamp submittedAt, boolean isOverridden) {
        this.juryScoreID = juryScoreID;
        this.sessionID = sessionID;
        this.positionTypeID = positionTypeID;
        this.scoreValue = scoreValue;
        this.submittedAt = submittedAt;
        this.isOverridden = isOverridden;
    }

    public int getJuryScoreID() {
        return juryScoreID;
    }

    public void setJuryScoreID(int juryScoreID) {
        this.juryScoreID = juryScoreID;
    }

    public int getSessionID() {
        return sessionID;
    }

    public void setSessionID(int sessionID) {
        this.sessionID = sessionID;
    }

    public int getPositionTypeID() {
        return positionTypeID;
    }

    public void setPositionTypeID(int positionTypeID) {
        this.positionTypeID = positionTypeID;
    }

    public Double getScoreValue() {
        return scoreValue;
    }

    public void setScoreValue(Double scoreValue) {
        this.scoreValue = scoreValue;
    }

    public Timestamp getSubmittedAt() {
        return submittedAt;
    }

    public void setSubmittedAt(Timestamp submittedAt) {
        this.submittedAt = submittedAt;
    }

    public boolean isIsOverridden() {
        return isOverridden;
    }

    public void setIsOverridden(boolean isOverridden) {
        this.isOverridden = isOverridden;
    }

    public Integer getOverriddenBy() {
        return overriddenBy;
    }

    public void setOverriddenBy(Integer overriddenBy) {
        this.overriddenBy = overriddenBy;
    }

    public String getOverrideReason() {
        return overrideReason;
    }

    public void setOverrideReason(String overrideReason) {
        this.overrideReason = overrideReason;
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

    public String getPositionCode() {
        return positionCode;
    }

    public void setPositionCode(String positionCode) {
        this.positionCode = positionCode;
    }

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public boolean hasScore() {
        return scoreValue != null && submittedAt != null;
    }
}
