<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena ="jdbc:oracle:thin:@localhost:1521:xe";
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
        <h1>Todos los empleados del grupo</h1>
        <%
        String sqlconsulta = "select * from totalempleados order by apellidos";
        Statement st = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sqlconsulta);
        String dato = request.getParameter("posicion");
        int posicion = 1;
        if(dato != null){
            posicion = Integer.parseInt(dato);
        }
        rs.last();
        int numregistros = rs.getRow();
        rs.absolute(posicion);
        %>
        <table class="table">
            <thead>
                <tr>
                    <th>Apellidos</th>
                    <th>Función</th>
                    <th>Salario</th>
                </tr>
            </thead>
            <tbody>
                <%
                for (int i = 1; i <= 10 && !rs.isAfterLast(); i++){
                %>
                <tr>
                    <td><%=rs.getString("APELLIDOS")%></td>
                    <td><%=rs.getString("FUNCION")%></td>
                    <td><%=rs.getString("SALARIO")%></td>
                </tr>
                <%
                    rs.next();
                }
                    rs.close();
                    cn.close();
                %>
            </tbody>
        </table>
            <ul class="list-group list-group-horizontal">
                <%
                int numpagina = 1;
                for (int i = 1; i <= numregistros; i+=10){
                    %>
                    <li class="list-group-item">
                        <a href="web25totalempleadosgrupo.jsp?posicion=<%=i%>">
                                    Página <%=numpagina%>
                        </a>
                    </li>
                    <%
                        numpagina += 1;
                }
                %>
            </ul>
    </body>
</html>
