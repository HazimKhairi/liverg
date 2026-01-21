package com.query.registration;

import com.connection.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class ListOrganizationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;
        PreparedStatement pstmEvents = null;
        ResultSet rs = null;
        ResultSet rsEvents = null;

        try {
            pstm = con.prepareStatement("SELECT teamID, teamName, orgUsername, orgPassword, orgStatus, createdBy FROM TEAM ORDER BY teamID");
            rs = pstm.executeQuery();

            JSONArray jsonArray = new JSONArray();
            while (rs.next()) {
                JSONObject obj = new JSONObject();
                int teamID = rs.getInt("teamID");
                obj.put("teamID", teamID);
                obj.put("teamName", rs.getString("teamName"));
                obj.put("orgUsername", rs.getString("orgUsername"));
                obj.put("orgPassword", rs.getString("orgPassword"));
                obj.put("orgStatus", rs.getString("orgStatus"));
                obj.put("createdBy", rs.getInt("createdBy"));

                // Fetch assigned events for this organization
                JSONArray assignedEvents = new JSONArray();
                pstmEvents = con.prepareStatement("SELECT eventID, eventName, eventDate FROM EVENT WHERE teamID = ?");
                pstmEvents.setInt(1, teamID);
                rsEvents = pstmEvents.executeQuery();
                while (rsEvents.next()) {
                    JSONObject eventObj = new JSONObject();
                    eventObj.put("eventID", rsEvents.getInt("eventID"));
                    eventObj.put("eventName", rsEvents.getString("eventName"));
                    eventObj.put("eventDate", rsEvents.getString("eventDate"));
                    assignedEvents.add(eventObj);
                }
                rsEvents.close();
                pstmEvents.close();

                obj.put("assignedEvents", assignedEvents);
                jsonArray.add(obj);
            }

            out.print(jsonArray.toString());

        } catch (SQLException e) {
            e.printStackTrace();
            out.print("[]");
        } finally {
            try {
                if (rsEvents != null) rsEvents.close();
                if (pstmEvents != null) pstmEvents.close();
                if (rs != null) rs.close();
                if (pstm != null) pstm.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
