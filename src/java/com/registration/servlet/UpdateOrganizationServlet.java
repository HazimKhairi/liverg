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

public class UpdateOrganizationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String teamIDStr = request.getParameter("teamID");
        String teamName = request.getParameter("teamName");
        String orgUsername = request.getParameter("orgUsername");
        String orgPassword = request.getParameter("orgPassword");
        String orgStatus = request.getParameter("orgStatus");

        JSONObject jsonResponse = new JSONObject();

        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;

        try {
            int teamID = Integer.parseInt(teamIDStr);

            String sql = "UPDATE TEAM SET teamName = ?, orgUsername = ?, orgPassword = ?, orgStatus = ? WHERE teamID = ?";
            pstm = con.prepareStatement(sql);
            pstm.setString(1, teamName);
            pstm.setString(2, orgUsername);
            pstm.setString(3, orgPassword);
            pstm.setString(4, orgStatus);
            pstm.setInt(5, teamID);

            int result = pstm.executeUpdate();

            if (result > 0) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "Organization updated successfully");
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Failed to update organization");
            }

        } catch (SQLException e) {
            Logger.getLogger(UpdateOrganizationServlet.class.getName()).log(Level.SEVERE, null, e);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Database error: " + e.getMessage());
        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Invalid team ID");
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
