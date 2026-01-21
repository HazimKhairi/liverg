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
import org.json.simple.JSONObject;

public class DisplayClerkServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve clerkID from request parameter
        int clerkID = Integer.parseInt(request.getParameter("clerkID"));

        // Database Connection
        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            // Prepare query to select clerk information
            String query = "SELECT * FROM CLERK WHERE clerkID = ?";
            pstm = con.prepareStatement(query);
            pstm.setInt(1, clerkID);
            rs = pstm.executeQuery();

            // Check if clerk information was found
            if (rs.next()) {
                int retrievedClerkID = rs.getInt("clerkID");
                String clerkName = rs.getString("clerkName");
                String clerkUsername = rs.getString("clerkUsername");
                String clerkPassword = rs.getString("clerkPassword");

                JSONObject obj = new JSONObject();
                obj.put("clerkID", retrievedClerkID);
                obj.put("clerkName", clerkName);
                obj.put("clerkUsername", clerkUsername);
                obj.put("clerkPassword", clerkPassword);

                response.setContentType("application/json");

                PrintWriter out = response.getWriter();
                out.print(obj.toString());
            } else {
                // Clerk not found, send appropriate response
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
