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

public class DisplayTeamServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve clerkID from request parameter
        String coachIC = request.getParameter("coachIC");

        // Database Connection
        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            // Prepare query to select clerk information
            String query = "SELECT * FROM COACH C JOIN TEAM T ON C.COACHIC = T.COACHIC WHERE C.COACHIC = ?";
            pstm = con.prepareStatement(query);
            pstm.setString(1, coachIC);
            rs = pstm.executeQuery();

            // Check if clerk information was found
            if (rs.next()) {
                String retrievedCoachIC = rs.getString("coachIC");
                String fisioIC = rs.getString("fisioIC");
                String coachName = rs.getString("coachName");
                String coachPOD = rs.getString("coachPOD");
                String fisioName = rs.getString("fisioName");
                String teamName = rs.getString("teamName");
                String fisioPOD = rs.getString("fisioPOD");

                JSONObject obj = new JSONObject();
                obj.put("coachIC", retrievedCoachIC);
                obj.put("fisioIC", fisioIC);
                obj.put("coachName", coachName);
                obj.put("coachPOD", coachPOD);
                obj.put("fisioName", fisioName);
                obj.put("teamName", teamName);
                obj.put("fisioPOD", fisioPOD);

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
