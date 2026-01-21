package com.registration.servlet;

import com.connection.DBConnect;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONObject;

@MultipartConfig(maxFileSize = 16177215) // 16MB
public class UpdateGymnastServlet extends HttpServlet {

 private static final Logger LOGGER = Logger.getLogger(UpdateGymnastServlet.class.getName());

 @Override
 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
  // Database Connection
  DBConnect db = new DBConnect();
  Connection con = null;
  PreparedStatement pstm = null;
  ResultSet rs = null;

  JSONObject obj = new JSONObject();

  try {
   con = db.getConnection();

   int updateGymnastID = Integer.parseInt(request.getParameter("updateGymnastID"));
   String updateGymnastIC = request.getParameter("updateGymnastIC");
   int updateGymnastTeam = Integer.parseInt(request.getParameter("updateGymnastTeam"));
   int updateEventName = Integer.parseInt(request.getParameter("updateGymnastEvent"));
   String updateGymnastName = request.getParameter("updateGymnastName");
   String updateGymnastSchool = request.getParameter("updateGymnastSchool");
   String updateGymnastCategory = request.getParameter("updateGymnastCategory");
   Part filePart = request.getPart("updateGymnastPic");

   // Construct new filename based on user's name and IC number
   String filename = updateGymnastName.replaceAll("\\s+", "") + "_" + updateGymnastIC;
   String newFileName = null; // Initialize newFileName

   if (filePart != null && filePart.getSize() > 0) { // Check if file is uploaded
    // Check if file is an image
    String contentType = filePart.getContentType();
    if (contentType == null || !contentType.startsWith("image")) {
     obj.put("success", false);
     obj.put("msg", 2); // Set msg to 2 for image type error
     response.setContentType("application/json");
     response.getWriter().print(obj.toJSONString());
     return; // Exit early since it's an invalid file type
    }

    String imageFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    String fileExtension = "";
    int lastDotIndex = imageFileName.lastIndexOf('.');
    if (lastDotIndex != -1) {
     fileExtension = imageFileName.substring(lastDotIndex);
    }
    newFileName = filename + fileExtension;

    // Process the new file upload
    String uploadDir = getServletContext().getRealPath("/../../web/registration/uploads/");
    File uploadDirFile = new File(uploadDir);
    if (!uploadDirFile.exists() && !uploadDirFile.mkdirs()) {
     throw new IOException("Failed to create directory: " + uploadDir);
    }

    // Construct the full path of the existing file
    String existingFileName = null;
    String selectQuery = "SELECT gymnastIcPic FROM GYMNAST WHERE gymnastID = ?";
    pstm = con.prepareStatement(selectQuery);
    pstm.setInt(1, updateGymnastID);
    rs = pstm.executeQuery();

    if (rs.next()) {
     existingFileName = rs.getString("gymnastIcPic");
    }
    rs.close();
    pstm.close();

    // Delete the existing file from the server
    if (existingFileName != null && !existingFileName.isEmpty()) {
     File existingFile = new File(uploadDir + File.separator + existingFileName);
     if (existingFile.exists() && existingFile.delete()) {
      LOGGER.log(Level.INFO, "Deleted old file: " + existingFileName);
     } else {
      LOGGER.log(Level.WARNING, "Failed to delete the existing file: " + existingFileName);
     }
    }

    // Upload new file
    String uploadPath = uploadDir + File.separator + newFileName;
    try (FileOutputStream fos = new FileOutputStream(uploadPath); InputStream is = filePart.getInputStream()) {
     byte[] buffer = new byte[1024];
     int bytesRead;
     while ((bytesRead = is.read(buffer)) != -1) {
      fos.write(buffer, 0, bytesRead);
     }
    }
   }

   // Update Gymnast App 
   // Retrieve selected apparatus IDs
   String selectedValuesStr = request.getParameter("select3");
   System.out.println(updateEventName);
   if (selectedValuesStr != null && !selectedValuesStr.isEmpty() ) {
    // Split the concatenated string into individual integer values
    String[] selectedApparatusIDs = selectedValuesStr.split(",");

    // Delete existing apparatus entries for the gymnast
    String deleteQuery = "DELETE FROM GYMNAST_APP WHERE gymnastID = ?";
    try (PreparedStatement pstmtDelete = con.prepareStatement(deleteQuery)) {
     pstmtDelete.setInt(1, updateGymnastID);
     pstmtDelete.executeUpdate();
    }
    // Delete composite entries for the gymnast
    String deleteComposite = "DELETE FROM COMPOSITE WHERE gymnastID = ?";
    try (PreparedStatement pstmtDeleteComposite = con.prepareStatement(deleteComposite)) {
     pstmtDeleteComposite.setInt(1, updateGymnastID);
     pstmtDeleteComposite.executeUpdate();
    }

    // Insert new apparatus entries for the gymnast
    String insertQuery = "INSERT INTO GYMNAST_APP (gymnastID, apparatusID,eventID) VALUES (?, ?,?)";
    try (PreparedStatement pstmtInsert = con.prepareStatement(insertQuery)) {
     for (String apparatusIDStr : selectedApparatusIDs) {
      int apparatusID = Integer.parseInt(apparatusIDStr.trim());
      pstmtInsert.setInt(1, updateGymnastID);
      pstmtInsert.setInt(2, apparatusID);
      pstmtInsert.setInt(3, updateEventName);
      pstmtInsert.executeUpdate();
     }
    }

    // Insert new apparatus entries for the gymnast
    String insertComposite = "INSERT INTO COMPOSITE (gymnastID, teamID, apparatusID,eventID) VALUES (?, ?, ?, ?)";
    try (PreparedStatement pstmtInsertComposite = con.prepareStatement(insertComposite)) {
     for (String apparatusIDStr : selectedApparatusIDs) {
      int apparatusID = Integer.parseInt(apparatusIDStr.trim());
      pstmtInsertComposite.setInt(1, updateGymnastID);
      pstmtInsertComposite.setInt(2, updateGymnastTeam);
      pstmtInsertComposite.setInt(3, apparatusID);
      pstmtInsertComposite.setInt(4, updateEventName);
      pstmtInsertComposite.executeUpdate();
     }
    }
   }
   // End Of Update Gymnast App

   
      if (updateEventName != 0) {

//    String insertQuery = "INSERT INTO GYMNAST_APP (gymnastID, apparatusID,eventID) VALUES (?, ?,?)";
    String updateQuery = "UPDATE gymnast_app SET eventID = ? WHERE gymnastID = ?";
    try (PreparedStatement pstmtInsert = con.prepareStatement(updateQuery)) {

      pstmtInsert.setInt(1, updateEventName);
      pstmtInsert.setInt(2, updateGymnastID);
      pstmtInsert.executeUpdate();
     
    }

    // Insert new apparatus entries for the gymnast
//    String insertComposite = "INSERT INTO COMPOSITE (gymnastID, teamID, apparatusID,eventID) VALUES (?, ?, ?, ?)";
    String updateComposite = "UPDATE COMPOSITE SET eventID = ? WHERE gymnastID = ?";
    try (PreparedStatement pstmtInsertComposite = con.prepareStatement(updateComposite)) {
   
      pstmtInsertComposite.setInt(1, updateEventName);
      pstmtInsertComposite.setInt(2, updateGymnastID);
      pstmtInsertComposite.executeUpdate();
    }
   }
      
   
   
   
   
   
   // Update query construction
   String updateQuery;
   if (newFileName != null) { // Check if new file is uploaded
    updateQuery = "UPDATE GYMNAST SET gymnastName = ?, gymnastIC = ?, gymnastIcPic = ?, gymnastSchool = ?, gymnastCategory = ?, teamID = ? WHERE gymnastID = ?";
   } else {
    updateQuery = "UPDATE GYMNAST SET gymnastName = ?, gymnastIC = ?, gymnastSchool = ?, gymnastCategory = ?, teamID = ? WHERE gymnastID = ?";
   }

   // Execute the update query for gymnast details
   try (PreparedStatement pstmGymnast = con.prepareStatement(updateQuery)) {
    pstmGymnast.setString(1, updateGymnastName);
    pstmGymnast.setString(2, updateGymnastIC);
    if (newFileName != null) { // Check if new file is uploaded
     pstmGymnast.setString(3, newFileName); // Set the new file name
     pstmGymnast.setString(4, updateGymnastSchool);
     pstmGymnast.setString(5, updateGymnastCategory);
     pstmGymnast.setInt(6, updateGymnastTeam);
     pstmGymnast.setInt(7, updateGymnastID); // Set the gymnast ID
    } else {
     pstmGymnast.setString(3, updateGymnastSchool);
     pstmGymnast.setString(4, updateGymnastCategory);
     pstmGymnast.setInt(5, updateGymnastTeam);
     pstmGymnast.setInt(6, updateGymnastID); // Set the gymnast ID
    }

    // Execute the update query for gymnast
    int rowsAffectedGymnast = pstmGymnast.executeUpdate();

    if (rowsAffectedGymnast > 0) {
     obj.put("success", true);
     obj.put("msg", 1); // msg 1 for success
    } else {
     obj.put("success", false);
     obj.put("message", "Failed to update gymnast");
    }
   } catch (SQLException ex) {
    LOGGER.log(Level.SEVERE, "SQL error updating gymnast: ", ex);
    obj.put("success", false);
    obj.put("message", "SQL error updating gymnast: " + ex.getMessage());
    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    response.setContentType("application/json");
    try (PrintWriter out = response.getWriter()) {
     out.print(obj.toJSONString());
    }
   }

   // Send JSON response
   response.setContentType("application/json");
   try (PrintWriter out = response.getWriter()) {
    out.print(obj.toJSONString());
   }
  } catch (SQLException e) {
   LOGGER.log(Level.SEVERE, "SQL error: ", e);
   obj.put("success", false);
   obj.put("message", "SQL error: " + e.getMessage());
   response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
   response.setContentType("application/json");
   try (PrintWriter out = response.getWriter()) {
    out.print(obj.toJSONString());
   }
  } catch (IOException e) {
   LOGGER.log(Level.SEVERE, "IO error: ", e);
   obj.put("success", false);
   obj.put("message", "IO error: " + e.getMessage());
   response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
   response.setContentType("application/json");
   try (PrintWriter out = response.getWriter()) {
    out.print(obj.toJSONString());
   }
  } finally {
   // Close resources
   try {
    if (rs != null) {
     rs.close();
    }
    if (pstm != null) {
     pstm.close();
    }
    if (con != null) {
     con.close();
    }
   } catch (SQLException ex) {
    LOGGER.log(Level.SEVERE, "SQL error on close: ", ex);
   }
  }
 }
}
