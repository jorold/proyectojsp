<%-- 
    Document   : web08buscadorempleados
    Created on : 12-ene-2021, 17:22:44
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
        <h1>Buscador de empleados</h1>
        <form method="post">
            <label>salario: </label>
            <input type="number" name="cajasalario" required/>
            <button type="submit">Buscar empleados</button>            
        </form>
        <%
        String dato = request.getParameter("cajasalario");
        if (dato != null){
        int salario = Integer.parseInt(dato);
        String sql = "select * from emp where salario> ?";
        PreparedStatement pst = cn.prepareStatement(sql);
        pst.setInt(1, salario);
        ResultSet rs = pst.executeQuery();
        %>
        <ul>
        <%
            while(rs.next()){
            String apellido = rs.getString("APELLIDO");
            String sal = rs.getString("SALARIO");
        %>
        <li><%=apellido%>, <%=sal%></li>
            <%
        }
        rs.close();
        cn.close();
        %>
        </ul>    
        <%
        }
        %>
    </body>
</html>
