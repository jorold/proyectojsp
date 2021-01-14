<%-- 
    Document   : web07empleados
    Created on : 12-ene-2021, 16:26:27
    Author     : jorol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
 <%@page import="oracle.jdbc.OracleDriver"%>
 <%
     DriverManager.registerDriver(new OracleDriver());
     String cadena = "jdbc:oracle:thin:@localhost:1521:xe";
     Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
   %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Empleados Oracle</h1>
        <%
        String sql = "select * from emp";
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery(sql);
        %>
        <ul>
        <%
        while(rs.next()){
            String apellido = rs.getString("apellido");
            %>
            <li><%=apellido%></li>
            <%
        }
        %>
        </ul>
         <%
        rs.close();
        cn.close();
        %>
    </body>
</html>
