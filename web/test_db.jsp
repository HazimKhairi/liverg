<%@ page import="java.sql.*" %>
<%@ page import="com.connection.DBConnect" %>
<%@ page contentType="text/plain" %>
<%
    DBConnect db = new DBConnect();
    out.println("Testing connection to: " + db.getJdbcURL());
    out.println("User: " + db.getJdbcUsername());
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(db.getJdbcURL(), db.getJdbcUsername(), db.getJdbcPassword());
        out.println("Connection SUCCESS!");
        con.close();
    } catch (Exception e) {
        out.println("Connection FAILED:");
        e.printStackTrace(new java.io.PrintWriter(out));
    }
%>
