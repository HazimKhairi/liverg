/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.servlet.scoring;

import com.dao.scoring.KeyInScoreDAO;
import com.scoring.bean.Composite;
import com.scoring.bean.Judge;
import com.scoring.bean.Score;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author USER
 */
public class UpdateScoreServlet extends HttpServlet {


  private KeyInScoreDAO keyinscoredao;

    public void init() {
        keyinscoredao = new KeyInScoreDAO();
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        getAllScore(request,response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        double scoreD1 = Double.parseDouble(request.getParameter("scoreD1")); 
        double scoreD2 = Double.parseDouble(request.getParameter("scoreD2"));
        double scoreD3 = Double.parseDouble(request.getParameter("scoreD3")); 
        double scoreD4 = Double.parseDouble(request.getParameter("scoreD4"));
        double scoreA1 = Double.parseDouble(request.getParameter("scoreA1"));
        double scoreA2 = Double.parseDouble(request.getParameter("scoreA2"));
        double scoreA3 = Double.parseDouble(request.getParameter("scoreA3"));
        double scoreE1 = Double.parseDouble(request.getParameter("scoreE1")); 
        double scoreE2 = Double.parseDouble(request.getParameter("scoreE2"));
        double scoreE3 = Double.parseDouble(request.getParameter("scoreE3"));
        double technicalDeduction = Double.parseDouble(request.getParameter("technicalDeduction"));
        int judgeID = Integer.parseInt(request.getParameter("judgeID"));
        int gymnastID = Integer.parseInt(request.getParameter("gymnastID"));
        int apparatusID = Integer.parseInt(request.getParameter("apparatusID"));
        
        System.out.println("scoreD1: " + scoreD1);
System.out.println("scoreD2: " + scoreD2);
System.out.println("scoreD3: " + scoreD3);
System.out.println("scoreD4: " + scoreD4);
System.out.println("scoreA1: " + scoreA1);
System.out.println("scoreA2: " + scoreA2);
System.out.println("scoreA3: " + scoreA3);
System.out.println("scoreE1: " + scoreE1);
System.out.println("scoreE2: " + scoreE2);
System.out.println("scoreE3: " + scoreE3);
System.out.println("technicalDeduction: " + technicalDeduction);
System.out.println("judgeID: " + judgeID);
System.out.println("gymnastID: " + gymnastID);
System.out.println("apparatusID: " + apparatusID);
        
        Score score = new Score(scoreD1,scoreD2,scoreD3,scoreD4, scoreA1, scoreA2, scoreA3, scoreE1, scoreE2, scoreE3, technicalDeduction,gymnastID,judgeID);
        
        keyinscoredao.insertDataScore(score,gymnastID);
       List<Score> scoreID =  keyinscoredao.getScoreID(gymnastID);
       
        keyinscoredao.UpdateCompositeScoreID(gymnastID, scoreID.get(0).getScoreID(),apparatusID);
        
        response.sendRedirect("EventAdmin");
      
    }
   private void getAllScore(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       
       int apparatusID = Integer.parseInt(request.getParameter("apparatusID"));
       int gymnastID = Integer.parseInt(request.getParameter("gymnastID"));
//        List<Composite> livescoredata = keyinscoredao.getScoreAndGymnastName(apparatusID,gymnastID);
//        System.out.println("Data Live Score" + livescoredata);
        request.setAttribute("gymnastID", gymnastID);
            
        List<Judge> listjudge = keyinscoredao.getAllJudges();
        request.setAttribute("jury", listjudge);
       
        RequestDispatcher dispatcher = request.getRequestDispatcher("scoring/score.jsp");
     dispatcher.forward(request, response);
    }

}
