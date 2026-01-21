package com.servlet.scoring;

import com.dao.scoring.ListEventDAO;
import com.scoring.bean.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.simple.JSONObject;

public class JuryEventApiServlet extends HttpServlet {

    private ListEventDAO eventDAO = new ListEventDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        JSONObject result = new JSONObject();

        try {
            if ("validateCode".equals(action)) {
                String code = request.getParameter("code");
                Event event = eventDAO.getEventByJuryCode(code);

                if (event != null) {
                    result.put("success", true);
                    result.put("eventID", event.getEventID());
                    result.put("eventName", event.getEventName());
                    result.put("hasJuryScreen", event.isHasJuryScreen());
                } else {
                    result.put("success", false);
                    result.put("error", "Invalid event code");
                }
            } else if ("getInfo".equals(action)) {
                int eventID = Integer.parseInt(request.getParameter("eventID"));
                Event event = eventDAO.getEventById(eventID);

                if (event != null) {
                    result.put("success", true);
                    result.put("eventID", event.getEventID());
                    result.put("eventName", event.getEventName());
                    result.put("hasJuryScreen", event.isHasJuryScreen());
                    result.put("juryAccessCode", event.getJuryAccessCode());
                } else {
                    result.put("success", false);
                    result.put("error", "Event not found");
                }
            } else {
                result.put("success", false);
                result.put("error", "Unknown action");
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
}
