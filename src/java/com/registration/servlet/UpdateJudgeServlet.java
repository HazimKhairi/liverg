package com.registration.servlet;

import com.connection.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

public class UpdateJudgeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        int judgeID = Integer.parseInt(request.getParameter("updateJudgeID"));
        String updateJudgeIC = request.getParameter("updateJudgeIC");
        String updateJudgeName = request.getParameter("updateJudgeName");
        String updateJudgePOD = request.getParameter("updateJudgePOD");
        String updateJudgeTeam = request.getParameter("updateJudgeTeam");

        // Database Connection
        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;

        try {
            
            String query = "UPDATE JUDGE SET judgeName = ?, judgeNoIc = ?, judgePOD = ?, teamID = ? WHERE judgeID = ?";
            pstm = con.prepareStatement(query);
            pstm.setString(1, updateJudgeName);
            pstm.setString(2, updateJudgeIC);
            pstm.setString(3, updateJudgePOD);
            pstm.setString(4, updateJudgeTeam);
            pstm.setInt(5, judgeID);
            int rowsAffected = pstm.executeUpdate();

            // Send JSON response indicating success or failure
            JSONObject obj = new JSONObject();
            if (rowsAffected > 0) {
                obj.put("success", true);
                obj.put("message", "Clerk updated successfully");
            } else {
                obj.put("success", false);
                obj.put("message", "Failed to update clerk");
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
