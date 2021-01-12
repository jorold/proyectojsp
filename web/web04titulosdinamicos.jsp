<%-- 
    Document   : web04titulosdinamicos
    Created on : 11-ene-2021, 17:31:02
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
        <h1>Títulos dinámicos JSP</h1>
        <%
            for (int i = 1; i <=6; i++){
                //cerramos java y abrimos java
                %>
                        <h<%=i%>>Titulo <%=i%></h<%=i%>>
                <%
            }
        %>
        <h1>Título 1</h1>
        <h2>Título 2</h2>
        <h3>Título 3</h3>
        <h4>Título 4</h4>
        <h5>Título 5</h5>
        <h6>Título 6</h6>        
    </body>
</html>
