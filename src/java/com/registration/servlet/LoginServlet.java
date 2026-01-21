package com.registration.servlet;

import com.registration.bean.Clerk;
import com.registration.bean.Staff;
import com.registration.bean.Team;
import com.registration.bean.headJudge;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/* @AUTHOR MUHAMMAD IRFAN */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        JSONArray list = new JSONArray();

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        JSONObject obj = new JSONObject();

        Clerk clerk = new Clerk();
        Staff staff = new Staff();
        Team team = new Team();
        headJudge headjudge = new headJudge();

        String msg = "";
        String userRole = "";

        try {
            int staffID = staff.StoreStaffID(username, password);
            int clerkID = clerk.StoreClerkID(username, password);
            int headjudgeID = headjudge.StoreHeadID(username, password);
            int teamID = team.StoreTeamIDByOrg(username, password);

            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("password", password);

            // Check for Super Admin login first
            if (staff.superAdminLogin(username, password)) {
                msg = "4";
                userRole = "superadmin";
                session.setAttribute("staffID", staffID);
                session.setAttribute("staffRole", "superadmin");
                obj.put("staffID", staffID);
                obj.put("staffRole", "superadmin");

            // Check for Organization login
            } else if (team.orgLogin(username, password)) {
                msg = "5";
                userRole = "organization";
                session.setAttribute("teamID", teamID);
                obj.put("teamID", teamID);

            // Check for regular staff login
            } else if (staff.staffLogin(username, password)) {
                msg = "1";
                userRole = "staff";
                session.setAttribute("staffID", staffID);
                obj.put("staffID", staffID);

            } else if (clerk.clerkLogin(username, password)) {
                msg = "2";
                userRole = "clerk";
                session.setAttribute("clerkID", clerkID);
                obj.put("clerkID", clerkID);
            } else if (headjudge.headjudgeLogin(username, password)) {
                msg = "3";
                userRole = "headjudge";
                session.setAttribute("headjudgeID", headjudgeID);
                obj.put("headjudgeID", headjudgeID);
            } else {
                userRole = "";
            }
            session.setAttribute("userRole", userRole);

            obj.put("msg", msg);
            obj.put("userRole", userRole);
            list.add(obj);
            out.println(list.toJSONString());

        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}