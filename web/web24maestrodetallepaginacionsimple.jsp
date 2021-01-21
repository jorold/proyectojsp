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
        <style>
            ul#menu li {
                display: inline;
            }
        </style>
    </head>
    <body>
        <h1>Detalle paginación simple</h1>
        <%
            String sql = "select * from hospital";
            Statement st = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet rs = st.executeQuery(sql);
            int siguiente, anterior, ultimo;
            rs.last();
            ultimo = rs.getRow();
            int posicion = 1;
            if (request.getParameter("posicion") == null) {
                siguiente = posicion + 1;
                anterior = 1;
            } else {
                String dato = request.getParameter("posicion");
                posicion = Integer.parseInt(dato);
                if (posicion == 1) {
                    anterior = 1;
                } else {
                    anterior = posicion - 1;
                }
                if (posicion == ultimo) {
                    siguiente = ultimo;
                } else {
                    siguiente = posicion + 1;
                }
            }
            rs.absolute(posicion);
            String no = rs.getString("NOMBRE");
            String di = rs.getString("DIRECCION");
            String te = rs.getString("TELEFONO");
            String hcod = rs.getString("HOSPITAL_COD");
            rs.close();
        %>
        <dl>
            <dt><b><%=no%></b></dt>
            <dt><%=di%></dt>
            <dt><%=te%></dt>
        </dl>
        <h3 style="color: darkmagenta">Posición: <%=posicion%> de <%=ultimo%> </h3>
        <hr/>
        <ul id="menu">
            <li>
                <a href="web24maestrodetallepaginacionsimple.jsp?posicion=1">Primero</a>
            </li>
            <li>
                <a href="web24maestrodetallepaginacionsimple.jsp?posicion=<%=anterior%>">Anterior</a>
            </li>
            <li>
                <a href="web24maestrodetallepaginacionsimple.jsp?posicion=<%=siguiente%>">Siguiente</a>
            </li>
            <li>
                <a href="web24maestrodetallepaginacionsimple.jsp?posicion=<%=ultimo%>">Último</a>
            </li>
        </ul>
            <hr/>
            <table border="1">
                <thead>
                    <tr>
                        <th>Apellido</th>
                        <th>Especialidad</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    String sqldoctor = "select * from doctor where hospital_cod=?";
                    PreparedStatement pst = cn.prepareStatement(sqldoctor);
                    int codigo = Integer.parseInt(hcod);
                    pst.setInt(1, codigo);
                    rs = pst.executeQuery();
                    while(rs.next()){
                        String apellido = rs.getString("APELLIDO");
                        String especialidad = rs.getString("ESPECIALIDAD");
                        %>
                        <tr>
                            <td><%=apellido%></td>
                            <td><%=especialidad%></td>
                        </tr>
                        <%
                    }
                    rs.close();
                    cn.close();
                    %>
                </tbody>
            </table>
    </body>
</html>
