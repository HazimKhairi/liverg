package com.servlet.scoring;

import com.registration.bean.Gymnast;
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
            String scope = request.getParameter("scope");
            String sql;

            if ("all".equals(scope)) {
                // Get ALL gymnasts
                sql = "SELECT g.gymnastID, g.gymnastName, g.gymnastCategory as category, g.gymnastSchool as school, t.teamName "
                        +
                        "FROM GYMNAST g " +
                        "LEFT JOIN TEAM t ON g.teamID = t.teamID " +
                        "ORDER BY g.gymnastName";
            } else {
                // Get gymnasts that are registered for this event via gymnast_app
                int eventID = Integer.parseInt(request.getParameter("eventID"));
                sql = "SELECT DISTINCT g.gymnastID, g.gymnastName, g.gymnastCategory as category, g.gymnastSchool as school, t.teamName "
                        +
                        "FROM GYMNAST g " +
                        "JOIN TEAM t ON g.teamID = t.teamID " +
                        "JOIN GYMNAST_APP ga ON g.gymnastID = ga.gymnastID " +
                        "WHERE ga.eventID = " + eventID + " " +
                        "ORDER BY g.gymnastName";
            }

            JSONArray gymnastsArray = new JSONArray();

            try (Connection con = db.getConnection();
                    PreparedStatement pst = con.prepareStatement(sql)) {

                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
                    JSONObject gymnast = new JSONObject();
                    gymnast.put("gymnastID", rs.getInt("gymnastID"));
                    gymnast.put("gymnastName", rs.getString("gymnastName"));
                    gymnast.put("category", rs.getString("category"));
                    gymnast.put("school", rs.getString("school"));
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject result = new JSONObject();

        try {
            String gymnastName = request.getParameter("gymnastName");
            String gymnastIC = request.getParameter("gymnastIC");
            String gymnastCategory = request.getParameter("gymnastCategory");
            String gymnastSchool = request.getParameter("gymnastSchool");

            // Handle teamID (can be ID or new Name)
            String teamParam = request.getParameter("teamID");
            int teamID;
            try {
                teamID = Integer.parseInt(teamParam);
            } catch (NumberFormatException e) {
                // It's a new team name (or existing name passed as string)
                teamID = getOrCreateTeamID(teamParam);
            }

            int eventID = Integer.parseInt(request.getParameter("eventID"));

            // apparatusID might be null or empty if we are just creating a gymnast without
            // assigning to a specific apparatus yet.
            // But the current flow in startListManage.jsp seems to pass it.
            // If it's passed as "", parse int will fail.
            String apparatusParam = request.getParameter("apparatusID");
            int apparatusID = 0;
            if (apparatusParam != null && !apparatusParam.isEmpty() && !apparatusParam.equals("undefined")) {
                try {
                    apparatusID = Integer.parseInt(apparatusParam);
                } catch (NumberFormatException e) {
                    // Try to get or create if it's a new apparatus name
                    com.dao.scoring.StartListDAO startListDAO = new com.dao.scoring.StartListDAO();
                    apparatusID = startListDAO.getOrCreateApparatusID(apparatusParam);
                }
            }

            Gymnast gymnast = new Gymnast();
            // Use "-" for gymnastICPic since we don't handle file upload here
            int gymnastID = gymnast.addGymnast(gymnastName, gymnastIC, "-", gymnastSchool, gymnastCategory, teamID);

            if (gymnastID > 0) {
                // Only link if apparatusID is valid (>0)
                if (apparatusID > 0) {
                    gymnast.addGymnastApp(gymnastID, apparatusID, eventID);
                    gymnast.addComposite(gymnastID, teamID, apparatusID, eventID);
                }

                result.put("success", true);
                result.put("gymnastID", gymnastID);
            } else {
                result.put("success", false);
                result.put("error", "Failed to add gymnast");
            }

        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
            e.printStackTrace();
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(result.toJSONString());
        }
    }

    private int getOrCreateTeamID(String teamName) {
        int teamID = -1;
        try (Connection con = db.getConnection()) {
            // Check if exists
            String checkSql = "SELECT teamID FROM TEAM WHERE teamName = ?";
            try (PreparedStatement pst = con.prepareStatement(checkSql)) {
                pst.setString(1, teamName);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    return rs.getInt("teamID");
                }
            }

            // Insert
            String insertSql = "INSERT INTO TEAM (teamName, coachIC) VALUES (?, ?)";
            try (PreparedStatement pst = con.prepareStatement(insertSql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
                pst.setString(1, teamName);
                pst.setString(2, "-"); // Default value for coachIC
                pst.executeUpdate();
                try (ResultSet generatedKeys = pst.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        teamID = generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return teamID;
    }
}
