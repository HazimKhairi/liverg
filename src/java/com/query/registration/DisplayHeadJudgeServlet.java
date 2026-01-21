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

public class DisplayHeadJudgeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve headjudgeID from request parameter
        int headjudgeID = Integer.parseInt(request.getParameter("headjudgeID"));

        // Database Connection
        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            // Prepare query to select headjudge information
            String query = "SELECT * FROM HEADJUDGE WHERE headjudgeID = ?";
            pstm = con.prepareStatement(query);
            pstm.setInt(1, headjudgeID);
            rs = pstm.executeQuery();

            // Check if headjudge information was found
            if (rs.next()) {
                int retrievedHeadjudgeID = rs.getInt("headjudgeID");
                String headName = rs.getString("headName");
                String headUsername = rs.getString("headUsername");
                String headPassword = rs.getString("headPassword");

                JSONObject obj = new JSONObject();
                obj.put("headjudgeID", retrievedHeadjudgeID);
                obj.put("headName", headName);
                obj.put("headUsername", headUsername);
                obj.put("headPassword", headPassword);

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
