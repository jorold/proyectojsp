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
        <jsp:include page="includes/webhead.jsp"/>
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">

                <div class="starter-template">
                    <h1>Empleados hospital</h1>
                    <%
                    String dato = request.getParameter("hospital");
                    if(dato != null){
                        int codigo = Integer.parseInt(dato);
                    String sqlemp = "select * from empleadoshospital"
                            + " where hospital_cod =?";
                    PreparedStatement pst = cn.prepareStatement(sqlemp);
                    pst.setInt(1, codigo);
                    ResultSet rs = pst.executeQuery();
                        while(rs.next()){
                            String id = rs.getString("IDEMPLEADO");
                            String ap = rs.getString("APELLIDO");
                            String fu = rs.getString("FUNCION");
                            String ho = rs.getString("HOSPITAL_COD");                     
                            %>
                            <ul class="list-group-item">
                                <li class="list-group-item">
                                    <%=ap%>
                                    <a class="btn btn-outline-info" 
                                       href="web34detallesempleado.jsp?idempleado=<%=id%>">
                                        Detalles
                                    </a>
                                </li>
                            </ul>
                            <%
                        }
                    rs.close();
                    cn.close();
                    }
                    %>
                </div>

            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
