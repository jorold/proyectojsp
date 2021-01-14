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
        <h1>Empleados oficios links</h1>
        <ul>
            <%
                Statement st = cn.createStatement();
                String empleo = "select distinct oficio from emp";
                ResultSet rs = st.executeQuery(empleo);
                while (rs.next()){
                String of = rs.getString("OFICIO");
            %>
            <li><a href="web11empleadosoficioslinks.jsp?oficio=<%=of%>"><%=of%></a></li>
            <%--<li><a href="web11empleadosoficioslinks.jsp?oficio=PRESIDENTE">PRESIDENTE</a></li>
            <li><a href="web11empleadosoficioslinks.jsp?oficio=DIRECTOR">DIRECTOR</a></li>
            <li><a href="web11empleadosoficioslinks.jsp?oficio=VENDEDOR">VENDEDOR</a></li>
            <li><a href="web11empleadosoficioslinks.jsp?oficio=EMPLEADO">EMPLEADO</a></li>
            <li><a href="web11empleadosoficioslinks.jsp?oficio=ANALISTA">ANALISTA</a></li>--%>
            <%
                }
                    rs.close();
            %>
        </ul>
        <%
            String oficio = request.getParameter("oficio");
                if(oficio != null){
                    String sqloficio = "select * from emp where oficio = ?";
                    PreparedStatement pst = cn.prepareStatement(sqloficio);
                    pst.setString(1, oficio);
                    rs = pst.executeQuery();
        %>
        <ul>
        <%
            while(rs.next()){
            String ape = rs.getString("APELLIDO");
                    %>
                    <li><%=ape%></li>
                    <%
            }
        %>
        </ul>
        <%
            rs.close();
            cn.close();
                }
        %>
    </body>
</html>
