/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet.scoring;

import com.dao.scoring.ListEventDAO;
import com.dao.scoring.LiveScoreDAO;
import com.scoring.bean.Composite;
import com.scoring.bean.Event;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 *
 * @author USER
 */
public class LiveIndividualScoreServlet extends HttpServlet {

    private LiveScoreDAO livescoredao;

    public void init() {
        livescoredao = new LiveScoreDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        getAllScore(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

        int gymnastID = Integer.parseInt(request.getParameter("gymnastID"));
        int teamID = Integer.parseInt(request.getParameter("teamID"));
        int apparatusID = Integer.parseInt(request.getParameter("apparatusID"));
        int eventID = Integer.parseInt(request.getParameter("eventID"));
        String categoryName = request.getParameter("categoryName");

        if (gymnastID != 0) {
            List<Composite> livescoredata = livescoredao.getAllDataLiveScoreByGymnastID(gymnastID,eventID);

            request.setAttribute("listScoreboard", livescoredata);
        } else if (teamID != 0) {
            List<Composite> livescoredata = livescoredao.getAllDataLiveScoreByTeamID(teamID,eventID);
    
            request.setAttribute("listScoreboard", livescoredata);
        } else if ( apparatusID != 0) {
            List<Composite> livescoredata = livescoredao.getAllDataLiveScoreByApparatusID(apparatusID,eventID);

            request.setAttribute("listScoreboard", livescoredata);
        } else if ( !categoryName.equals("")) {
            List<Composite> livescoredata = livescoredao.getAllDataLiveScoreByCategoryName(categoryName,eventID);
 
            request.setAttribute("listScoreboard", livescoredata);
        } else {
            List<Composite> livescoredata = livescoredao.getAllDataLiveScore(eventID);
        
            request.setAttribute("listScoreboard", livescoredata);
        }

        List<Composite> listGymnast = livescoredao.getAllDataLiveScore(eventID);
        request.setAttribute("listGymnast", listGymnast);

        List<Composite> listTeam = livescoredao.getAllDataLiveScore(eventID);
        request.setAttribute("listTeam", listTeam);

        List<Composite> listApparatus = livescoredao.getAllDataLiveScore(eventID);
        request.setAttribute("listApparatus", listApparatus);

        List<Composite> listCategory = livescoredao.getAllDataLiveScore(eventID);
        request.setAttribute("listCategory", listCategory);
        
         ListEventDAO eventDAO = new ListEventDAO();
           
           List<Event> dataEvent = eventDAO.listEvent(eventID);
        request.setAttribute("dataEvent", dataEvent);

        request.setAttribute("categoryName", categoryName);
        request.setAttribute("gymnastID", gymnastID);
        request.setAttribute("teamID", teamID);
       
        ZonedDateTime currentDateTime = ZonedDateTime.now(ZoneId.of("Asia/Kuala_Lumpur"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d MMM yyyy - hh:mm a ");
        String formattedDateTime = currentDateTime.format(formatter);
        request.setAttribute("datetime", formattedDateTime);
        System.out.println("Date : "+formattedDateTime);
     
        RequestDispatcher dispatcher = request.getRequestDispatcher("scoring/scoreIndividualTable.jsp");
        dispatcher.forward(request, response);

        
    }

    private void getAllScore(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
           int eventID = Integer.parseInt(request.getParameter("eventID"));
           
           ListEventDAO eventDAO = new ListEventDAO();
           
           List<Event> dataEvent = eventDAO.listEvent(eventID);
           
        List<Composite> livescoredata = livescoredao.getAllDataLiveScoreByCategoryName("",eventID);
        request.setAttribute("listScoreboard", livescoredata);

        List<Composite> listGymnast = livescoredao.getAllDataLiveScore(eventID);
        request.setAttribute("listGymnast", listGymnast);

        List<Composite> listCategory = livescoredao.getAllDataLiveScore(eventID);
        request.setAttribute("listCategory", listCategory);

        List<Composite> listTeam = livescoredao.getAllDataLiveScore(eventID);
        request.setAttribute("listTeam", listTeam);

        List<Composite> listApparatus = livescoredao.getAllDataLiveScore(eventID);
        request.setAttribute("listApparatus", listApparatus);
        System.out.println(listApparatus);

        request.setAttribute("dataEvent", dataEvent);
        request.setAttribute("categoryName", "no");
          
        ZonedDateTime currentDateTime = ZonedDateTime.now(ZoneId.of("Asia/Kuala_Lumpur"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d MMM yyyy - hh:mm a ");
        String formattedDateTime = currentDateTime.format(formatter);
        request.setAttribute("datetime", formattedDateTime);
        System.out.println("Date : "+ formattedDateTime);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("scoring/scoreIndividualTable.jsp");
        dispatcher.forward(request, response);
    }

}
