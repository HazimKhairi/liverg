/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.scoring.bean;

/**
 *
 * @author USER
 */
public class Gymnast {

    int gymnastID, staffID, teamID;
    String gymnastIC, gymnastICPic, gymnastName,gymnastSchool, gymnastCategory;

    public Gymnast(String gymnastName) {
        this.gymnastName = gymnastName;
    }

    public Gymnast(int gymnastID, String gymnastName) {
        this.gymnastName = gymnastName;
        this.gymnastID = gymnastID;
    }

    public Gymnast(int gymnastID, String gymnastName, String gymnastCategory) {
        this.gymnastName = gymnastName;
        this.gymnastID = gymnastID;
        this.gymnastCategory = gymnastCategory;
    }
    
     public Gymnast(int gymnastID, String gymnastName,String gymnastIC,String gymnastSchool, String gymnastCategory) {
        this.gymnastName = gymnastName;
        this.gymnastID = gymnastID;
        this.gymnastCategory = gymnastCategory;
        this.gymnastSchool = gymnastSchool;
        this.gymnastIC = gymnastIC;
    }

    public Gymnast(int gymnastID, int staffID, int teamID, String gymnastIC, String gymnastICPic, String gymnastName, String gymnastCategory) {
        this.gymnastID = gymnastID;
        this.staffID = staffID;
        this.teamID = teamID;
        this.gymnastIC = gymnastIC;
        this.gymnastICPic = gymnastICPic;
        this.gymnastName = gymnastName;
        this.gymnastCategory = gymnastCategory;
    }

    public String getGymnastSchool() {
        return gymnastSchool;
    }

    public void setGymnastSchool(String gymnastSchool) {
        this.gymnastSchool = gymnastSchool;
    }

    
    public int getGymnastID() {
        return gymnastID;
    }

    public void setGymnastID(int gymnastID) {
        this.gymnastID = gymnastID;
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public String getGymnastIC() {
        return gymnastIC;
    }

    public void setGymnastIC(String gymnastIC) {
        this.gymnastIC = gymnastIC;
    }

    public String getGymnastICPic() {
        return gymnastICPic;
    }

    public void setGymnastICPic(String gymnastICPic) {
        this.gymnastICPic = gymnastICPic;
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

}
