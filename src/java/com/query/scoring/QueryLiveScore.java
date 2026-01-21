/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.query.scoring;

/**
 *
 * @author USER
 */
public abstract class QueryLiveScore {
    public abstract String getAllLiveScore();
    public abstract String getLiveScoreByGymnastID();
    public abstract String getLiveScoreByTeamID();
    public abstract String getLiveScoreByApparatuSID();
    public abstract String getLiveScoreByGymnastIDAndTeamID();
    public abstract String getLiveScoreByGymnastIDAndApparatusID();
    public abstract String getLiveScoreByTeamIDAndApparatusID();
    public abstract String getAllLiveScoreFilter();
    public abstract String getAllTeam();
     public abstract String getAllGymnast();
     
    
    
}
