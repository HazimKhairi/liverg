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

public class DisplayGymnastServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Retrieve gymnastID from request parameter
        int gymnastID = Integer.parseInt(request.getParameter("gymnastID"));

        // Database Connection
        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstm = null;
        ResultSet rs = null;

        try {
            // Prepare query to select clerk information
            String query = "SELECT \n"
                    + "    G.gymnastID,\n"
                    + "    GA.eventID,\n"
                    + "    G.gymnastIC,\n"
                    + "    G.gymnastICPic,\n"
                    + "    G.gymnastName,\n"
                    + "    G.gymnastSchool,\n"
                    + "    G.gymnastCategory,\n"
                    + "    GROUP_CONCAT(A.APPARATUSNAME ORDER BY A.APPARATUSNAME SEPARATOR ', ') AS APPARATUS_LIST,\n"
                    + "    T.teamID\n"
                    + "FROM \n"
                    + "    GYMNAST G\n"
                    + "JOIN \n"
                    + "    GYMNAST_APP GA ON G.gymnastID = GA.gymnastID\n"
                    + "JOIN \n"
                    + "    APPARATUS A ON GA.APPARATUSID = A.APPARATUSID\n"
                    + "JOIN \n"
                    + "    TEAM T ON G.teamID = T.teamID\n"
                    + "WHERE \n"
                    + "    G.gymnastID = ?\n"
                    + "GROUP BY \n"
                    + "    G.gymnastID, GA.eventID, G.gymnastIC, G.gymnastICPic, G.gymnastName, G.gymnastSchool, G.gymnastCategory, T.teamID;";
            pstm = con.prepareStatement(query);
            pstm.setInt(1, gymnastID);
            rs = pstm.executeQuery();

            // Check if gymnast information was found
            if (rs.next()) {
                JSONObject obj = new JSONObject();
                obj.put("gymnastID", rs.getInt("gymnastID"));
                obj.put("gymnastIC", rs.getString("gymnastIC"));
                obj.put("gymnastICPic", rs.getString("gymnastICPic"));
                obj.put("gymnastName", rs.getString("gymnastName"));
                obj.put("gymnastSchool", rs.getString("gymnastSchool"));
                obj.put("gymnastCategory", rs.getString("gymnastCategory"));
                obj.put("apparatusList", rs.getString("APPARATUS_LIST"));
                obj.put("teamID", rs.getString("teamID"));
                obj.put("eventID", rs.getInt("eventID"));

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
