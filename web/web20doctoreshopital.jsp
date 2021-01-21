<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
String[] datosseleccionados = request.getParameterValues("hospital");
ArrayList<String> listaseleccion = new ArrayList<>();
if (datosseleccionados != null){
    for (String dato: datosseleccionados){
        listaseleccion.add(dato);
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
        <h1>Doctores hospital</h1>
        <form method="post">
            <ul>
                <%
                String sqlhospital = "select * from hospital";
                Statement st =cn.createStatement();
                ResultSet rs = st.executeQuery(sqlhospital);
                while (rs.next()){
                    String nombre = rs.getString("NOMBRE");
                    String codigo = rs.getString("HOSPITAL_COD");
                    if (listaseleccion.size() == 0){
                        //NO SELECCIONAMOS
                        %>
                        <li>
                            <input type="checkbox" name="hospital"
                                   value="<%=codigo%>"/><%=nombre%>
                        </li>
                        <%                        
                    }else{
                        //BUSCAMOS LOS DATOS SELECCIONADOS EN listaseleccion
                        if (listaseleccion.contains(codigo)){
                            //SELECCIONAMOS
                            %>
                            <li>
                                <input type="checkbox" name="hospital"
                                     value="<%=codigo%>" checked/><%=nombre%>
                            </li>
                            <%
                        }else{
                            //NO SELECCIONAMOS
                            %>
                            <li>
                                <input type="checkbox" name="hospital"
                                       value="<%=codigo%>"/><%=nombre%>
                            </li>
                            <%
                        }
                    }
                }
                rs.close();
                %>
            </ul>
            <button type="submit">
                Mostrar doctores
            </button>
        </form>
        <hr/>
        <%
        String[] hospitales  = request.getParameterValues("hospital");
        if (hospitales != null){
            //SEPARAMOS TODOS LOS HOSPITALES POR COMAS EN UN STRING
            // 18,19
            //hospitales[0] = 18
            //hospitales[1] = 19
            String valores = String.join(",", hospitales);
            //select * from doctor where hospital_cod in (18,19)
          String sqldoctores = "select * from doctor where hospital_cod in(" 
                    + valores + ")";
            st = cn.createStatement();
            rs = st.executeQuery(sqldoctores);
            %>
            <table class="table-bordered">
                <thead>
                    <tr>
                        <th>APELLIDO</th>
                        <th>ESPECIALIDAD</th>
                        <th>SALARIO</th>
                    </tr>
                </thead>
                <tbody>
            <%
            while (rs.next()){
                String ape = rs.getString("APELLIDO");
                String espe = rs.getString("ESPECIALIDAD");
                String sal = rs.getString("SALARIO");
                %>
                <tr>
                    <td><%=ape%></td>
                    <td><%=espe%></td>
                    <td><%=sal%></td>
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
