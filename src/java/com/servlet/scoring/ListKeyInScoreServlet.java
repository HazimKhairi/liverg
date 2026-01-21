/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet.scoring;

import com.dao.scoring.KeyInScoreDAO;
import com.dao.scoring.LiveScoreDAO;
import com.scoring.bean.Composite;
import com.scoring.bean.Judge;
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
public class ListKeyInScoreServlet extends HttpServlet {

    private KeyInScoreDAO keyinscoredao;

    public void init() {
        keyinscoredao = new KeyInScoreDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("test page score");

        }
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
        String categoryName = request.getParameter("categoryName");

        if (gymnastID != 0 && teamID == 0 && apparatusID == 0) {
            List<Composite> livescoredata = keyinscoredao.getAllDataLiveScoreByGymnastID(gymnastID);
            System.out.println("Data Live Score" + livescoredata);
            request.setAttribute("listScoreboard", livescoredata);
        } else if (gymnastID == 0 && teamID != 0 && apparatusID == 0) {
            List<Composite> livescoredata = keyinscoredao.getAllDataLiveScoreByTeamID(teamID);
            System.out.println("Data Live Score" + livescoredata);
            request.setAttribute("listScoreboard", livescoredata);
        } else if (gymnastID == 0 && teamID == 0 && apparatusID != 0) {
            List<Composite> livescoredata = keyinscoredao.getAllDataLiveScoreByApparatusID(apparatusID);
            System.out.println("Data Live Score" + livescoredata);
            request.setAttribute("listScoreboard", livescoredata);
        } else if (gymnastID != 0 && teamID != 0 && apparatusID == 0) {
            List<Composite> livescoredata = keyinscoredao.getAllDataLiveScoreByGymnastIDAndTeamID(gymnastID, teamID);
            System.out.println("Data Live Score" + livescoredata);
            request.setAttribute("listScoreboard", livescoredata);
        } else if (gymnastID == 0 && teamID == 0 && apparatusID != 0) {
            List<Composite> livescoredata = keyinscoredao.getLiveScoreByTeamIDAndApparatusID(teamID, apparatusID);
            System.out.println("Data Live Score" + livescoredata);
            request.setAttribute("listScoreboard", livescoredata);
        } else if (gymnastID != 0 && teamID != 0 && apparatusID != 0) {
            List<Composite> livescoredata = keyinscoredao.getAllLiveScoreFilter(gymnastID, teamID, apparatusID);
            System.out.println("Data Live Score" + livescoredata);
            request.setAttribute("listScoreboard", livescoredata);
        }else if(gymnastID == 0 && teamID == 0 && apparatusID == 0 && !categoryName.equals("")){
            List<Composite> livescoredata = keyinscoredao.getAllDataLiveScoreByCategoryName(categoryName);
        System.out.println("Data Live Score" + livescoredata);
        request.setAttribute("listScoreboard", livescoredata);
        } else {
            List<Composite> livescoredata = keyinscoredao.getAllDataLiveScore();
            System.out.println("Data Live Score" + livescoredata);
            request.setAttribute("listScoreboard", livescoredata);
        }

        List<Composite> listGymnast = keyinscoredao.getAllDataLiveScore();
        request.setAttribute("listGymnast", listGymnast);

        List<Composite> listTeam = keyinscoredao.getAllDataLiveScore();
        request.setAttribute("listTeam", listTeam);

        List<Composite> listApparatus = keyinscoredao.getAllDataLiveScore();
        request.setAttribute("listApparatus", listApparatus);
        
         List<Composite> listCategory = keyinscoredao.getAllDataLiveScore();
        request.setAttribute("listCategory", listCategory);
        
            List<Judge> listjudge = keyinscoredao.getAllJudges();
        request.setAttribute("judge", listjudge);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("scoring/score.jsp");
        dispatcher.forward(request, response);
    }

    private void getAllScore(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Composite> livescoredata = keyinscoredao.getAllDataLiveScoreByCategoryName("");
        request.setAttribute("listScoreboard", livescoredata);
        System.out.println(livescoredata);
        
            List<Judge> listjudge = keyinscoredao.getAllJudges();
        request.setAttribute("judge", listjudge);

        List<Composite> listGymnast = keyinscoredao.getAllDataLiveScore();
        request.setAttribute("listGymnast", listGymnast);

        List<Composite> listTeam = keyinscoredao.getAllDataLiveScore();
        request.setAttribute("listTeam", listTeam);

        List<Composite> listApparatus = keyinscoredao.getAllDataLiveScore();
        request.setAttribute("listApparatus", listApparatus);

        List<Composite> listCategory = keyinscoredao.getAllDataLiveScore();
        request.setAttribute("listCategory", listCategory);
        
        request.setAttribute("categoryName", "no");

        ZonedDateTime currentDateTime = ZonedDateTime.now(ZoneId.of("UTC"));
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("d MMM yyyy - hh:mm a 'UTC'");
        String formattedDateTime = currentDateTime.format(formatter);
        request.setAttribute("datetime", formattedDateTime);
        System.out.println("Date : " + formattedDateTime);

        RequestDispatcher dispatcher = request.getRequestDispatcher("scoring/score.jsp");
        dispatcher.forward(request, response);
    }

}
