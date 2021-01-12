<%-- 
    Document   : web06tablamultiplicar
    Created on : 11-ene-2021, 19:27:11
    Author     : jorold
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
       
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Tabla multiplicar</h1>
        <form method="post">
        <label>Introduzca un número</label>
        <input type="number" name="cajanumero" required />
        <button type="submit">Mostrar tabla</button>
    </form>
    <%
    String dato = request.getParameter("cajanumero");
    if (dato != null){
    int numero = Integer.parseInt(dato);
    %>
    <table class="table">
        <tr>
            <th>Operación</th>
            <th>Resultado</th>
        </tr>
        <%
        for (int i = 1; i <= 10; i++){
        int operacion = numero * i;
        %>
        <tr>
            <td><%=numero%>*<%=i%></td>
            <td><%=operacion%></td>
        </tr>
        <%
        }
        %>
    </table>
    <%
    }
    %>

    </body>
</html>
