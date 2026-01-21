package com.scoring.bean;

public class JudgePositionType {

    private int positionTypeID;
    private String positionCode;
    private String positionName;
    private int panelNumber;
    private String category;
    private double scoreMin;
    private double scoreMax;
    private boolean isRequired;
    private int displayOrder;

    public JudgePositionType() {
    }

    public JudgePositionType(int positionTypeID, String positionCode, String positionName,
                             int panelNumber, String category) {
        this.positionTypeID = positionTypeID;
        this.positionCode = positionCode;
        this.positionName = positionName;
        this.panelNumber = panelNumber;
        this.category = category;
    }

    public JudgePositionType(int positionTypeID, String positionCode, String positionName,
                             int panelNumber, String category, double scoreMin, double scoreMax,
                             boolean isRequired, int displayOrder) {
        this.positionTypeID = positionTypeID;
        this.positionCode = positionCode;
        this.positionName = positionName;
        this.panelNumber = panelNumber;
        this.category = category;
        this.scoreMin = scoreMin;
        this.scoreMax = scoreMax;
        this.isRequired = isRequired;
        this.displayOrder = displayOrder;
    }

    public int getPositionTypeID() {
        return positionTypeID;
    }

    public void setPositionTypeID(int positionTypeID) {
        this.positionTypeID = positionTypeID;
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

    public int getPanelNumber() {
        return panelNumber;
    }

    public void setPanelNumber(int panelNumber) {
        this.panelNumber = panelNumber;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getScoreMin() {
        return scoreMin;
    }

    public void setScoreMin(double scoreMin) {
        this.scoreMin = scoreMin;
    }

    public double getScoreMax() {
        return scoreMax;
    }

    public void setScoreMax(double scoreMax) {
        this.scoreMax = scoreMax;
    }

    public boolean isIsRequired() {
        return isRequired;
    }

    public void setIsRequired(boolean isRequired) {
        this.isRequired = isRequired;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }
}
