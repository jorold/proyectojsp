<%@page  import="java.sql.PreparedStatement"%>
<%@page  import="java.sql.ResultSet"%>
<%@page  import="java.sql.Statement"%>
<%@page  import="java.sql.Connection"%>
<%@page  import="oracle.jdbc.OracleDriver"%>
<%@page  import="java.sql.DriverManager"%>
<%@page  contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn =
    DriverManager.getConnection(cadena,"system","oracle");
%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="includes/webhead.jsp" />
    <title>JSP Page</title>
</head>
<body>
    <jsp:include page="includes/webmenuhospital.jsp" />
    <section>
        <main role="main" class="container">
            <div class="starter-template">
                <h1>Detalles hospitales</h1>
                <a href="webindexhospital.jsp">Volver a inicio</a>
                <%
                String dato = request.getParameter("hospcod");
                if(dato != null){
                    int cod = Integer.parseInt(dato);
                String sql = "select * from hospital where hospital_cod =?";
                PreparedStatement pst = cn.prepareStatement(sql);
                    pst.setInt(1, cod);
                ResultSet rs = pst.executeQuery();
                rs.next();
                    String nh = rs.getString("HOSPITAL_COD");
                    String no = rs.getString("NOMBRE");
                    String di = rs.getString("DIRECCION");
                    String te = rs.getString("TELEFONO");
                    String ca = rs.getString("NUM_CAMA");
                rs.close();
                cn.close();
                %>
                <ul class="list-group">
                    <li class="list-group-item">Código hospital: <%=nh%></li>
                    <li class="list-group-item">Nombre: <%=no%></li>
                    <li class="list-group-item">Dirección: <%=di%></li>
                    <li class="list-group-item">Teléfono: <%=te%></li>
                    <li class="list-group-item">Camas: <%=ca%></li>
                </ul>
                <%
                }
                %>
            </div>
        </main><!-- /.container -->
    </section>
    <jsp:include page="includes/webfooter.jsp" />
</body>
</html>


