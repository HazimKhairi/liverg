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

public class ListTeamServlet extends HttpServlet {

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
            pstm = con.prepareStatement("SELECT * FROM COACH C JOIN TEAM T ON C.COACHIC = T.COACHIC");
            rs = pstm.executeQuery();

            // Convert ResultSet to JSON
            JSONArray jsonArray = new JSONArray();
            while (rs.next()) {
                JSONObject obj = new JSONObject();
                obj.put("coachIC", rs.getString("coachIC"));
                obj.put("fisioIC", rs.getString("fisioIC"));
                obj.put("coachName", rs.getString("coachName"));
                obj.put("coachPOD", rs.getString("coachPOD"));
                obj.put("fisioName", rs.getString("fisioName"));
                obj.put("fisioPOD", rs.getString("fisioPOD"));
                obj.put("teamName", rs.getString("teamName"));
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
