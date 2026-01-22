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

public class JuryGymnastsApiServlet extends HttpServlet {

    private DBConnect db = new DBConnect();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject result = new JSONObject();

        try {
            int eventID = Integer.parseInt(request.getParameter("eventID"));

            // Get gymnasts that are registered for this event via gymnast_app
            String sql = "SELECT DISTINCT g.gymnastID, g.gymnastName, g.gymnastCategory as category, t.teamName " +
                        "FROM GYMNAST g " +
                        "JOIN TEAM t ON g.teamID = t.teamID " +
                        "JOIN GYMNAST_APP ga ON g.gymnastID = ga.gymnastID " +
                        "WHERE ga.eventID = ? " +
                        "ORDER BY g.gymnastName";

            JSONArray gymnastsArray = new JSONArray();

            try (Connection con = db.getConnection();
                 PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setInt(1, eventID);
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
                    JSONObject gymnast = new JSONObject();
                    gymnast.put("gymnastID", rs.getInt("gymnastID"));
                    gymnast.put("gymnastName", rs.getString("gymnastName"));
                    gymnast.put("category", rs.getString("category"));
                    gymnast.put("teamName", rs.getString("teamName"));
                    gymnastsArray.add(gymnast);
                }
            }

            result.put("success", true);
            result.put("gymnasts", gymnastsArray);

        } catch (NumberFormatException e) {
            result.put("success", false);
            result.put("error", "Invalid event ID");
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
