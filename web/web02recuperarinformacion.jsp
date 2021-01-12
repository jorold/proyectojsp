<%-- 
    Document   : web02recuperarinformacion
    Created on : 11-ene-2021, 16:44:32
    Author     : jorold
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Recuperar información GET</h1>
        <a href="web02informacionservidor.jsp">Volver a enviar información</a>
        <%
            //los parámetros siempre se recuperan con String aunque sean números
            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
        %>
        <h1 style="color:blue">
            Nombre: <%=nombre%>
        </h1>
        <h1 style="color:red">
            Apellidos: <%=apellidos%>
        </h1>        
    </body>
</html>
