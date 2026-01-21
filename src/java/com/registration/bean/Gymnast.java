package com.registration.bean;

import com.connection.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Gymnast bean class.
 */
public class Gymnast {

 // Database Connection
 DBConnect db = new DBConnect();
 Connection con = db.getConnection();
 // PreparedStatement
 PreparedStatement pstm;
 // ResultQuery
 ResultSet rs;
 String userRole = "";

 int gymnastID, clerkID, teamID,eventID;
 String gymnastIC, gymnastICPic, gymnastName, gymnastSchool, gymnastCategory;

 public Gymnast(){}
 public Gymnast(int gymnastID,String gymnastName) {
  this.gymnastID = gymnastID;
  this.gymnastName = gymnastName;
 }
 
 

 public Gymnast(int gymnastID, String gymnastIC, String gymnastICPic, String gymnastName, String gymnastSchool, String gymnastCategory, int clerkID, int teamID,int eventID) {
  this.gymnastID = gymnastID;
  this.gymnastIC = gymnastIC;
  this.gymnastICPic = gymnastICPic;
  this.gymnastName = gymnastName;
  this.gymnastSchool = gymnastSchool;
  this.gymnastCategory = gymnastCategory;
  this.clerkID = clerkID;
  this.teamID = teamID;
  this.eventID = eventID;
 }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }
 
 

  public Gymnast(int gymnastID,String gymnastName,String gymnastIC, String gymnastSchool, String gymnastCategory) {
  this.gymnastID = gymnastID;
  this.gymnastIC = gymnastIC;
  this.gymnastICPic = gymnastICPic;
  this.gymnastName = gymnastName;
  this.gymnastSchool = gymnastSchool;
  this.gymnastCategory = gymnastCategory;
  this.clerkID = clerkID;
  this.teamID = teamID;
 }
  
 public int getGymnastID() {
  return gymnastID;
 }

 public void setGymnastID(int gymnastID) {
  this.gymnastID = gymnastID;
 }

 public String getGymnastIC() {
  return gymnastIC;
 }

 public void setGymnastIC(String gymnastIC) {
  this.gymnastIC = gymnastIC;
 }

 public int getClerkID() {
  return clerkID;
 }

 public void setClerkID(int clerkID) {
  this.clerkID = clerkID;
 }

 public int getTeamID() {
  return teamID;
 }

 public void setTeamID(int teamID) {
  this.teamID = teamID;
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

 public String getGymnastSchool() {
  return gymnastSchool;
 }

 public void setGymnastSchool(String gymnastSchool) {
  this.gymnastSchool = gymnastSchool;
 }

 public String getGymnastCategory() {
  return gymnastCategory;
 }

 public void setGymnastCategory(String gymnastCategory) {
  this.gymnastCategory = gymnastCategory;
 }

 public int addGymnast(String gymnastName, String gymnastIC, String gymnastICPic, String gymnastSchool, String gymnastCategory, int teamID) throws SQLException {
  String sql = "INSERT INTO GYMNAST(gymnastName, gymnastIC, gymnastICPic, gymnastSchool, gymnastCategory, teamID) VALUES (?, ?, ?, ?, ?, ?)";
  pstm = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
  pstm.setString(1, gymnastName);
  pstm.setString(2, gymnastIC);
  pstm.setString(3, gymnastICPic);
  pstm.setString(4, gymnastSchool);
  pstm.setString(5, gymnastCategory);
  pstm.setInt(6, teamID);
  pstm.executeUpdate();

  // Retrieve the generated gymnastID
  ResultSet rs = pstm.getGeneratedKeys();
  if (rs.next()) {
   this.gymnastID = rs.getInt(1);
  }
  return this.gymnastID;
 }

 public void addGymnastApp(int gymnastID, int apparatusID,int eventID) throws SQLException {
  String sql = "INSERT INTO GYMNAST_APP(gymnastID, apparatusID,eventID) VALUES (?, ?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setInt(1, gymnastID);
  pstm.setInt(2, apparatusID);  
  pstm.setInt(3, eventID);
  pstm.executeUpdate();
 }
 
  public void addComposite(int gymnastID, int teamID, int apparatusID,int eventID) throws SQLException {
  String sql = "INSERT INTO COMPOSITE(gymnastID, teamID, apparatusID,eventID) VALUES (?, ?, ?,?)";
  pstm = con.prepareStatement(sql);
  pstm.setInt(1, gymnastID);
  pstm.setInt(2, teamID);
  pstm.setInt(3, apparatusID);
  pstm.setInt(4, eventID);
  pstm.executeUpdate();
 }
  
  
  public List<Gymnast> getAllDataGymnast() {
     String sql = "SELECT * FROM GYMNAST ORDER BY gymnastCategory";
        List<Gymnast> gymnast = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int gymnastID = rs.getInt("gymnastID");
                String gymnastName = rs.getString("gymnastName");
                String gymnastIC = rs.getString("gymnastIC");
                String gymnastSchool = rs.getString("gymnastSchool");
                String gymnastCategory = rs.getString("gymnastCategory");
                gymnast.add(new Gymnast(gymnastID, gymnastName, gymnastIC, gymnastSchool, gymnastCategory));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return gymnast;
    }
  
  public List<Gymnast> getDataGymnastID(String gymnastName) {
   
    String sql = "SELECT * FROM GYMNAST WHERE gymnastName = ?";
        List<Gymnast> gymnast = new ArrayList<>();

        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, gymnastName);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {

                gymnast.add(new Gymnast(rs.getInt("gymnastID"), gymnastName));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return gymnast;
    }
  
  public boolean checkApparatusDuplicate(int apparatusID, int gymnastID) {
   
   String sql = "SELECT * FROM COMPOSITE WHERE apparatusID = ? AND gymnastID = ?";
        boolean isDuplicate = false;
        try (Connection con = db.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, apparatusID);
            pst.setInt(2, gymnastID);
           
            ResultSet rs =  pst.executeQuery();
            
            isDuplicate = rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isDuplicate;
    }
}
