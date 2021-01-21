<%-- 
Realizar una vista en ORACLE llamada TOTALEMPLEADOS para poder 
mostrar apellido, oficio/funcion/especialidad y salario 
de todos los empleados de la bbdd. 
(Doctor, plantilla y emp)
Paginar dicha vista en grupo.
create view todosempleados
as
       select apellido, oficio, salario
       from emp
       union
       select apellido, especialidad, salario
       from doctor
       union 
       select apellido, funcion, salario
       from plantilla;
"select * from"
        + "(select rownum as posicion, empleados.* from"
        + "(select apellido, oficio, salario from emp) empleados) consulta"
        + " where posicion >= ? and posicion < ?"
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = 
    DriverManager.getConnection(cadena,"system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <title>JSP Page</title>
        <style>
            table {
                margin-top: 10px;                
            }
        </style>
    </head>
    <body> 
        <h1>Paginación todos empleados</h1>
        <form method="post">
            <label>Introduzca salario: </label>
            <input type="number" name="cajasalario" required/>
            <button class="btn btn-outline-success" type="submit">Mostrar empleados</button>
        </form>
        <%
        String sql = "";
        if (request.getParameter("cajasalario") == null){
            sql = "select * from totalempleados";
        }else{
            sql = "select * from totalempleados where salario >=" + request.getParameter("cajasalario");
        }
        Statement st = 
            cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sql);
        rs.last();
        int numeroregistros = rs.getRow();
        int posicion = 1;
        String dato = request.getParameter("posicion");
        if (dato != null){
            posicion = Integer.parseInt(dato);
        }
        rs.absolute(posicion);
        %>
        <table class="table">
            <thead>
                <tr>
                    <th>Apellido</th>
                    <th>Oficio</th>
                    <th>Salario</th>
                </tr>
            </thead>
            <tbody>
        <%
        for (int i = 1; i <= 8 && !rs.isAfterLast();i++){
            String apellido = rs.getString("APELLIDOS");
            String oficio = rs.getString("FUNCION");
            String salario = rs.getString("SALARIO");
            %>
            <tr>
                <td><%=apellido%></td>
                <td><%=oficio%></td>
                <td><%=salario%></td>
            </tr>
            <%
            rs.next();
        }
        %>
            </tbody>
        </table>
        <%
        rs.close();
        cn.close();
        %>
        <ul class="list-group list-group-horizontal">
            <%
            int numeropagina = 1;
            for (int i = 1; i <= numeroregistros; i+=8){
                String cajasalario = request.getParameter("cajasalario");
                if(cajasalario == null){
                    //no recibimos salario y pintamos solo la posición
                    %>
                    <li class="list-group-item">
                        <a href="web25evolucion.jsp?posicion=<%=i%>">
                            Página <%=numeropagina%>
                        </a>
                    </li>
                    <%
                }else{
                    //pintamos la posicion y la cajasalario
                    %>
                    <li class="list-group-item">
                        <a href="web25evolucion.jsp?posicion=<%=i%>&cajasalario=<%=cajasalario%>">
                            Página <%=numeropagina%>
                        </a>
                    </li>
                    <%
                }                
                numeropagina += 1;
            }
            %>
        </ul>
    </body>
</html>