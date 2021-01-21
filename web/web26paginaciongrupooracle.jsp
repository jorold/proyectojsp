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
Connection cn = 
    DriverManager.getConnection(cadena,"system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Paginación grupo Oracle</h1>
        <%
        //no tenemos el número total de registros a dibujar
        //para saber cuantos registros hacemos un count
        String sqlregistros = "select count(emp_no) as personas from emp";
        Statement st = cn.createStatement();
        ResultSet rs = st.executeQuery(sqlregistros);
        rs.next();
        int registros = rs.getInt("PERSONAS");
        rs.close();
        String sqlemp = "select * from"
        + "(select rownum as posicion, empleados.* from"
        + "(select apellido, oficio, salario from emp) empleados) consulta"
        + " where posicion >= ? and posicion < ?";
            int posicion = 1;
            String dato = request.getParameter("posicion");
            if (dato != null){
                posicion = Integer.parseInt(dato);
            }
            PreparedStatement pst = cn.prepareStatement(sqlemp);
            pst.setInt(1, posicion);
            pst.setInt(2, posicion + 5);
            rs = pst.executeQuery();
        %>
        <table class="table">
            <thead>
                <tr>
                    <th>Posición</th>
                    <th>Apellido</th>
                    <th>Oficio</th>
                    <th>Salario</th>               
                </tr>
            </thead>
            <tbody>
                <%
                while (rs.next()){
                    String pos = rs.getString("POSICION");
                    String ape = rs.getString("APELLIDO");
                    String ofi = rs.getString("OFICIO");
                    String sal = rs.getString("SALARIO");
                    %>
                    <tr>
                        <td><%=pos%></td>
                        <td><%=ape%></td>
                        <td><%=ofi%></td>
                        <td><%=sal%></td>
                    </tr>
                    <%
                }
                rs.close();
                cn.close();
                %>
            </tbody>               
        </table>
            <ul class="list-group list-group-horizontal">
                <%
                int numeropagina = 1;
                for (int i = 1; i <= registros; i+=5){
                    %>
                    <li class="list-group-item">
                        <a href="web26paginaciongrupooracle.jsp?posicion=<%=i%>">
                        Página <%=numeropagina%>
                        </a>
                    </li>
                    <% 
                        numeropagina ++;
                }
                %>
            </ul>
    </body>
</html>
