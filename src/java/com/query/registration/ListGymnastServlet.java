package com.query.registration;

import com.connection.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class ListGymnastServlet extends HttpServlet {

 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
  response.setContentType("application/json");
  PrintWriter out = response.getWriter();

  // Database Connection
  DBConnect db = new DBConnect();
  Connection con = db.getConnection();
  PreparedStatement pstm = null;
  ResultSet rs = null;

  try {
   // Prepare and execute query to fetch data
   pstm = con.prepareStatement("SELECT \n" +
"    G.GYMNASTID,\n" +
"    GA.eventID,\n" +
"    E.eventName,\n" +
"    G.GYMNASTIC,\n" +
"    G.GYMNASTICPIC,\n" +
"    G.GYMNASTNAME,\n" +
"    G.GYMNASTSCHOOL,\n" +
"    G.GYMNASTCATEGORY,\n" +
"    GROUP_CONCAT(A.APPARATUSNAME ORDER BY A.APPARATUSNAME SEPARATOR ', ') AS APPARATUS_LIST,\n" +
"    T.TEAMNAME,\n" +
"    T.TEAMID\n" +
"FROM \n" +
"    GYMNAST G\n" +
"JOIN \n" +
"    GYMNAST_APP GA ON G.GYMNASTID = GA.GYMNASTID\n" +
"JOIN \n" +
"    APPARATUS A ON GA.APPARATUSID = A.APPARATUSID\n" +
"JOIN \n" +
"    TEAM T ON G.TEAMID = T.TEAMID\n" +
"JOIN \n" +
"    EVENT E ON GA.EVENTID = E.EVENTID\n" +
"GROUP BY \n" +
"    G.GYMNASTID, GA.eventID, E.eventName, G.GYMNASTIC, G.GYMNASTICPIC, G.GYMNASTNAME, G.GYMNASTSCHOOL, G.GYMNASTCATEGORY, T.TEAMNAME, T.TEAMID;");
   rs = pstm.executeQuery();

   // Convert ResultSet to JSON
   JSONArray jsonArray = new JSONArray();
   while (rs.next()) {
    JSONObject obj = new JSONObject();
    obj.put("gymnastID", rs.getInt("GYMNASTID"));
    obj.put("gymnastIC", rs.getString("GYMNASTIC"));
    obj.put("gymnastICPic", rs.getString("GYMNASTICPIC"));
    obj.put("gymnastName", rs.getString("GYMNASTNAME"));
    obj.put("gymnastSchool", rs.getString("GYMNASTSCHOOL"));
    obj.put("gymnastCategory", rs.getString("GYMNASTCATEGORY"));
    obj.put("apparatusList", rs.getString("APPARATUS_LIST"));
    obj.put("teamName", rs.getString("TEAMNAME"));
    obj.put("eventName",rs.getString("eventName"));
    jsonArray.add(obj);
   }

   // Send JSON response
   out.print(jsonArray.toString());

  } catch (SQLException e) {
   e.printStackTrace();
   out.print("Error fetching data from database.");
  } finally {
   // Close connections in finally block to ensure they are closed even if an exception occurs
   try {
    if (rs != null) {
     rs.close();
    }
    if (pstm != null) {
     pstm.close();
    }
    if (con != null) {
     con.close();
    }
   } catch (SQLException ex) {
    ex.printStackTrace();
   }
  }
 }
}
