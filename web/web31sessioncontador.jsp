<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Ejemplo simple de session</h1>
        <form method="post">
            <button type="submit">
                Incrementar contador
            </button>
        </form>
        <%
        int contador = 1;
        //necesitamos un objeto session
        HttpSession sesion = request.getSession();
        //deseamos almacenar el número de forma permanente
        //por lo que haremos una variable de session
        //pero el contador va ha tener dos posibilidades
        //1-Que todavía no hemos almacenado información
        //2-Si hemos almacenado información, debemos igualar
        //el contador a la sesión
        if(sesion.getAttribute("contador") != null){
            //hemos almacenado algo previamente
            contador = Integer.parseInt(sesion.getAttribute("contador").toString());            
        }
        %>
        <h1 style="color:red">
            Contador: <%=contador%>
        </h1>
        <%
        contador++;
        //almacenamos el numero en la sesion
            sesion.setAttribute("contador", contador);
        %>
    </body>
</html>
