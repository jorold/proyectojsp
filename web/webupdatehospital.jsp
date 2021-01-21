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
    <%
    String cajacodigo = request.getParameter("cajacodigo");
    String cajanombre = request.getParameter("cajanombre");
    String cajadirec = request.getParameter("cajadirec");
    String cajatelefono = request.getParameter("cajatelefono");
    String cajacamas = request.getParameter("cajacamas");
    if(cajacodigo != null){
        int codigo = Integer.parseInt(cajacodigo);
        int telefono = Integer.parseInt(cajatelefono);
        int camas = Integer.parseInt(cajacamas);
    String sqlmodificar = "update hospital set nombre =?, direccion =?,"
            + " telefono =?, num_cama=? where hospital_cod =?";
    PreparedStatement pst = cn.prepareStatement(sqlmodificar);
        pst.setString(1, cajanombre);
        pst.setString(2, cajadirec);
        pst.setInt(3, telefono);
        pst.setInt(4, camas);
        pst.setInt(5, codigo);
    pst.executeUpdate();
    cn.close();
    %>
    <jsp:forward page="webindexhospital.jsp"/>
    <%
    }
    %>
    <jsp:include page="includes/webmenuhospital.jsp" />
    <section>
        <main role="main" class="container">
            <div class="starter-template">
                <h1>Modificar hospitales</h1>
                <a href="webindexhospital.jsp">Volver a Inicio</a>
                <%
                String dato = request.getParameter("hospcod");
                if(dato != null);{
                    int codigo = Integer.parseInt(dato);
                String sqlconsulta = "select * from hospital where hospital_cod =?";
                PreparedStatement pst = cn.prepareStatement(sqlconsulta);
                    pst.setInt(1, codigo);
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
                <form method="post">
                    <label>Código hospital (sólo lectura)</label>
                    <input type="readonly" value="<%=nh%>" name="cajacodigo" class="form-control"/>
                    <label>Nombre: </label>
                    <input type="text" value="<%=no%>" name="cajanombre" class="form-control"/>
                    <label>Dirección: </label>
                    <input type="text" value="<%=di%>" name="cajadirec" class="form-control"/>
                    <label>Teléfono: </label>
                    <input type="text" value="<%=te%>" name="cajatelefono" class="form-control"/>
                    <label>Camas: </label>
                    <input type="text" value="<%=ca%>" name="cajacamas" class="form-control"/><br/>
                    <button type="submit" class="btn btn-outline-info">Modificar</button>
                </form>
                <%
                }                
                %>
            </div>
        </main><!-- /.container -->
    </section>
    <jsp:include page="includes/webfooter.jsp" />
</body>
</html>


