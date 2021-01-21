<%@page import="java.util.ArrayList"%>
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
String[] seleccionfunciones = request.getParameterValues("funcion");
ArrayList<String> listafunciones = new ArrayList<>();
if (seleccionfunciones != null){
    for(String datos: seleccionfunciones){
        listafunciones.add(datos);
    }
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Función múltiple</h1>
        <form method="post">
            <ul>
                <%
                String sqlfuncion = "select distinct funcion from plantilla";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqlfuncion);
                while(rs.next()){
                    String funcion = rs.getString("FUNCION");
                    %>
                    <li>
                        <input type="checkbox" name="funcion" 
                               value="<%=funcion%>"/><%=funcion%>
                    </li>
                    <%
                }
                rs.close();
                %>                
            </ul>
            <button type="submit">Ver datos</button>
        </form>
            <hr/>
            <%
            String[] plantilla = request.getParameterValues("funcion");
            if(plantilla != null){
                String dato= String.join(",", plantilla);
                String sqlconsulta = "select * from plantilla where funcion in ('+ dato +')";
                st = cn.createStatement();
                rs = st.executeQuery(sqlconsulta);
                %>
                <table border="1">
                    <thead>
                        <tr>
                            <th>APELLIDO</th>
                            <th>TURNO</th>
                            <th>SALARIO</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        while(rs.next()){
                            String ap = rs.getString("APELLIDO");
                            String tu = rs.getString("TURNO");
                            String sa = rs.getString("SALARIO");
                            %>
                            <tr>
                                <td><%=ap%></td>
                                <td><%=tu%></td>
                                <td><%=sa%></td>
                            </tr>
                            <%
                        }
                        %>
                    </tbody>
                </table>
                <%
                    rs.close();
                    cn.close();
            }
            %>
    </body>
</html>
