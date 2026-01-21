package com.servlet.scoring;

import com.dao.scoring.StartListDAO;
import com.dao.scoring.JurySessionDAO;
import com.scoring.bean.StartListEntry;
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
import org.json.simple.parser.JSONParser;

public class JuryStartListApiServlet extends HttpServlet {

    private StartListDAO startListDAO = new StartListDAO();
    private JurySessionDAO sessionDAO = new JurySessionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject result = new JSONObject();

        try {
            int eventID = Integer.parseInt(request.getParameter("eventID"));

            int day = 0;
            int batch = 0;
            int apparatusID = 0;
            String category = request.getParameter("category");

            try {
                day = Integer.parseInt(request.getParameter("day"));
            } catch (Exception e) {}
            try {
                batch = Integer.parseInt(request.getParameter("batch"));
            } catch (Exception e) {}
            try {
                apparatusID = Integer.parseInt(request.getParameter("apparatusID"));
            } catch (Exception e) {}

            List<StartListEntry> entries = startListDAO.getStartList(eventID, day, batch, apparatusID, category);

            // Get current session to mark current gymnast
            JurySession currentSession = sessionDAO.getCurrentSession(eventID);
            int currentStartListID = currentSession != null ? currentSession.getStartListID() : -1;

            JSONArray entriesArray = new JSONArray();
            for (StartListEntry entry : entries) {
                JSONObject obj = new JSONObject();
                obj.put("startListID", entry.getStartListID());
                obj.put("gymnastID", entry.getGymnastID());
                obj.put("gymnastName", entry.getGymnastName());
                obj.put("teamName", entry.getTeamName());
                obj.put("apparatusID", entry.getApparatusID());
                obj.put("apparatusName", entry.getApparatusName());
                obj.put("competitionDay", entry.getCompetitionDay());
                obj.put("batchNumber", entry.getBatchNumber());
                obj.put("startOrder", entry.getStartOrder());
                obj.put("isFinalized", entry.isIsFinalized());
                obj.put("finalScore", entry.getFinalScore());
                obj.put("isScored", entry.getFinalScore() > 0);
                obj.put("isCurrent", entry.getStartListID() == currentStartListID);
                obj.put("isCompleted", entry.isIsFinalized() && entry.getFinalScore() > 0);
                entriesArray.add(obj);
            }

            result.put("success", true);
            result.put("entries", entriesArray);
        } catch (NumberFormatException e) {
            result.put("success", false);
            result.put("error", "Invalid event ID");
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
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
                case "add":
                    result = handleAdd(request, eventID);
                    break;
                case "remove":
                    result = handleRemove(request);
                    break;
                case "updateOrder":
                    result = handleUpdateOrder(request, eventID);
                    break;
                case "randomize":
                    result = handleRandomize(eventID);
                    break;
                default:
                    result.put("success", false);
                    result.put("error", "Unknown action");
            }
        } catch (NumberFormatException e) {
            result.put("success", false);
            result.put("error", "Invalid event ID");
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
            e.printStackTrace();
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(result.toJSONString());
        }
    }

    private JSONObject handleAdd(HttpServletRequest request, int eventID) throws Exception {
        JSONObject result = new JSONObject();

        int apparatusID = Integer.parseInt(request.getParameter("apparatusID"));
        int batchNumber = Integer.parseInt(request.getParameter("batchNumber"));
        int competitionDay = Integer.parseInt(request.getParameter("competitionDay"));
        String gymnastIDsJson = request.getParameter("gymnastIDs");

        JSONParser parser = new JSONParser();
        JSONArray gymnastIDs = (JSONArray) parser.parse(gymnastIDsJson);

        for (Object idObj : gymnastIDs) {
            int gymnastID = ((Number) idObj).intValue();
            startListDAO.addToStartList(eventID, gymnastID, apparatusID, competitionDay, batchNumber);
        }

        result.put("success", true);
        result.put("added", gymnastIDs.size());
        return result;
    }

    private JSONObject handleRemove(HttpServletRequest request) {
        JSONObject result = new JSONObject();

        int startListID = Integer.parseInt(request.getParameter("startListID"));
        boolean removed = startListDAO.removeFromStartList(startListID);

        result.put("success", removed);
        if (!removed) {
            result.put("error", "Failed to remove entry");
        }
        return result;
    }

    private JSONObject handleUpdateOrder(HttpServletRequest request, int eventID) throws Exception {
        JSONObject result = new JSONObject();

        String orderJson = request.getParameter("order");
        JSONParser parser = new JSONParser();
        JSONArray orderArray = (JSONArray) parser.parse(orderJson);

        for (Object obj : orderArray) {
            JSONObject entry = (JSONObject) obj;
            int startListID = ((Number) entry.get("startListID")).intValue();
            int startOrder = ((Number) entry.get("startOrder")).intValue();
            startListDAO.updateStartOrder(startListID, startOrder);
        }

        result.put("success", true);
        return result;
    }

    private JSONObject handleRandomize(int eventID) {
        JSONObject result = new JSONObject();

        boolean randomized = startListDAO.randomizeUnscored(eventID);
        result.put("success", randomized);

        return result;
    }
}
