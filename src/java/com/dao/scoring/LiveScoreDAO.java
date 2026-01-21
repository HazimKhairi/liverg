/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao.scoring;

import com.scoring.bean.Apparatus;
import com.scoring.bean.Composite;
import com.scoring.bean.Gymnast;
import com.scoring.bean.Score;
import com.scoring.bean.Team;
import com.connection.DBConnect;
import com.query.scoring.QueryLiveScore;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author USER
 */
public class LiveScoreDAO extends QueryLiveScore{

    DBConnect db = new DBConnect();

    public String getAllLiveScore() {
        return "SELECT *, g.gymnastName AS gymnast_name\n" +
"FROM composite c\n" +
"JOIN apparatus a ON c.apparatusID = a.apparatusID\n" +
"JOIN gymnast g ON c.gymnastID = g.gymnastID\n" +
"JOIN TEAM t ON c.teamID = t.teamID\n" +
"JOIN score s ON c.scoreID = s.scoreID WHERE c.eventID = ?\n" +
"GROUP BY g.gymnastName, c.compositeID\n" +
"ORDER BY gymnast_name ASC;";
    }

    //gymnastID
    public String getLiveScoreByGymnastID() {
        return "SELECT * FROM composite c JOIN apparatus a ON c.apparatusID = a.apparatusID JOIN gymnast g ON c.gymnastID = g.gymnastID JOIN TEAM t ON c.teamID = t.teamID JOIN score s ON c.scoreID = s.scoreID WHERE g.gymnastID = ? AND c.eventID = ?;";
    }

    public String getLiveScoreByTeamID() {
        return "SELECT * FROM composite c JOIN apparatus a ON c.apparatusID = a.apparatusID JOIN gymnast g ON c.gymnastID = g.gymnastID JOIN TEAM t ON c.teamID = t.teamID JOIN score s ON c.scoreID = s.scoreID WHERE t.teamID = ? AND c.eventID = ?";
    }

    public String getLiveScoreByApparatuSID() {
        return "SELECT * FROM composite c JOIN apparatus a ON c.apparatusID = a.apparatusID JOIN gymnast g ON c.gymnastID = g.gymnastID JOIN TEAM t ON c.teamID = t.teamID JOIN score s ON c.scoreID = s.scoreID WHERE a.apparatusID = ? AND c.eventID = ?";
    }
    
      public String getLiveScoreByCategory() {
        return "SELECT * FROM composite c JOIN apparatus a ON c.apparatusID = a.apparatusID JOIN gymnast g ON c.gymnastID = g.gymnastID JOIN TEAM t ON c.teamID = t.teamID JOIN score s ON c.scoreID = s.scoreID WHERE g.gymnastCategory = ? AND c.eventID = ?";
    }

    public String getLiveScoreByGymnastIDAndTeamID() {
        return "SELECT * FROM composite c JOIN apparatus a ON c.apparatusID = a.apparatusID JOIN gymnast g ON c.gymnastID = g.gymnastID JOIN TEAM t ON c.teamID = t.teamID JOIN score s ON c.scoreID = s.scoreID WHERE g.gymnastID = ? AND t.teamID AND c.eventID = ?";
    }

    public String getLiveScoreByGymnastIDAndApparatusID() {
        return "SELECT * FROM composite c JOIN apparatus a ON c.apparatusID = a.apparatusID JOIN gymnast g ON c.gymnastID = g.gymnastID JOIN TEAM t ON c.teamID = t.teamID JOIN score s ON c.scoreID = s.scoreID WHERE g.gymnastID = ? AND a.apparatusID = ? AND c.eventID = ?";
    }

    public String getLiveScoreByTeamIDAndApparatusID() {
        return "SELECT * FROM composite c JOIN apparatus a ON c.apparatusID = a.apparatusID JOIN gymnast g ON c.gymnastID = g.gymnastID JOIN TEAM t ON c.teamID = t.teamID JOIN score s ON c.scoreID = s.scoreID WHERE t.teamID = ? AND a.apparatusID = ? AND c.eventID = ?";
    }

    public String getAllLiveScoreFilter() {
        return "SELECT * FROM composite c JOIN apparatus a ON c.apparatusID = a.apparatusID JOIN gymnast g ON c.gymnastID = g.gymnastID JOIN TEAM t ON c.teamID = t.teamID JOIN score s ON c.scoreID = s.scoreID WHERE g.gymnastID = ? AND t.teamID AND a.apparatusID = ? AND c.eventID = ? ";
    }

    public String getAllTeam() {
        return "SELECT * FROM team";
    }

    public String getAllGymnast() {
        return "SELECT * FROM gymnast";
    }

    public List<Composite> getAllDataLiveScore(int eventID) {

        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getAllLiveScore())) {
            
            pst.setInt(1,eventID );
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                int gymnastID = rs.getInt("gymnastID");
                String gymnastName = rs.getString("gymnastName");
                   String gymnastCategory = rs.getString("gymnastCategory");
                int teamID = rs.getInt("teamID");
                String teamName = rs.getString("teamName");
                int apparatusID = rs.getInt("apparatusID");
                String apparatusName = rs.getString("apparatusName");
                double scoreD1 = rs.getDouble("scoreD1");
                double scoreD2 = rs.getDouble("scoreD2");
                double scoreD3 = rs.getDouble("scoreD3");
                double scoreD4 = rs.getDouble("scoreD4");
                double scoreA1 = rs.getDouble("scoreA1");
                double scoreA2 = rs.getDouble("scoreA2");
                double scoreA3 = rs.getDouble("scoreA3");
                double scoreE1 = rs.getDouble("scoreE1");
                double scoreE2 = rs.getDouble("scoreE2");
                double scoreE3 = rs.getDouble("scoreE3");

                double technicalDeduction = rs.getDouble("technicalDeduction");

                score.add(new Score(scoreD1, scoreD2, scoreD3, scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction, gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName,gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));

            }
        } catch (SQLException e) {
            printSQLException(e);
        }

        return liveScoreData;
    }

    public List<Composite> getAllDataLiveScoreByGymnastID(int gymnastID,int eventID) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByGymnastID())) {

            pst.setInt(1, gymnastID);
            pst.setInt(2, eventID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                String gymnastName = rs.getString("gymnastName");
                          String gymnastCategory = rs.getString("gymnastCategory");
                String teamName = rs.getString("teamName");
                int apparatusID = rs.getInt("apparatusID");
                String apparatusName = rs.getString("apparatusName");
                double scoreD1 = rs.getDouble("scoreD1");
                double scoreD2 = rs.getDouble("scoreD2");
                double scoreD3 = rs.getDouble("scoreD3");
                double scoreD4 = rs.getDouble("scoreD4");
                double scoreA1 = rs.getDouble("scoreA1");
                double scoreA2 = rs.getDouble("scoreA2");
                double scoreA3 = rs.getDouble("scoreA3");
                double scoreE1 = rs.getDouble("scoreE1");
                double scoreE2 = rs.getDouble("scoreE2");
                double scoreE3 = rs.getDouble("scoreE3");
                int teamID = rs.getInt("teamID");
                double technicalDeduction = rs.getDouble("technicalDeduction");

                score.add(new Score(scoreD1, scoreD2, scoreD3, scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction, gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName,gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }

    public List<Composite> getAllDataLiveScoreByTeamID(int teamID,int eventID) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByTeamID())) {

            pst.setInt(1, teamID);
            pst.setInt(2, eventID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                int gymnastID = rs.getInt("gymnastID");
                int apparatusID = rs.getInt("apparatusID");
                String gymnastName = rs.getString("gymnastName");
                String gymnastCategory = rs.getString("gymnastCategory");
                String apparatusName = rs.getString("apparatusName");
                double scoreD1 = rs.getDouble("scoreD1");
                double scoreD2 = rs.getDouble("scoreD2");
                double scoreD3 = rs.getDouble("scoreD3");
                double scoreD4 = rs.getDouble("scoreD4");
                double scoreA1 = rs.getDouble("scoreA1");
                double scoreA2 = rs.getDouble("scoreA2");
                double scoreA3 = rs.getDouble("scoreA3");
                double scoreE1 = rs.getDouble("scoreE1");
                double scoreE2 = rs.getDouble("scoreE2");
                double scoreE3 = rs.getDouble("scoreE3");
                String teamName = rs.getString("teamName");
                double technicalDeduction = rs.getDouble("technicalDeduction");

                score.add(new Score(scoreD1, scoreD2, scoreD3, scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction, gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName,gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }

    public List<Composite> getAllDataLiveScoreByApparatusID(int apparatusID,int eventID) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByApparatuSID())) {

            pst.setInt(1, apparatusID);
            pst.setInt(2, eventID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                int gymnastID = rs.getInt("gymnastID");
                String gymnastName = rs.getString("gymnastName");
                  String gymnastCategory = rs.getString("gymnastCategory");
                String apparatusName = rs.getString("apparatusName");
                double scoreD1 = rs.getDouble("scoreD1");
                double scoreD2 = rs.getDouble("scoreD2");
                double scoreD3 = rs.getDouble("scoreD3");
                double scoreD4 = rs.getDouble("scoreD4");
                double scoreA1 = rs.getDouble("scoreA1");
                double scoreA2 = rs.getDouble("scoreA2");
                double scoreA3 = rs.getDouble("scoreA3");
                double scoreE1 = rs.getDouble("scoreE1");
                double scoreE2 = rs.getDouble("scoreE2");
                double scoreE3 = rs.getDouble("scoreE3");
                int teamID = rs.getInt("teamID");
                String teamName = rs.getString("teamName");
                double technicalDeduction = rs.getDouble("technicalDeduction");

                score.add(new Score(scoreD1, scoreD2, scoreD3, scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction, gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName,gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }
    
        public List<Composite> getAllDataLiveScoreByCategoryName(String categoryName,int eventID) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByCategory())) {

            pst.setString(1, categoryName);
            pst.setInt(2, eventID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                int gymnastID = rs.getInt("gymnastID");
                String gymnastName = rs.getString("gymnastName");
                  String gymnastCategory = rs.getString("gymnastCategory");
                int apparatusID =  rs.getInt("apparatusID");
                String apparatusName = rs.getString("apparatusName");
                double scoreD1 = rs.getDouble("scoreD1");
                double scoreD2 = rs.getDouble("scoreD2");
                double scoreD3 = rs.getDouble("scoreD3");
                double scoreD4 = rs.getDouble("scoreD4");
                double scoreA1 = rs.getDouble("scoreA1");
                double scoreA2 = rs.getDouble("scoreA2");
                double scoreA3 = rs.getDouble("scoreA3");
                double scoreE1 = rs.getDouble("scoreE1");
                double scoreE2 = rs.getDouble("scoreE2");
                double scoreE3 = rs.getDouble("scoreE3");
                int teamID = rs.getInt("teamID");
                String teamName = rs.getString("teamName");
                double technicalDeduction = rs.getDouble("technicalDeduction");

                score.add(new Score(scoreD1, scoreD2, scoreD3, scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction, gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName,gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }

    public List<Composite> getAllDataLiveScoreByGymnastIDAndTeamID(int gymnastID, int teamID) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByGymnastIDAndTeamID())) {

            pst.setInt(1, gymnastID);
            pst.setInt(2, teamID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                int apparatusID = rs.getInt("apparatusID");
                String gymnastName = rs.getString("gymnastName");
                  String gymnastCategory = rs.getString("gymnastCategory");
                String apparatusName = rs.getString("apparatusName");
                double scoreD1 = rs.getDouble("scoreD1");
                double scoreD2 = rs.getDouble("scoreD2");
                double scoreD3 = rs.getDouble("scoreD3");
                double scoreD4 = rs.getDouble("scoreD4");
                double scoreA1 = rs.getDouble("scoreA1");
                double scoreA2 = rs.getDouble("scoreA2");
                double scoreA3 = rs.getDouble("scoreA3");
                double scoreE1 = rs.getDouble("scoreE1");
                double scoreE2 = rs.getDouble("scoreE2");
                double scoreE3 = rs.getDouble("scoreE3");
                String teamName = rs.getString("teamName");
                double technicalDeduction = rs.getDouble("technicalDeduction");

                score.add(new Score(scoreD1, scoreD2, scoreD3, scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction, gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName,gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }

    public List<Composite> getAllDataLiveScoreByGymnastIDAndApparatusID(int gymnastID, int apparatusID) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByGymnastIDAndApparatusID())) {

            pst.setInt(1, gymnastID);
            pst.setInt(2, apparatusID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                int teamID = rs.getInt("teamID");
                String gymnastName = rs.getString("gymnastName");
                 String gymnastCategory = rs.getString("gymnastCategory");
                String apparatusName = rs.getString("apparatusName");
                double scoreD1 = rs.getDouble("scoreD1");
                double scoreD2 = rs.getDouble("scoreD2");
                double scoreD3 = rs.getDouble("scoreD3");
                double scoreD4 = rs.getDouble("scoreD4");
                double scoreA1 = rs.getDouble("scoreA1");
                double scoreA2 = rs.getDouble("scoreA2");
                double scoreA3 = rs.getDouble("scoreA3");
                double scoreE1 = rs.getDouble("scoreE1");
                double scoreE2 = rs.getDouble("scoreE2");
                double scoreE3 = rs.getDouble("scoreE3");
                String teamName = rs.getString("teamName");
                double technicalDeduction = rs.getDouble("technicalDeduction");

                score.add(new Score(scoreD1, scoreD2, scoreD3, scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction, gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName,gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }

    public List<Composite> getLiveScoreByTeamIDAndApparatusID(int teamID, int apparatusID) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByTeamIDAndApparatusID())) {

            pst.setInt(1, teamID);
            pst.setInt(2, apparatusID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                int gymnastID = rs.getInt("gymnastID");
                String gymnastName = rs.getString("gymnastName");
                  String gymnastCategory = rs.getString("gymnastCategory");
                String apparatusName = rs.getString("apparatusName");
                double scoreD1 = rs.getDouble("scoreD1");
                double scoreD2 = rs.getDouble("scoreD2");
                double scoreD3 = rs.getDouble("scoreD3");
                double scoreD4 = rs.getDouble("scoreD4");
                double scoreA1 = rs.getDouble("scoreA1");
                double scoreA2 = rs.getDouble("scoreA2");
                double scoreA3 = rs.getDouble("scoreA3");
                double scoreE1 = rs.getDouble("scoreE1");
                double scoreE2 = rs.getDouble("scoreE2");
                double scoreE3 = rs.getDouble("scoreE3");
                String teamName = rs.getString("teamName");
                double technicalDeduction = rs.getDouble("technicalDeduction");

                score.add(new Score(scoreD1, scoreD2, scoreD3, scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction, gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName,gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }
    
       public List<Composite> getAllLiveScoreFilter(int gymnastID,int teamID, int apparatusID) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getAllLiveScoreFilter())) {

            pst.setInt(1, gymnastID);
            pst.setInt(2, teamID);
            pst.setInt(3, apparatusID);
            
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                String gymnastName = rs.getString("gymnastName");
                  String gymnastCategory = rs.getString("gymnastCategory");
                String apparatusName = rs.getString("apparatusName");
                double scoreD1 = rs.getDouble("scoreD1");
                double scoreD2 = rs.getDouble("scoreD2");
                double scoreD3 = rs.getDouble("scoreD3");
                double scoreD4 = rs.getDouble("scoreD4");
                double scoreA1 = rs.getDouble("scoreA1");
                double scoreA2 = rs.getDouble("scoreA2");
                double scoreA3 = rs.getDouble("scoreA3");
                double scoreE1 = rs.getDouble("scoreE1");
                double scoreE2 = rs.getDouble("scoreE2");
                double scoreE3 = rs.getDouble("scoreE3");
                String teamName = rs.getString("teamName");
                double technicalDeduction = rs.getDouble("technicalDeduction");

                score.add(new Score(scoreD1, scoreD2, scoreD3, scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction, gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName,gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }
    

    public List<Gymnast> listAllGymnast(int eventID) {
        List<Gymnast> gyms = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getAllGymnast())) {
            pst.setInt(1, eventID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                String name = rs.getString("gymnastName");

                gyms.add(new Gymnast(name));
            }

        } catch (SQLException e) {
            printSQLException(e);
        }
        return gyms;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());

                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
