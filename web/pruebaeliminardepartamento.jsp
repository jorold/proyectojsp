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
        <%
        String dato = request.getParameter("cajanumero");
        int eliminados = 0;
        if (dato != null){
        int numero = Integer.parseInt(dato);
        String sqldelete = "delete from dept where dept_no =?";
        PreparedStatement pst = cn.prepareStatement(sqldelete);
        pst.setInt(1, numero);
        eliminados = pst.executeUpdate();
        }
        %>
        <h1>Eliminar departamento</h1>
        <form method="post">
            <label>Número departamento</label>
            <input type="number" name="cajanumero"/>
            <button type="submit">Eliminar</button>
        </form>
        <%
            if (dato != null){
                %>
                <h1 style="color:red">Departamentos eliminados: <%=eliminados%></h1>
                <%
            }
        %>
        <table border="2" style="margin-top: 10px">
            <thead>
                <th>Número</th>
                <th>Nombre</th>
                <th>Localidad</th>
            </thead>
            <tbody>
                <%
                String sqlconsulta = "select * from dept";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqlconsulta);
                while (rs.next()){
                    String num = rs.getString("DEPT_NO");
                    String nom = rs.getString("DNOMBRE");
                    String loc = rs.getString("LOC");
                %>
                <tr>
                    <td><%=num%></td>
                    <td><%=nom%></td>
                    <td><%=loc%></td>
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
