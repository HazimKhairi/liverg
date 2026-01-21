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
import com.query.scoring.QueryKeyInScore;
import com.scoring.bean.Judge;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class KeyInScoreDAO extends QueryKeyInScore {

    DBConnect db = new DBConnect();

    public String getAllGymnast() {
        return "SELECT * FROM gymnast g LEFT JOIN composite c ON c.gymnastID = g.gymnastID  LEFT JOIN team t ON c.teamID = t.teamID JOIN apparatus ap ON c.apparatusID = ap.apparatusID WHERE c.scoreID is null";
    }

    public String getScoreByGymnastID() {
        return "SELECT * FROM gymnast g LEFT JOIN composite c ON c.gymnastID = g.gymnastID  LEFT JOIN team t ON c.teamID = t.teamID JOIN apparatus ap ON c.apparatusID = ap.apparatusID WHERE c.scoreID is null AND a.apparatusID = ? AND g.gymnastID = ? ;";
    }

    public String insertNewScoreGymnast() {
        return "INSERT INTO `score`( `scoreD1`, `scoreD2`,`scoreD3`,`scoreD4`,`scoreA1`, `scoreA2`, `scoreA3`, `scoreE1`, `scoreE2`, `scoreE3`, `technicalDeduction`, `gymnastID`,`judgeID`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
    }

    public String getAllJudge() {
        return "SELECT * FROM judge";
    }

    //gymnastID
    public String getLiveScoreByGymnastID() {
        return "SELECT * FROM gymnast g LEFT JOIN composite c ON c.gymnastID = g.gymnastID  LEFT JOIN team t ON c.teamID = t.teamID JOIN apparatus ap ON c.apparatusID = ap.apparatusID WHERE c.scoreID is null AND g.gymnastID = ?;";
    }

    public String getLiveScoreByTeamID() {
        return "SELECT * FROM gymnast g LEFT JOIN composite c ON c.gymnastID = g.gymnastID  LEFT JOIN team t ON c.teamID = t.teamID JOIN apparatus ap ON c.apparatusID = ap.apparatusID WHERE c.scoreID is null AND t.teamID = ?";
    }

    public String getLiveScoreByApparatuSID() {
        return "SELECT * FROM gymnast g LEFT JOIN composite c ON c.gymnastID = g.gymnastID  LEFT JOIN team t ON c.teamID = t.teamID JOIN apparatus ap ON c.apparatusID = ap.apparatusID WHERE c.scoreID is null AND ap.apparatusID = ?";
    }

       public String getLiveScoreByCategory() {
        return "SELECT * FROM composite c JOIN apparatus a ON c.apparatusID = a.apparatusID JOIN gymnast g ON c.gymnastID = g.gymnastID JOIN TEAM t ON c.teamID = t.teamID WHERE g.gymnastCategory = ? AND c.scoreID is null;";
    }
       
    public String getLiveScoreByGymnastIDAndTeamID() {
        return "SELECT * FROM gymnast g LEFT JOIN composite c ON c.gymnastID = g.gymnastID  LEFT JOIN team t ON c.teamID = t.teamID JOIN apparatus ap ON c.apparatusID = ap.apparatusID WHERE c.scoreID is null AND g.gymnastID = ? AND t.teamID = ?";
    }

    public String getLiveScoreByGymnastIDAndApparatusID() {
        return "SELECT * FROM gymnast g LEFT JOIN composite c ON c.gymnastID = g.gymnastID  LEFT JOIN team t ON c.teamID = t.teamID JOIN apparatus ap ON c.apparatusID = ap.apparatusID WHERE c.scoreID is null AND g.gymnastID = ? AND ap.apparatusID = ?";
    }

    public String getLiveScoreByTeamIDAndApparatusID() {
        return "SELECT * FROM gymnast g LEFT JOIN composite c ON c.gymnastID = g.gymnastID  LEFT JOIN team t ON c.teamID = t.teamID JOIN apparatus ap ON c.apparatusID = ap.apparatusID WHERE c.scoreID is null AND t.teamID = ? AND ap.apparatusID = ?";
    }

    public String getAllLiveScoreFilter() {
        return "SELECT * FROM gymnast g LEFT JOIN composite c ON c.gymnastID = g.gymnastID  LEFT JOIN team t ON c.teamID = t.teamID JOIN apparatus ap ON c.apparatusID = ap.apparatusID WHERE c.scoreID is null AND g.gymnastID = ? AND t.teamID AND ap.apparatusID = ? ";
    }

    public List<Composite> getAllDataLiveScore() {

        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getAllGymnast())) {
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                int gymnastID = rs.getInt("gymnastID");
                int apparatusID = rs.getInt("apparatusID");
                String gymnastName = rs.getString("gymnastName");
                String gymnastCategory = rs.getString("gymnastCategory");
                String teamName = rs.getString("teamName");
                String apparatusName = rs.getString("apparatusName");
                int teamID = rs.getInt("teamID");

//                score.add(new Score(scoreD1, scoreD2,scoreD3,scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction,gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName, gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));

            }
        } catch (SQLException e) {
            printSQLException(e);
        }

        return liveScoreData;
    }

    public List<Composite> getAllDataLiveScoreByGymnastID(int gymnastID) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByGymnastID())) {

            pst.setInt(1, gymnastID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                int apparatusID = rs.getInt("apparatusID");
                String gymnastName = rs.getString("gymnastName");
                String gymnastCategory = rs.getString("gymnastCategory");
                String teamName = rs.getString("teamName");
                String apparatusName = rs.getString("apparatusName");
                int teamID = rs.getInt("teamID");

//                score.add(new Score(scoreD1, scoreD2,scoreD3,scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction,gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName, gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));

            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }

    public List<Composite> getAllDataLiveScoreByTeamID(int teamID) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByTeamID())) {

            pst.setInt(1, teamID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int gymnastID = rs.getInt("gymnastID");
                int compositeID = rs.getInt("compositeID");
                int apparatusID = rs.getInt("apparatusID");
                String gymnastName = rs.getString("gymnastName");
                String gymnastCategory = rs.getString("gymnastCategory");
                String teamName = rs.getString("teamName");
                String apparatusName = rs.getString("apparatusName");

//                score.add(new Score(scoreD1, scoreD2,scoreD3,scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction,gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName, gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }

    public List<Composite> getAllDataLiveScoreByApparatusID(int apparatusID) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByApparatuSID())) {

            pst.setInt(1, apparatusID);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int gymnastID = rs.getInt("gymnastID");
                int compositeID = rs.getInt("compositeID");
                int teamID = rs.getInt("teamID");
                String gymnastName = rs.getString("gymnastName");
                String gymnastCategory = rs.getString("gymnastCategory");
                String teamName = rs.getString("teamName");
                String apparatusName = rs.getString("apparatusName");

//                score.add(new Score(scoreD1, scoreD2,scoreD3,scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction,gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName, gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }
    
            public List<Composite> getAllDataLiveScoreByCategoryName(String categoryName) {
        List<Composite> liveScoreData = new ArrayList<>();
        List<Score> score = new ArrayList<>();
        List<Gymnast> gymnast = new ArrayList<>();
        List<Apparatus> apparatus = new ArrayList<>();
        List<Team> team = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getLiveScoreByCategory())) {

            pst.setString(1, categoryName);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int compositeID = rs.getInt("compositeID");
                int gymnastID = rs.getInt("gymnastID");
                String gymnastName = rs.getString("gymnastName");
                  String gymnastCategory = rs.getString("gymnastCategory");
                int apparatusID =  rs.getInt("apparatusID");
                String apparatusName = rs.getString("apparatusName");
//                double scoreD1 = rs.getDouble("scoreD1");
//                double scoreD2 = rs.getDouble("scoreD2");
//                double scoreD3 = rs.getDouble("scoreD3");
//                double scoreD4 = rs.getDouble("scoreD4");
//                double scoreA1 = rs.getDouble("scoreA1");
//                double scoreA2 = rs.getDouble("scoreA2");
//                double scoreA3 = rs.getDouble("scoreA3");
//                double scoreE1 = rs.getDouble("scoreE1");
//                double scoreE2 = rs.getDouble("scoreE2");
//                double scoreE3 = rs.getDouble("scoreE3");
                int teamID = rs.getInt("teamID");
                String teamName = rs.getString("teamName");
//                double technicalDeduction = rs.getDouble("technicalDeduction");

//                score.add(new Score(scoreD1, scoreD2, scoreD3, scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction, gymnastID));
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
                String teamName = rs.getString("teamName");
                String apparatusName = rs.getString("apparatusName");

//                score.add(new Score(scoreD1, scoreD2,scoreD3,scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction,gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName, gymnastCategory));
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
                String teamName = rs.getString("teamName");
                String apparatusName = rs.getString("apparatusName");

//                score.add(new Score(scoreD1, scoreD2,scoreD3,scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction,gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName, gymnastCategory));
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
                String teamName = rs.getString("teamName");
                String apparatusName = rs.getString("apparatusName");

//                score.add(new Score(scoreD1, scoreD2,scoreD3,scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction,gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName, gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }

    public List<Composite> getAllLiveScoreFilter(int gymnastID, int teamID, int apparatusID) {
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
                String teamName = rs.getString("teamName");
                String apparatusName = rs.getString("apparatusName");

//                score.add(new Score(scoreD1, scoreD2,scoreD3,scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction,gymnastID));
                gymnast.add(new Gymnast(gymnastID, gymnastName, gymnastCategory));
                apparatus.add(new Apparatus(apparatusID, apparatusName));
                team.add(new Team(teamID, teamName));

                liveScoreData.add(new Composite(compositeID, score, gymnast, apparatus, team));
            }
        } catch (SQLException e) {

            printSQLException(e);
        }

        return liveScoreData;
    }

    public List<Score> getScoreID(int gymnastID) {

        List<Score> score = new ArrayList<>();
        try (Connection con2 = db.getConnection(); PreparedStatement pstScoreID = con2.prepareStatement("SELECT * FROM score ORDER BY scoreID DESC")) {


            ResultSet rs = pstScoreID.executeQuery();

            while (rs.next()) {

                int scoreID = rs.getInt("scoreID");
                score.add(new Score(scoreID));
            }

        } catch (SQLException e) {
            printSQLException(e);
        }

        return score;
    }

    public void UpdateCompositeScoreID(int gymnastID, int scoreID,int apparatusID) {
        try (Connection con3 = db.getConnection(); PreparedStatement pstUpdateComposite = con3.prepareStatement("UPDATE composite set scoreID = ? WHERE gymnastID = ? AND apparatusID = ?")) {

            pstUpdateComposite.setInt(1, scoreID);
            pstUpdateComposite.setInt(2, gymnastID);
            pstUpdateComposite.setInt(3, apparatusID);

            pstUpdateComposite.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public void insertDataScore(Score score, int gymnastID) {
        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(insertNewScoreGymnast())) {
            pst.setDouble(1, score.getScoreD1());
            pst.setDouble(2, score.getScoreD2());
            pst.setDouble(3, score.getScoreD3());
            pst.setDouble(4, score.getScoreD4());
            pst.setDouble(5, score.getScoreA1());
            pst.setDouble(6, score.getScoreA2());
            pst.setDouble(7, score.getScoreA3());
            pst.setDouble(8, score.getScoreE1());
            pst.setDouble(9, score.getScoreE2());
            pst.setDouble(10, score.getScoreE3());
            pst.setDouble(11, score.getTechnicalDeduction());
            pst.setInt(12, score.getGymnastID());
            pst.setInt(13, score.getJudgeID());
            pst.executeUpdate();

        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    public List<Judge> getAllJudges() {
        List<Judge> judge = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(getAllJudge())) {
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int judgeID = rs.getInt("judgeID");
                String judgeName = rs.getString("judgeName");
                String judgeNoIC = rs.getString("judgeNoIC");
                String judgePOD = rs.getString("judgePOD");

                judge.add(new Judge(judgeID, judgeName, judgeNoIC, judgePOD));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return judge;
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
