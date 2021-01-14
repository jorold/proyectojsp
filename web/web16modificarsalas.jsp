
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@localhost:1521:xe";
Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String dato = request.getParameter("cajasala");
            String salanueva = request.getParameter("nuevonombre");
            int modificados = 0;
            if(dato != null){
                int num = Integer.parseInt(dato);
                String sqlupdate = "update sala set nombre =? where sala_cod=?";
                PreparedStatement pst = cn.prepareStatement(sqlupdate);
                pst.setString(1, salanueva);
                pst.setInt(2, num);
                modificados = pst.executeUpdate();
            }
        %>
        <h1 style="color:graytext">Modificar nombre de sala</h1>
        <form method="post">
            <select name="cajasala" style="margin-bottom: 10px">
               <%
                   String sqlsalas = "select distinct sala_cod, nombre from sala";
                   Statement st = cn.createStatement();
                   ResultSet rs = st.executeQuery(sqlsalas);
                   while(rs.next()){
                       String numero = rs.getString("SALA_COD");
                       String nombre = rs.getString("NOMBRE");
               %>
               <option value="<%=numero%>"><%=nombre%></option>
               <%
                   }
                    rs.close();
                    cn.close();
               %> 
            </select><br/>
            <label>Nuevo nombre</label><br/>
            <input type="text" name="nuevonombre" placeholder="Introducir nuevo nombre" style="margin-top: 10px"/>
            <button type="submit" class="btn btn-outline-success">Cambiar nombre</button>
        </form>
            <%
                if (dato != null){
                    %>
                    <h1 style="color:green">Salas modificadas: <%=modificados%></h1>
                    <%
                }
            %>
    </body>
</html>
