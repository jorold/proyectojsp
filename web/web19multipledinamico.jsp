<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String[] ingredientes = new String[]
{"Sal","Azucar", "Leche", "Mandarinas", "Cacao", "Avellanas"};
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Selección múltiple dinámico</h1>
        <form method="post">
            <ul>
                <%
                for (String ing: ingredientes){
                    %>
                    <li>
                        <input type="checkbox" name="ingrediente" value="=<%=ing%>"/><%=ing%>
                    </li>
                    <%
                }
                %>
            </ul>
            <button type="submit">Mostrar selecionados</button>
        </form>
            <hr/>
            <%
            String[] datos = request.getParameterValues("ingrediente");
            if(datos != null){
                for (String dato: datos){
                    %>
                    <h3 style="color:blue"><%=dato%></h3>
                    <%
                }
            }
            %>
    </body>
</html>
