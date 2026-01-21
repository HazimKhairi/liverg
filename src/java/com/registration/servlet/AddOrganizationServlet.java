package com.registration.servlet;

import com.connection.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

public class AddOrganizationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String teamName = request.getParameter("teamName");
        String orgUsername = request.getParameter("orgUsername");
        String orgPassword = request.getParameter("orgPassword");
        String staffIDStr = request.getParameter("staffID");

        JSONObject jsonResponse = new JSONObject();

        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;

        try {
            int staffID = Integer.parseInt(staffIDStr);

            // First insert a default coach entry (required due to foreign key)
            String coachIC = "ORG_" + System.currentTimeMillis();
            pstm = con.prepareStatement("INSERT INTO COACH (coachIC, fisioIC, coachName, coachPOD, fisioName, fisioPOD) VALUES (?, '-', '-', '-', '-', '-')");
            pstm.setString(1, coachIC);
            pstm.executeUpdate();
            pstm.close();

            // Then insert the team/organization
            String sql = "INSERT INTO TEAM (teamName, coachIC, orgUsername, orgPassword, orgStatus, createdBy) VALUES (?, ?, ?, ?, 'active', ?)";
            pstm = con.prepareStatement(sql);
            pstm.setString(1, teamName);
            pstm.setString(2, coachIC);
            pstm.setString(3, orgUsername);
            pstm.setString(4, orgPassword);
            pstm.setInt(5, staffID);

            int result = pstm.executeUpdate();

            if (result > 0) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Organization added successfully");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Failed to add organization");
            }

        } catch (SQLException e) {
            Logger.getLogger(AddOrganizationServlet.class.getName()).log(Level.SEVERE, null, e);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error: " + e.getMessage());
        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Invalid staff ID");
        } finally {
            try {
                if (pstm != null) pstm.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        out.print(jsonResponse.toString());
    }
}
