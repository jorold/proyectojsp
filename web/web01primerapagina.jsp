<%-- 
    Document   : web01primerapagina
    Created on : 08-ene-2021, 20:56:29
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
        <h1>Hello World!</h1>
        <%
            //código java dentro de un servlet
            //out nos permite escribir código java dentro de la página
            out.println("ESto es Java!!!");
            out.println("<h1>Título de Java</h1>");
            String texto = "Soy un texto escrito en Java";            
        %>
        <p>Podemos escribir código Java entre etiquetas HTML</p>
        <h2 style="color:blue">
            <%=texto%>
        </h2>
    </body>
</html>
