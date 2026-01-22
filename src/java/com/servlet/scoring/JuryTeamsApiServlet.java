package com.servlet.scoring;

import com.connection.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class JuryTeamsApiServlet extends HttpServlet {

    private DBConnect db = new DBConnect();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject result = new JSONObject();

        try {
            // Fetch all teams
            String sql = "SELECT teamID, teamName FROM TEAM ORDER BY teamName";

            JSONArray teamsArray = new JSONArray();

            try (Connection con = db.getConnection();
                 PreparedStatement pst = con.prepareStatement(sql)) {
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
                    JSONObject team = new JSONObject();
                    team.put("teamID", rs.getInt("teamID"));
                    team.put("teamName", rs.getString("teamName"));
                    teamsArray.add(team);
                }
            }

            result.put("success", true);
            result.put("teams", teamsArray);

        } catch (SQLException e) {
            result.put("success", false);
            result.put("error", e.getMessage());
            e.printStackTrace();
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(result.toJSONString());
        }
    }
}
