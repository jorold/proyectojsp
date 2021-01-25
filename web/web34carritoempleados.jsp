<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
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
        <style>
            img{
                width: 40px;
                height: 40px;
            }
        </style>
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">

                <div class="starter-template">
                    <h1>Carrito Empleados</h1>
                    <%
                        //session.setAttribute("EMPLEADOS", null);
                    String datoborrar = request.getParameter("borrar");
                        if(datoborrar != null){
                            int idborrar = Integer.parseInt(datoborrar);                            
                            ArrayList<Integer> id = (ArrayList)session.getAttribute("PERSONAL");
                            id.remove((Integer)idborrar);
                            if(id.size() == 0){
                                session.setAttribute("PERSONAL", null);
                            }else{
                                session.setAttribute("PERSONAL", id);
                            }
                        }
                    //----------------------------------------------------------
                    if(session.getAttribute("PERSONAL") == null){
                        %>
                        <h2 style="color:darkred">No existen empleados almacenados</h2>
                        <%
                    }else{
                            ArrayList<Integer> personal = (ArrayList)session.getAttribute("PERSONAL");
                    String codigo = "";
                    for(int id: personal){
                        codigo += id + ",";
                    }
                        int lastcoma = codigo.lastIndexOf(",");
                        codigo = codigo.substring(0, lastcoma);
                        String sqlmostrar = "select * from empleadoshospital "
                                + "where idempleado in ("+ codigo +")";
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery(sqlmostrar);
                        %>
                        <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>IdEmpleado</th>
                                <th>Apellido</th>
                                <th>Función</th>
                                <th>Código Hospital</th>                                
                                <th><img src="images/borrador.jpg" alt=""/></th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                        while(rs.next()){
                                    String id = rs.getString("IDEMPLEADO");
                                    String ap = rs.getString("APELLIDO");
                                    String fu = rs.getString("FUNCION");
                                    String ho = rs.getString("HOSPITAL_COD");
                        %>
                                    <tr>
                                    <td><%=id%></td>
                                    <td><%=ap%></td>
                                    <td><%=fu%></td>
                                    <td><%=ho%></td>
                                    <td>
                                    <a class="btn btn-outline-danger"
                                        href="web34carritoempleados.jsp?borrar=<%=id%>">
                                        Borrar
                                    </a>
                                    </tr>
                        <%
                        }                        
                        %>
                        </tbody>
                        </table>
                    <%
                    rs.close();
                    cn.close();
                     }
                    %>
                </div>

            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
