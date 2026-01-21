/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.registration.servlet;

import com.connection.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.json.simple.JSONObject;

/**
 *
 * @author USER
 */
public class UpdateEventServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        int eventID = Integer.parseInt(request.getParameter("updateEventID"));
        String eventName = request.getParameter("updateName");
        String eventDate = request.getParameter("updateEventDate");

        // Database Connection
        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;

        try {
            
            String query = "UPDATE EVENT SET eventName = ?, eventDate = ? WHERE eventID = ?";
            pstm = con.prepareStatement(query);
            pstm.setString(1, eventName);
            pstm.setString(2, eventDate);
            pstm.setInt(3, eventID);
            int rowsAffected = pstm.executeUpdate();

            // Send JSON response indicating success or failure
            JSONObject obj = new JSONObject();
            if (rowsAffected > 0) {
                obj.put("success", true);
                obj.put("message", "Head Judge updated successfully");
            } else {
                obj.put("success", false);
                obj.put("message", "Failed to update headjudge");
            }

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(obj.toJSONString());
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            // Close resources
            try {
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
