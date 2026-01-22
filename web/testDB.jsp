<%@ page import="java.sql.*" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page contentType="text/plain" %>
<%
    DBConnect db = new DBConnect();
    try (Connection con = db.getConnection()) {
        out.println("Testing Manual ID Generation Insert...");
        
        // 1. Get Max ID
        String maxIdSql = "SELECT COALESCE(MAX(apparatusID), 0) + 1 FROM APPARATUS";
        int nextId = 1;
        try (Statement st = con.createStatement()) {
            ResultSet rs = st.executeQuery(maxIdSql);
            if (rs.next()) {
                nextId = rs.getInt(1);
            }
        }
        out.println("Next ID calculated: " + nextId);

        // 2. Insert
        String insertSql = "INSERT INTO APPARATUS (apparatusID, apparatusName) VALUES (?, ?)";
        try (PreparedStatement pst = con.prepareStatement(insertSql)) {
            pst.setInt(1, nextId);
            pst.setString(2, "TestApparatus_" + System.currentTimeMillis());
            int rows = pst.executeUpdate();
            out.println("Insert successful! Rows affected: " + rows);
        } catch (SQLException e) {
            out.println("Insert failed: " + e.getMessage());
            e.printStackTrace(new java.io.PrintWriter(out));
        }
        
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
        e.printStackTrace(new java.io.PrintWriter(out));
    }
%>