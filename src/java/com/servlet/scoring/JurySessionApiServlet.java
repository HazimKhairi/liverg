package com.servlet.scoring;

import com.dao.scoring.FinalScoreDAO;
import com.dao.scoring.JuryScoreDAO;
import com.dao.scoring.JurySessionDAO;
import com.dao.scoring.StartListDAO;
import com.scoring.bean.FinalScore;
import com.scoring.bean.JuryScore;
import com.scoring.bean.JurySession;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class JurySessionApiServlet extends HttpServlet {

    private JurySessionDAO sessionDAO = new JurySessionDAO();
    private JuryScoreDAO scoreDAO = new JuryScoreDAO();
    private FinalScoreDAO finalScoreDAO = new FinalScoreDAO();
    private StartListDAO startListDAO = new StartListDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        int eventID = 0;

        try {
            eventID = Integer.parseInt(request.getParameter("eventID"));
        } catch (NumberFormatException e) {
            sendError(response, "Invalid eventID");
            return;
        }

        JSONObject result = new JSONObject();

        if ("getState".equals(action)) {
            JurySession session = sessionDAO.getCurrentSession(eventID);
            if (session != null) {
                result.put("success", true);
                result.put("sessionID", session.getSessionID());
                result.put("sessionStatus", session.getSessionStatus());
                result.put("gymnastName", session.getGymnastName());
                result.put("apparatusName", session.getApparatusName());
                result.put("teamName", session.getTeamName());
                result.put("gymnastID", session.getGymnastID());
                result.put("apparatusID", session.getApparatusID());

                List<JuryScore> scores = scoreDAO.getScoresBySession(session.getSessionID());
                JSONArray scoresArray = new JSONArray();
                for (JuryScore score : scores) {
                    JSONObject scoreObj = new JSONObject();
                    scoreObj.put("positionCode", score.getPositionCode());
                    scoreObj.put("positionName", score.getPositionName());
                    scoreObj.put("category", score.getCategory());
                    scoreObj.put("scoreValue", score.getScoreValue());
                    scoreObj.put("hasScore", score.hasScore());
                    scoresArray.add(scoreObj);
                }
                result.put("scores", scoresArray);

                List<String> pending = scoreDAO.getPendingPositions(session.getSessionID(), eventID);
                JSONArray pendingArray = new JSONArray();
                pendingArray.addAll(pending);
                result.put("pendingPositions", pendingArray);

                List<String> submitted = scoreDAO.getSubmittedPositions(session.getSessionID());
                JSONArray submittedArray = new JSONArray();
                submittedArray.addAll(submitted);
                result.put("submittedPositions", submittedArray);

                if (session.isSubmitted() || session.isFinalized()) {
                    FinalScore finalScore = finalScoreDAO.getFinalScoreBySession(session.getSessionID());
                    if (finalScore != null) {
                        JSONObject finalScoreObj = new JSONObject();
                        finalScoreObj.put("scoreDTotal", finalScore.getScoreDTotal());
                        finalScoreObj.put("scoreArtistic", finalScore.getScoreArtistic());
                        finalScoreObj.put("scoreExecution", finalScore.getScoreExecution());
                        finalScoreObj.put("finalScore", finalScore.getFinalScore());
                        result.put("finalScore", finalScoreObj);
                    }
                }
            } else {
                result.put("success", true);
                result.put("sessionStatus", "NO_SESSION");
            }
        } else if ("getScoreForPosition".equals(action)) {
            String positionCode = request.getParameter("positionCode");
            int sessionID = Integer.parseInt(request.getParameter("sessionID"));

            JuryScore score = scoreDAO.getScoreByPositionCode(sessionID, positionCode);
            if (score != null) {
                result.put("success", true);
                result.put("hasScore", score.hasScore());
                result.put("scoreValue", score.getScoreValue());
            } else {
                result.put("success", true);
                result.put("hasScore", false);
            }
        } else {
            sendError(response, "Unknown action");
            return;
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(result.toJSONString());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        JSONObject result = new JSONObject();

        try {
            int eventID = Integer.parseInt(request.getParameter("eventID"));

            switch (action) {
                case "startScoring":
                    result = handleStartScoring(eventID);
                    break;

                case "submitScore":
                    String positionCode = request.getParameter("positionCode");
                    double scoreValue = Double.parseDouble(request.getParameter("scoreValue"));
                    int sessionID = Integer.parseInt(request.getParameter("sessionID"));
                    result = handleSubmitScore(eventID, sessionID, positionCode, scoreValue);
                    break;

                case "advanceGymnast":
                    result = handleAdvanceGymnast(eventID);
                    break;

                case "overrideScore":
                    int sID = Integer.parseInt(request.getParameter("sessionID"));
                    String pCode = request.getParameter("positionCode");
                    double newScore = Double.parseDouble(request.getParameter("scoreValue"));
                    int staffID = Integer.parseInt(request.getParameter("staffID"));
                    String reason = request.getParameter("reason");
                    result = handleOverrideScore(sID, pCode, newScore, staffID, reason);
                    break;

                default:
                    result.put("success", false);
                    result.put("error", "Unknown action");
            }
        } catch (NumberFormatException e) {
            result.put("success", false);
            result.put("error", "Invalid parameters: " + e.getMessage());
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", "Error: " + e.getMessage());
            e.printStackTrace();
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(result.toJSONString());
        }
    }

    private JSONObject handleStartScoring(int eventID) {
        JSONObject result = new JSONObject();

        JurySession session = sessionDAO.createOrGetCurrentSession(eventID);
        if (session == null) {
            var nextEntry = startListDAO.getNextUnscored(eventID);
            if (nextEntry == null) {
                result.put("success", false);
                result.put("error", "No gymnasts in start list");
                return result;
            }
            int sessionID = sessionDAO.createSession(eventID, nextEntry.getStartListID());
            session = sessionDAO.getSessionById(sessionID);
        }

        if (session.isWaiting()) {
            sessionDAO.startScoring(session.getSessionID());
            session = sessionDAO.getSessionById(session.getSessionID());
        }

        result.put("success", true);
        result.put("sessionID", session.getSessionID());
        result.put("sessionStatus", session.getSessionStatus());
        result.put("gymnastName", session.getGymnastName());
        result.put("apparatusName", session.getApparatusName());
        result.put("teamName", session.getTeamName());

        return result;
    }

    private JSONObject handleSubmitScore(int eventID, int sessionID, String positionCode, double scoreValue) {
        JSONObject result = new JSONObject();

        JurySession session = sessionDAO.getSessionById(sessionID);
        if (session == null || !session.isScoring()) {
            result.put("success", false);
            result.put("error", "No active scoring session");
            return result;
        }

        int scoreResult = scoreDAO.submitScoreByPositionCode(sessionID, positionCode, scoreValue);
        if (scoreResult > 0) {
            result.put("success", true);
            result.put("positionCode", positionCode);
            result.put("scoreValue", scoreValue);

            if (scoreDAO.areAllScoresSubmitted(sessionID, eventID)) {
                sessionDAO.submitSession(sessionID);
                finalScoreDAO.calculateAndSaveFinalScore(sessionID);
                result.put("allSubmitted", true);

                FinalScore finalScore = finalScoreDAO.getFinalScoreBySession(sessionID);
                if (finalScore != null) {
                    result.put("finalScore", finalScore.getFinalScore());
                }
            } else {
                result.put("allSubmitted", false);
            }
        } else {
            result.put("success", false);
            result.put("error", "Failed to submit score");
        }

        return result;
    }

    private JSONObject handleAdvanceGymnast(int eventID) {
        JSONObject result = new JSONObject();

        JurySession current = sessionDAO.getCurrentSession(eventID);
        if (current != null && !current.isFinalized()) {
            sessionDAO.finalizeSession(current.getSessionID());
        }

        boolean advanced = sessionDAO.advanceToNextGymnast(eventID);
        if (advanced) {
            JurySession newSession = sessionDAO.getCurrentSession(eventID);
            if (newSession != null) {
                sessionDAO.startScoring(newSession.getSessionID());
                newSession = sessionDAO.getSessionById(newSession.getSessionID());

                result.put("success", true);
                result.put("sessionID", newSession.getSessionID());
                result.put("sessionStatus", newSession.getSessionStatus());
                result.put("gymnastName", newSession.getGymnastName());
                result.put("apparatusName", newSession.getApparatusName());
                result.put("teamName", newSession.getTeamName());
            }
        } else {
            result.put("success", true);
            result.put("competitionComplete", true);
        }

        return result;
    }

    private JSONObject handleOverrideScore(int sessionID, String positionCode, double newScore, int staffID, String reason) {
        JSONObject result = new JSONObject();

        var position = new com.dao.scoring.JudgePositionTypeDAO().getPositionByCode(positionCode);
        if (position != null) {
            scoreDAO.overrideScore(sessionID, position.getPositionTypeID(), newScore, staffID, reason);
            result.put("success", true);
        } else {
            result.put("success", false);
            result.put("error", "Invalid position code");
        }

        return result;
    }

    private void sendError(HttpServletResponse response, String message) throws IOException {
        JSONObject error = new JSONObject();
        error.put("success", false);
        error.put("error", message);

        try (PrintWriter out = response.getWriter()) {
            out.print(error.toJSONString());
        }
    }
}
