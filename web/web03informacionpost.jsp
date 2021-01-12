<%-- 
    Document   : web03informacionpost
    Created on : 11-ene-2021, 17:07:51
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
        <h1>Información POST</h1>
        <form method="post">
            <label>Nombre: </label>
            <input type="text" name="cajanombre"/>
            <button type="submit">Enviar información</button>
        </form>
        <%
                String dato = request.getParameter("cajanombre");
                //debemos comprobar si hemos recibido el dato antes de pintarlo
                if(dato != null){
                    //debemos de pintar código html de java entre html
                    //debemos cerrar java y abrir java
                %>
                <h1 style="color:red">
                    <%=dato%>
                </h1>
                <%
                }
        %>
        
        </h1>
    </body>
</html>
