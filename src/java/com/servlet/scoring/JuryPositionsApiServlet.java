package com.servlet.scoring;

import com.dao.scoring.JudgePositionTypeDAO;
import com.scoring.bean.JudgePositionType;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class JuryPositionsApiServlet extends HttpServlet {

    private JudgePositionTypeDAO positionDAO = new JudgePositionTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONObject result = new JSONObject();

        try {
            int eventID = Integer.parseInt(request.getParameter("eventID"));
            String positionCode = request.getParameter("positionCode");

            if (positionCode != null && !positionCode.isEmpty()) {
                // Get single position
                JudgePositionType position = positionDAO.getPositionByCode(positionCode);
                if (position != null) {
                    result.put("success", true);
                    result.put("position", positionToJSON(position));
                } else {
                    result.put("success", false);
                    result.put("error", "Position not found");
                }
            } else {
                // Get all active positions for event
                List<JudgePositionType> positions = positionDAO.getActivePositionsForEvent(eventID);

                // If no event-specific config, get all positions
                if (positions.isEmpty()) {
                    positions = positionDAO.getAllPositions();
                }

                JSONArray positionsArray = new JSONArray();
                for (JudgePositionType pos : positions) {
                    positionsArray.add(positionToJSON(pos));
                }

                result.put("success", true);
                result.put("positions", positionsArray);
            }
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

    private JSONObject positionToJSON(JudgePositionType pos) {
        JSONObject obj = new JSONObject();
        obj.put("positionTypeID", pos.getPositionTypeID());
        obj.put("positionCode", pos.getPositionCode());
        obj.put("positionName", pos.getPositionName());
        obj.put("panelNumber", pos.getPanelNumber());
        obj.put("category", pos.getCategory());
        obj.put("scoreMin", pos.getScoreMin());
        obj.put("scoreMax", pos.getScoreMax());
        obj.put("isRequired", pos.isIsRequired());
        obj.put("displayOrder", pos.getDisplayOrder());
        return obj;
    }
}
