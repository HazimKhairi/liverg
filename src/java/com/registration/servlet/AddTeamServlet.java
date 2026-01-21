/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.registration.servlet;

import com.registration.bean.Coach;
import com.registration.bean.Team;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Meow
 */
public class AddTeamServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        JSONArray list = new JSONArray();

        String coachIC = request.getParameter("coachIC");
        String fisioIC = request.getParameter("fisioIC");
        
        String coachName = request.getParameter("coachName");
        String coachPOD = request.getParameter("coachPOD");
        String fisioName = request.getParameter("fisioName");
        String teamName = request.getParameter("teamName");
        String fisioPOD = request.getParameter("fisioPOD");

        JSONObject obj = new JSONObject();

        Coach coach = new Coach();
        Team team = new Team();

        String msg = "";

        try {
            coach.addCoach(coachIC, fisioIC, coachName, coachPOD, fisioName, fisioPOD);
            team.addTeam(coachIC,teamName);

            msg = "1";
            obj.put("msg", msg);
            list.add(obj);
            out.println(list.toJSONString());
            
        } catch (SQLException ex) {
            msg = "2";
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
