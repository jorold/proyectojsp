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
    String delete = request.getParameter("delete");
    if(delete != null){
        int codigo = Integer.parseInt(delete);
    String sqldelete = "delete from hospital where hospital_cod =?";
    PreparedStatement pst = cn.prepareStatement(sqldelete);
        pst.setInt(1, codigo);
    pst.executeUpdate();
    }
    %>
    <jsp:include page="includes/webmenuhospital.jsp" />
    <section>
        <main role="main" class="container">
            <div class="starter-template">
                <h1>Home hospitales</h1>
                <%
                String sql = "select * from hospital order by hospital_cod";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql);
                %>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Número hospital</th>
                        <th>Nombre</th>
                        <th>Dirección</th>
                        <th>Teléfono</th>
                        <th>Número camas</th>
                        <th>Pulsar opción</th>
                    </tr>
                    </thead>
                    <tbody>
                        <%
                        while(rs.next()){
                            String nh = rs.getString("HOSPITAL_COD");
                            String no = rs.getString("NOMBRE");
                            String di = rs.getString("DIRECCION");
                            String te = rs.getString("TELEFONO");
                            String ca = rs.getString("NUM_CAMA");
                            %>
                            <tr>
                                <td><%=nh%></td>
                                <td><%=no%></td>
                                <td><%=di%></td>
                                <td><%=te%></td>
                                <td><%=ca%></td>
                                <td>
                                    <a class="btn btn-outline-primary" 
                                       href="webdetailshospital.jsp?hospcod=<%=nh%>">Detalles</a>
                                    <a class="btn btn-outline-success" 
                                       href="webupdatehospital.jsp?hospcod=<%=nh%>">Modificar</a>
                                    <a class="btn btn-outline-danger" 
                                       href="webindexhospital.jsp?delete=<%=nh%>">Eliminar</a>
                                </td>
                            </tr>                            
                            <%
                        }
                        rs.close();
                        cn.close();
                        %>
                    </tbody>
                </table>
            </div>
        </main><!-- /.container -->
    </section>
    <jsp:include page="includes/webfooter.jsp" />
</body>
</html>

