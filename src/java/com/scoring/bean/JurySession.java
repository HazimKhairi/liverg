package com.scoring.bean;

import java.sql.Timestamp;

public class JurySession {

    public static final String STATUS_WAITING = "WAITING";
    public static final String STATUS_SCORING = "SCORING";
    public static final String STATUS_SUBMITTED = "SUBMITTED";
    public static final String STATUS_FINALIZED = "FINALIZED";

    private int sessionID;
    private int eventID;
    private int startListID;
    private String sessionStatus;
    private Timestamp startedAt;
    private Timestamp submittedAt;
    private Timestamp finalizedAt;
    private Timestamp createdAt;

    // Related data for display
    private StartListEntry startListEntry;
    private String gymnastName;
    private String apparatusName;
    private String teamName;
    private int gymnastID;
    private int apparatusID;

    public JurySession() {
        this.sessionStatus = STATUS_WAITING;
    }

    public JurySession(int sessionID, int eventID, int startListID, String sessionStatus) {
        this.sessionID = sessionID;
        this.eventID = eventID;
        this.startListID = startListID;
        this.sessionStatus = sessionStatus;
    }

    public int getSessionID() {
        return sessionID;
    }

    public void setSessionID(int sessionID) {
        this.sessionID = sessionID;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public int getStartListID() {
        return startListID;
    }

    public void setStartListID(int startListID) {
        this.startListID = startListID;
    }

    public String getSessionStatus() {
        return sessionStatus;
    }

    public void setSessionStatus(String sessionStatus) {
        this.sessionStatus = sessionStatus;
    }

    public Timestamp getStartedAt() {
        return startedAt;
    }

    public void setStartedAt(Timestamp startedAt) {
        this.startedAt = startedAt;
    }

    public Timestamp getSubmittedAt() {
        return submittedAt;
    }

    public void setSubmittedAt(Timestamp submittedAt) {
        this.submittedAt = submittedAt;
    }

    public Timestamp getFinalizedAt() {
        return finalizedAt;
    }

    public void setFinalizedAt(Timestamp finalizedAt) {
        this.finalizedAt = finalizedAt;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public StartListEntry getStartListEntry() {
        return startListEntry;
    }

    public void setStartListEntry(StartListEntry startListEntry) {
        this.startListEntry = startListEntry;
    }

    public String getGymnastName() {
        return gymnastName;
    }

    public void setGymnastName(String gymnastName) {
        this.gymnastName = gymnastName;
    }

    public String getApparatusName() {
        return apparatusName;
    }

    public void setApparatusName(String apparatusName) {
        this.apparatusName = apparatusName;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
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

    public boolean isWaiting() {
        return STATUS_WAITING.equals(sessionStatus);
    }

    public boolean isScoring() {
        return STATUS_SCORING.equals(sessionStatus);
    }

    public boolean isSubmitted() {
        return STATUS_SUBMITTED.equals(sessionStatus);
    }

    public boolean isFinalized() {
        return STATUS_FINALIZED.equals(sessionStatus);
    }
}
