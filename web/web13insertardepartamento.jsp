

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
          String nombre = request.getParameter("cajanombre");
          String localidad = request.getParameter("cajaciudad");
          int insertados = -1;
          if (dato != null){
          int numero = Integer.parseInt(dato);
          String sqlinsert = "insert into dept values (?,?,?)";
          PreparedStatement pst = cn.prepareStatement(sqlinsert);
          pst.setInt(1, numero);
          pst.setString(2, nombre);
          pst.setString(3, localidad);
          insertados = pst.executeUpdate();
          }
        %>
        <h1>Creación departamentos</h1>
        <form method="post">
            <label>Número</label>
            <input type="number" name="cajanumero" required/><br/>
            <label>Nombre</label>
            <input type="text" name="cajanombre" required/><br/>
            <label>Ciudad</label>
            <input style="margin-left: 6.5px" type ="text" name="cajaciudad" required/><br/>
            <button style="margin-top: 10px; margin-bottom: 10px" type="submit">Insertar</button>
        </form>
        <%
        if (dato != null){
            %>
            <h1 style="color:blue">Insertados: <%=insertados%></h1>
            <%
        }
        %>
        <table border="2">
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
