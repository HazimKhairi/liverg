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

public class DeleteTeamServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Get the coach IC from request parameters
        String coachIC = request.getParameter("coachIC");
JSONObject obj = new JSONObject();
        // Database Connection
        DBConnect db = new DBConnect();
        Connection con = db.getConnection();
        PreparedStatement pstmTeam = null;
        PreparedStatement pstmCoach = null;

        try {
            con.setAutoCommit(false); // Start transaction

            // Prepare and execute delete query for the TEAM table
            String queryTeam = "DELETE FROM TEAM WHERE coachIC = ?";
            pstmTeam = con.prepareStatement(queryTeam);
            pstmTeam.setString(1, coachIC);
            int rowsAffectedTeam = pstmTeam.executeUpdate();

            // Prepare and execute delete query for the COACH table
            String queryCoach = "DELETE FROM COACH WHERE coachIC = ?";
            pstmCoach = con.prepareStatement(queryCoach);
            pstmCoach.setString(1, coachIC);
            int rowsAffectedCoach = pstmCoach.executeUpdate();

            // Commit transaction
            con.commit();

            // Send response indicating success or failure
            PrintWriter out = response.getWriter();
            response.setContentType("text/plain");
            if (rowsAffectedTeam > 0 && rowsAffectedCoach > 0) {
                out.println("Team and Coach deleted successfully");
            } else if (rowsAffectedTeam > 0) {
                out.println("Team deleted successfully, but no Coach found to delete");
            } else if (rowsAffectedCoach > 0) {
                out.println("Coach deleted successfully, but no Team found to delete");
            } else {
                out.println("Failed to delete Team or Coach");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            // Send error response
            PrintWriter out = response.getWriter();
            response.setContentType("text/plain");

            // Check for foreign key constraint violation
            if (e.getMessage().contains("Cannot delete or update a parent row: a foreign key constraint fails") && e.getMessage().contains("CONSTRAINT `gymnast_ibfk_2` FOREIGN KEY (`teamID`) REFERENCES `team` (`teamID`)")) {
                out.println("Please delete gymnasts first.");
            } else {
                out.println("Internal server error: " + e.getMessage());
            }

            try {
                con.rollback(); // Rollback transaction in case of error
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            // Close resources
            try {
                if (pstmTeam != null) {
                    pstmTeam.close();
                }
                if (pstmCoach != null) {
                    pstmCoach.close();
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
