<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena ="jdbc:oracle:thin:@localhost:1521:xe";
Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Paginación simple</h1>
        <style>
            ul#menu li {
                display: inline;
            }
        </style>
        <%
        String sql = "select * from emp";
        Statement st = cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sql);
        //NECESITAMOS REALIZAR LAS VARIABLE PARA EL MOVIMIENTO
        int siguiente, anterior, ultimo;
        //EL ÚLTIMO ES FIJO COMO EL PRIMERO, SERÁN EL NUMERO DE ELEMENTOS
        //QUE TIENE LA CONSULTA, PEDIMOS QUE VAYA AL ÚLTIMO REGISTRO
        rs.last();
        //AVERIGUAMO EL VALOR DE LA FILA
        ultimo = rs.getRow();
        //NECESITAMOS SABER LA POSICION EN LA QUE DESEAMOS EL CURSOR
        int posicion = 1;
        if(request.getParameter("posicion")== null){
            siguiente = posicion + 1;
            anterior = 1;
        }else{
            String dato = request.getParameter("posicion");
            posicion = Integer.parseInt(dato);
            //COMPROBAMOS LA POSICION PARA NO PASARNOS
            if (posicion == 1){
                anterior = 1;
            }else{
                anterior = posicion - 1;
            }
            if (posicion == ultimo){
                siguiente = ultimo;
            }else{
                siguiente = posicion + 1;
            }
        }
        //PONEMOS EL CURSOR EN LA POSICION
        rs.absolute(posicion);
        %>
        <dl>
            <dt>Apellido: <b><%=rs.getString("APELLIDO")%></b></dt>
            <dt>Oficio: <%=rs.getString("OFICIO")%></dt>
            <dt>Salario: <%=rs.getString("SALARIO")%></dt>
        </dl>
        <h2 style="color:darkmagenta">Registro <%=posicion%> de <%=ultimo%></h2>
        <%
            rs.close();
            cn.close();
        %>
        <hr/>
        <ul id="menu">
            <li>
                <a href="web22paginacionsimple.jsp?posicion=1">Primero</a>
            </li>
                        <li>
                <a href="web22paginacionsimple.jsp?posicion=<%=siguiente%>">Siguiente</a>
            </li>
                        <li>
                <a href="web22paginacionsimple.jsp?posicion=<%=anterior%>">Anterior</a>
            </li>
                        <li>
                <a href="web22paginacionsimple.jsp?posicion=<%=ultimo%>">Último</a>
            </li>
        </ul>            
    </body>
</html>
