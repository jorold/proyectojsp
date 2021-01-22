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
        <title>Mostrar</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">

                <div class="starter-template">
                    <a href="web32almacenarsalarios.jsp">Almacenar salarios</a>
                    <h1>Mostrar salarios</h1>
                    <a href="web32mostrarsalarios.jsp?eliminar=ok" 
                       class="btn btn-danger">
                           Borrar datos Session
                    </a>
                    <%
                        //si recibimos eliminar, borramos la session
                        //siempre debe borrarse antes de dibujar
                    if(request.getParameter("eliminar") != null){
                        session.setAttribute("sumasalarial", null);
                    }
                    if(session.getAttribute("sumasalarial")== null){
                        //no tenemos datos
                        %>
                        <h1 style="color:red">No hay datos en session</h1>
                        <%
                    }else{
                        //tenemos datos
                        String datos = session.getAttribute("sumasalarial").toString();
                        %>
                        <h1 style="color:darkslateblue">
                            Suma salarial : <%=datos%>
                        </h1>
                        <%
                    }
                    %>
                </div>

            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>

