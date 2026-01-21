/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.query.registration;

import com.connection.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.simple.JSONObject;

/**
 *
 * @author USER
 */
public class DisplayEventServlet extends HttpServlet {

 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve headjudgeID from request parameter
        int eventID = Integer.parseInt(request.getParameter("eventID"));

        // Database Connection
        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            // Prepare query to select headjudge information
            String query = "SELECT * FROM EVENT WHERE eventID = ?";
            pstm = con.prepareStatement(query);
            pstm.setInt(1, eventID);
            rs = pstm.executeQuery();

            // Check if headjudge information was found
            if (rs.next()) {
                int retrievedEventID = rs.getInt("eventID");
                String eventName = rs.getString("eventName");
                String eventDate = rs.getString("eventDate");

                JSONObject obj = new JSONObject();
                obj.put("eventID", retrievedEventID);
                obj.put("eventName", eventName);
                obj.put("eventDate", eventDate);

                response.setContentType("application/json");

                PrintWriter out = response.getWriter();
                out.print(obj.toString());
            } else {
                // headjudge not found, send appropriate response
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            // Close resources
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
