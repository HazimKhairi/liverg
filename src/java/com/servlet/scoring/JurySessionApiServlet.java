package com.servlet.scoring;

import com.dao.scoring.FinalScoreDAO;
import com.dao.scoring.JudgePositionTypeDAO;
import com.dao.scoring.JuryScoreDAO;
import com.dao.scoring.JurySessionDAO;
import com.dao.scoring.StartListDAO;
import com.scoring.bean.FinalScore;
import com.scoring.bean.JudgePositionType;
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

            int day = 0;
            int batch = 0;
            int apparatusID = 0;
            String category = request.getParameter("category");
            String school = request.getParameter("school");

            try {
                if (request.getParameter("day") != null)
                    day = Integer.parseInt(request.getParameter("day"));
            } catch (Exception e) {
            }
            try {
                if (request.getParameter("batch") != null)
                    batch = Integer.parseInt(request.getParameter("batch"));
            } catch (Exception e) {
            }
            try {
                if (request.getParameter("apparatusID") != null)
                    apparatusID = Integer.parseInt(request.getParameter("apparatusID"));
            } catch (Exception e) {
            }

            switch (action) {
                case "startScoring":
                    result = handleStartScoring(eventID, day, batch, apparatusID, category, school);
                    break;

                case "submitScore":
                    String positionCode = request.getParameter("positionCode");
                    double scoreValue = Double.parseDouble(request.getParameter("scoreValue"));
                    int sessionID = Integer.parseInt(request.getParameter("sessionID"));
                    result = handleSubmitScore(eventID, sessionID, positionCode, scoreValue);
                    break;

                case "advanceGymnast":
                    result = handleAdvanceGymnast(eventID, day, batch, apparatusID, category, school);
                    break;

                case "overrideScore":
                    int sID = Integer.parseInt(request.getParameter("sessionID"));
                    String pCode = request.getParameter("positionCode");
                    double newScore = Double.parseDouble(request.getParameter("scoreValue"));
                    int staffID = Integer.parseInt(request.getParameter("staffID"));
                    String reason = request.getParameter("reason");
                    result = handleOverrideScore(sID, pCode, newScore, staffID, reason);
                    break;

                case "forceSubmitAll":
                    int fSessionID = Integer.parseInt(request.getParameter("sessionID"));
                    result = handleForceSubmitAll(eventID, fSessionID);
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

    private JSONObject handleStartScoring(int eventID, int day, int batch, int apparatusID, String category,
            String school) {
        JSONObject result = new JSONObject();

        JurySession session = sessionDAO.createOrGetCurrentSession(eventID, day, batch, apparatusID, category, school);
        if (session == null) {
            result.put("success", false);
            result.put("error", "No gymnasts in start list matching criteria");
            return result;
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

        JudgePositionTypeDAO positionDAO = new JudgePositionTypeDAO();
        JudgePositionType position = positionDAO.getPositionByCode(positionCode);

        if (position == null) {
            result.put("success", false);
            result.put("error", "Invalid position code: " + positionCode);
            return result;
        }

        int scoreResult = scoreDAO.submitScore(sessionID, position.getPositionTypeID(), scoreValue);
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
                // Auto-fill ALL missing positions that are not the main judge panel (DB, DA, A,
                // E)
                // This handles LINE, TIME, RJ, TV, AV, AVB, EXE, etc.
                List<String> pendingCodes = scoreDAO.getPendingPositions(sessionID, eventID);
                boolean autoFilled = false;
                for (String code : pendingCodes) {
                    JudgePositionType pos = positionDAO.getPositionByCode(code);
                    if (pos != null) {
                        String cat = pos.getCategory();
                        // If it's NOT a main category, auto-fill it with 0.0
                        if (!"DB".equals(cat) && !"DA".equals(cat) && !"A".equals(cat) && !"E".equals(cat)) {
                            scoreDAO.submitScore(sessionID, pos.getPositionTypeID(), 0.0);
                            autoFilled = true;
                        }
                    }
                }

                if (autoFilled && scoreDAO.areAllScoresSubmitted(sessionID, eventID)) {
                    sessionDAO.submitSession(sessionID);
                    finalScoreDAO.calculateAndSaveFinalScore(sessionID);
                    result.put("allSubmitted", true);

                    FinalScore finalScore = finalScoreDAO.getFinalScoreBySession(sessionID);
                    if (finalScore != null) {
                        result.put("finalScore", finalScore.getFinalScore());
                    }
                } else {
                    result.put("allSubmitted", false);
                    JSONArray pendingArray = new JSONArray();
                    pendingArray.addAll(pendingCodes);
                    result.put("pendingPositions", pendingArray);
                }
            }
        } else {
            result.put("success", false);
            result.put("error", "Failed to submit score to database (Result: " + scoreResult + ")");
        }

        return result;
    }

    private JSONObject handleAdvanceGymnast(int eventID, int day, int batch, int apparatusID, String category,
            String school) {
        JSONObject result = new JSONObject();

        JurySession current = sessionDAO.getCurrentSession(eventID);
        if (current != null && !current.isFinalized()) {
            sessionDAO.finalizeSession(current.getSessionID());
        }

        boolean advanced = sessionDAO.advanceToNextGymnast(eventID, day, batch, apparatusID, category, school);
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

    private JSONObject handleOverrideScore(int sessionID, String positionCode, double newScore, int staffID,
            String reason) {
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

    private JSONObject handleForceSubmitAll(int eventID, int sessionID) {
        JSONObject result = new JSONObject();

        List<String> pending = scoreDAO.getPendingPositions(sessionID, eventID);
        JudgePositionTypeDAO positionDAO = new JudgePositionTypeDAO();

        int count = 0;
        for (String code : pending) {
            JudgePositionType pos = positionDAO.getPositionByCode(code);
            if (pos != null) {
                scoreDAO.submitScore(sessionID, pos.getPositionTypeID(), 0.0);
                count++;
            }
        }

        sessionDAO.submitSession(sessionID);
        finalScoreDAO.calculateAndSaveFinalScore(sessionID);

        result.put("success", true);
        result.put("message", "Force submitted " + count + " scores");

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
