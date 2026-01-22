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

public class JuryApparatusApiServlet extends HttpServlet {

    private DBConnect db = new DBConnect();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject result = new JSONObject();

        try {
            int eventID = Integer.parseInt(request.getParameter("eventID"));

            // Get apparatus that are used in this event via gymnast_app
            String sql = "SELECT DISTINCT a.apparatusID, a.apparatusName " +
                        "FROM APPARATUS a " +
                        "JOIN GYMNAST_APP ga ON a.apparatusID = ga.apparatusID " +
                        "WHERE ga.eventID = ? " +
                        "ORDER BY a.apparatusName";

            JSONArray apparatusArray = new JSONArray();

            try (Connection con = db.getConnection();
                 PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setInt(1, eventID);
                ResultSet rs = pst.executeQuery();

                while (rs.next()) {
                    JSONObject app = new JSONObject();
                    app.put("apparatusID", rs.getInt("apparatusID"));
                    app.put("apparatusName", rs.getString("apparatusName"));
                    apparatusArray.add(app);
                }
            }

            result.put("success", true);
            result.put("apparatus", apparatusArray);

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
