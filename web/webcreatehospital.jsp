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
    <style>
        button{
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="includes/webmenuhospital.jsp" />
    <section>
        <main role="main" class="container">
            <div class="starter-template">
                <h1>Crear hospital</h1>
                <form method="post">
                    <div>
                        <label>Número: </label>
                        <input type="text" name="cajanumero" class="form-control" required/>
                    </div>
                    <div>
                        <label>Nombre: </label>
                        <input type="text" name="cajanombre" class="form-control" required/>
                    </div>
                    <div>
                        <label>Dirección: </label>
                        <input type="text" name="cajadirec" class="form-control" required/>
                    </div>
                    <div>
                        <label>Teléfono:  </label>
                        <input type="text" name="cajatelefono" class="form-control" required/>
                    </div>
                    <div>
                        <label>Número camas:  </label>
                        <input type="text" name="cajacamas" class="form-control" required/>
                    </div>
                    <button type="submit" class="btn-lg btn-success">
                                Insertar
                    </button>
                </form>
                <%
                String cajanumero = request.getParameter("cajanumero");
                String cajanombre = request.getParameter("cajanombre");
                String cajadirec = request.getParameter("cajadirec");
                String cajatelefono = request.getParameter("cajatelefono");
                String cajacamas = request.getParameter("cajacamas");
                if(cajanumero != null){
                    int codigo = Integer.parseInt(cajanumero);
                    int telefo = Integer.parseInt(cajatelefono);
                    int camas = Integer.parseInt(cajacamas);
                String sqlinsert = "insert into hospital values (?,?,?,?,?)";
                PreparedStatement pst = cn.prepareStatement(sqlinsert);
                    pst.setInt(1, codigo);
                    pst.setString(2, cajanombre);
                    pst.setString(3, cajadirec);;
                    pst.setInt(4, telefo);
                    pst.setInt(5, camas);
                int creados = pst.executeUpdate();
                cn.close();
                %>
                <jsp:forward page="webindexhospital.jsp"/>
                <%
                }
                %>
            </div>
        </main><!-- /.container -->
    </section>
    <jsp:include page="includes/webfooter.jsp" />
</body>
</html>


