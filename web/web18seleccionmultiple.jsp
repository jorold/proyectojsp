<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Selección múltiple elementos</h1>
        <form method="post">
            <ul>
                <li>
                    <input type="checkbox" name="color" value="rojo"/>Rojo
                </li>
                <li>
                    <input type="checkbox" name="color" value="verde"/>Verde
                </li>
                <li>
                    <input type="checkbox" name="color" value="azul"/>Azul
                </li>
                <li>
                    <input type="checkbox" name="color" value="amarillo"/>Amarillo
                </li>
            </ul>
            <button type="submit">Mostrar seleccionados</button>                
        </form>
        <hr/>
        <%
        //capturamos todos los seleccionados
        String[] colores = request.getParameterValues("color");
        if(colores != null){
            //recorremos todo el array para mostrar los datos
            for(String color: colores){
                %>
                <h2><%=color%></h2>
                <%
            }
        }
        %>
    </body>
</html>
