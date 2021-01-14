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
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String dato = request.getParameter("cajanumero");
            String nombre = request.getParameter("cajanombre");
            String localidad = request.getParameter("cajaloc");
            int insertados = 1;
            if (dato != null){
            int dept = Integer.parseInt(dato);
            String sqlinsertar = "insert into dept values (?, ?, ?)";
            PreparedStatement pst = cn.prepareStatement(sqlinsertar);
            pst.setInt(1, dept);
            pst.setString(2, nombre);
            pst.setString(3, localidad);
            insertados = pst.executeUpdate();
            }
        %>
        <h1>Insertar departamento</h1>
        <form method="post">
            <label>Departamento número</label>
            <input type="number" id="cajanumero" required/><br/>
            <label>Nombre departamento</label>
            <input type="text" id="cajanombre" required/><br/>
            <label>Localidad</label>
            <input type="text" id="cajaloc" required/><br/>
            <button type="submit">Pulsar para insertar</button>
        </form>
        <%
            if (dato != null){
                %>
                <h1> Departamentos insertados: <%=insertados%></h1>
                <%
            }
        %>
        <hr/>
        <ul class="list-group">
            <%
                String sqlconsulta = "select * from dept";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqlconsulta);
                while(rs.next()){
                    String dept = rs.getString("DEPT_NO");
                    String nom = rs.getString("DNOMBRE");
                    String local = rs.getString("LOC");
            %>
            <li class="list-group-item"><%=dept%>, <%=nom%>, <%=local%></li>
            <%
                }
                    rs.close();
                    cn.close();
            %>
        </ul> 
    </body>
</html>
