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

public class DeleteJudgeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    int judgeID = Integer.parseInt(request.getParameter("judgeID"));
JSONObject obj = new JSONObject();
DBConnect db = new DBConnect();
Connection con = db.getConnection();
PreparedStatement pstm = null;

try {
    String query = "DELETE FROM JUDGE WHERE judgeID = ?";
    pstm = con.prepareStatement(query);
    pstm.setInt(1, judgeID);
    int rowsAffected = pstm.executeUpdate();

    obj.put("success", rowsAffected > 0);
    obj.put("message", rowsAffected > 0 ? "Judge deleted successfully" : "Failed to delete Judge");
    
} catch (SQLException e) {
    e.printStackTrace();
    obj.put("success", false);
    obj.put("message", "Error deleting Judge: " + e.getMessage());
    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
} finally {
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

response.setContentType("application/json");
response.getWriter().write(obj.toString());
    }
}
