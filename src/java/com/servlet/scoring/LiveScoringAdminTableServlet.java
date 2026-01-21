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
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author USER
 */
public class LiveScoringAdminTableServlet extends HttpServlet {

  
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
                int eventID = Integer.parseInt(request.getParameter("eventID"));
        int gymnastID = Integer.parseInt(request.getParameter("gymnastID")); 
        int teamID = Integer.parseInt(request.getParameter("teamID"));
        int apparatusID = Integer.parseInt(request.getParameter("apparatusID"));  
        String categoryName = request.getParameter("categoryName");
        
        if(gymnastID != 0 && teamID == 0 && apparatusID == 0){
        List<Composite> livescoredata = livescoredao.getAllDataLiveScoreByGymnastID(gymnastID,eventID);
        System.out.println("Data Live Score" + livescoredata);
        request.setAttribute("listScoreboard", livescoredata);
        }else if(gymnastID == 0 && teamID != 0 && apparatusID == 0){
         List<Composite> livescoredata = livescoredao.getAllDataLiveScoreByTeamID(teamID,eventID);
        System.out.println("Data Live Score" + livescoredata);
        request.setAttribute("listScoreboard", livescoredata);
        }else if(gymnastID == 0 && teamID == 0 && apparatusID != 0){
         List<Composite> livescoredata = livescoredao.getAllDataLiveScoreByApparatusID(apparatusID,eventID);
        System.out.println("Data Live Score" + livescoredata);
        request.setAttribute("listScoreboard", livescoredata);
        }else if(gymnastID != 0 && teamID != 0 && apparatusID == 0){
        List<Composite> livescoredata = livescoredao.getAllDataLiveScoreByGymnastIDAndTeamID(gymnastID, teamID);
        System.out.println("Data Live Score" + livescoredata);
        request.setAttribute("listScoreboard", livescoredata);
        }else if(gymnastID == 0 && teamID == 0 && apparatusID != 0){
         List<Composite> livescoredata = livescoredao.getLiveScoreByTeamIDAndApparatusID(teamID, apparatusID);
        System.out.println("Data Live Score" + livescoredata);
        request.setAttribute("listScoreboard", livescoredata);
        }else if(gymnastID != 0 && teamID != 0 && apparatusID != 0){
        List<Composite> livescoredata = livescoredao.getAllLiveScoreFilter(gymnastID, teamID, apparatusID);
        System.out.println("Data Live Score" + livescoredata);
        request.setAttribute("listScoreboard", livescoredata);
        }else if(gymnastID == 0 && teamID == 0 && apparatusID == 0 && !categoryName.equals("")){
            List<Composite> livescoredata = livescoredao.getAllDataLiveScoreByCategoryName(categoryName,eventID);
        System.out.println("Data Live Score" + livescoredata);
        request.setAttribute("listScoreboard", livescoredata);
        }else{
          List<Composite> livescoredata = livescoredao.getAllDataLiveScore(eventID);
        System.out.println("Data Live Score" + livescoredata);
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("scoring/scoreTableAdmin.jsp");
        dispatcher.forward(request, response);
        
          
        
    }

    private void getAllScore(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          int eventID = Integer.parseInt(request.getParameter("eventID"));
        int gymnastID = Integer.parseInt(request.getParameter("gymnastID"));
         List<Composite> livescoredata = livescoredao.getAllDataLiveScoreByGymnastID(gymnastID,eventID);
        request.setAttribute("listScoreboard", livescoredata);
        
        List<Composite> listGymnast = livescoredao.getAllDataLiveScore(eventID);
        request.setAttribute("listGymnast", listGymnast);
        
           List<Composite> listCategory = livescoredao.getAllDataLiveScore(eventID);
        request.setAttribute("listCategory", listCategory);
        
        List<Composite> listTeam = livescoredao.getAllDataLiveScore(eventID);
        request.setAttribute("listTeam", listTeam);
      ListEventDAO eventDAO = new ListEventDAO();
           
           List<Event> dataEvent = eventDAO.listEvent(eventID);
        request.setAttribute("dataEvent", dataEvent);
        List<Composite> listApparatus = livescoredao.getAllDataLiveScore(eventID);
        request.setAttribute("listApparatus", listApparatus);
        System.out.println(listApparatus);
        RequestDispatcher dispatcher = request.getRequestDispatcher("scoring/scoreTableAdmin.jsp");
        dispatcher.forward(request, response);
    }

}
