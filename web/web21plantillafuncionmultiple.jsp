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
String[] datosfuncion = request.getParameterValues("plantilla");
ArrayList<String> listafuncion = new ArrayList<>();
if(datosfuncion != null){
    for(String dato: datosfuncion){
        listafuncion.add(dato);
    }
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Funciones plantilla</h1>
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
                        <input type="checkbox" name="plantilla" 
                               value="<%=funcion%>"/><%=funcion%>
                    </li>
                    <%
                }
                rs.close();
                %>
            </ul>
            <button type="submit">Mostrar datos</button>
        </form>
            <hr/>
            <%
                String[] plantilla = request.getParameterValues("plantilla");
                if(plantilla != null){
                String datos = String.join(",", plantilla);
                String sqlplantilla = "select * from plantilla where "
                        + "funcion in ('+ datos +')";
                st = cn.createStatement();
                rs = st.executeQuery(sqlplantilla);
                %>
                <table class="table-info">
                    <thead>
                        <tr>
                            <th>HOSPITAL NO</th>
                            <th>SALA NO</th>
                            <th>EMPLEADO NO</th>
                            <th>APELLIDO</th>
                            <th>TURNO</th>
                            <th>SALARIO</th>
                        </tr>
                    <tbody>
                        <%
                        while(rs.next()){
                        String hos = rs.getString("HOSPITAL_COD");
                        String sal = rs.getString("SALA_COD");
                        String emp = rs.getString("EMPLEADO_NO");
                        String ape = rs.getString("APELLIDO");
                        String tur = rs.getString("TURNO");
                        String sa = rs.getString("SALARIO");
                        %>
                        <tr>
                            <td><%=hos%></td>
                            <td><%=sal%></td>
                            <td><%=emp%></td>
                            <td><%=ape%></td>
                            <td><%=tur%></td>
                            <td><%=sa%></td>                            
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                    </thead>
                </table>
                <%
                rs.close();
                cn.close();
                }                
            %>
    </body>
</html>
