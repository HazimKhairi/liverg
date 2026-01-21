/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.scoring.bean;

/**
 *
 * @author USER
 */
public class Event {
    int eventID,clerID;
    String eventName,eventDate;
    boolean hasJuryScreen;
    String juryAccessCode;

    public Event(int eventID, int clerID, String eventName, String eventDate) {
        this.eventID = eventID;
        this.clerID = clerID;
        this.eventName = eventName;
        this.eventDate = eventDate;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public int getClerID() {
        return clerID;
    }

    public void setClerID(int clerID) {
        this.clerID = clerID;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getEventDate() {
        return eventDate;
    }

    public void setEventDate(String eventDate) {
        this.eventDate = eventDate;
    }

    public boolean isHasJuryScreen() {
        return hasJuryScreen;
    }

    public void setHasJuryScreen(boolean hasJuryScreen) {
        this.hasJuryScreen = hasJuryScreen;
    }

    public String getJuryAccessCode() {
        return juryAccessCode;
    }

    public void setJuryAccessCode(String juryAccessCode) {
        this.juryAccessCode = juryAccessCode;
    }
}
