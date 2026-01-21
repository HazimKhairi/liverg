/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.registration.servlet;

import com.registration.bean.headJudge;
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
public class AddHeadJudgeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        JSONArray list = new JSONArray();

        String userid = request.getParameter("userid");
        int staffID = Integer.parseInt(userid);
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String confirmpassword = request.getParameter("confirmpassword");

        JSONObject obj = new JSONObject();

        headJudge headjudge = new headJudge();

        String msg = "";

        try {
            headjudge.addHeadJudge(username,name,password,staffID);

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
