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
        <title>JSP Page</title>
    </head>
    <body>                                                         
        <h1>Prueba plantilla radios</h1>
        <form method="post">
            <ul>
                <%
                    String sqlmenu = "select nombre from hospital";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sqlmenu);
                    String marcador = request.getParameter("nombre");
                    while(rs.next()){
                        String nom = rs.getString("NOMBRE");
                        if(marcador == null){
                        %>
                         <li><input type="radio" name="nombre" value="<%=nom%>"/><%=nom%></li>
                        <%
                        }else{
                            if(marcador.equals(nom)){
                                %>
                         <li><input type="radio" name="nombre" value="<%=nom%>" checked/><%=nom%></li>
                                <%
                            }else{
                                %>
                                <li><input type="radio" name="nombre" value="<%=nom%>"/><%=nom%></li>
                                <%
                             }
                         }
                    }
                    rs.close();
                %>
            </ul>
            <button type="submit">Mostrar hospital</button>
        </form>
            <hr/>
            <%
                String nombre = request.getParameter("nombre");
                if(nombre != null){
                    String sqlmostrar = "select * from hospital where nombre =?";
                    PreparedStatement pst = cn.prepareStatement(sqlmostrar);
                    pst.setString(1, nombre);
                    rs= pst.executeQuery();
                    %>
                    <table border="1">
                        <thead>
                            <th>CÓDIGO</th>
                            <th>DIRECCIÓN</th>
                            <th>TELÉFONO</th>
                            <th>CAMAS</th>
                        </thead>
                          <tbody>                        
                        <%
                        while(rs.next()){
                            String hos = rs.getString("HOSPITAL_COD");
                            String dir = rs.getString("DIRECCION");
                            String tel = rs.getString("TELEFONO");
                            String cam = rs.getString("NUM_CAMA");
                            %>
                            <tr>
                                <td><%=hos%></td>
                                <td><%=dir%></td>
                                <td><%=tel%></td>
                                <td><%=cam%></td>
                            </tr>
                            <%
                        }
                        rs.close();
                        %>
                          </tbody>
                    </table>
                    <%
                }
                cn.close();
            %>
    </body>
</html>
