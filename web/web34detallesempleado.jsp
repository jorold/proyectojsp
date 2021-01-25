<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
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
                    <h1>Detalles Empleados</h1>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>IdEmpleado</th>
                                <th>Apellido</th>
                                <th>Función</th>
                                <th>Código Hospital</th>
                                <th><img src="images/caja.jpg"></th>                        
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            String archivador = request.getParameter("almacenado");
                            ArrayList<Integer> personal = (ArrayList)session.getAttribute("PERSONAL");
                            if(archivador != null){
                                int almacenado = Integer.parseInt(archivador);
                                    if(session.getAttribute("PERSONAL") != null){
                                    personal = (ArrayList)session.getAttribute("PERSONAL");
                                    }else{
                                        personal = new ArrayList();
                                    }
                                    personal.add(almacenado);
                                session.setAttribute("PERSONAL", personal);
                                %>
                                <h2 style="color:darkorchid">Empleados almacenados: <%=personal.size()%></h2>
                                <%
                            }
                            //--------------------------------------------------    
                            String dato = request.getParameter("idempleado");
                            if(dato != null){
                                int idempleado = Integer.parseInt(dato);
                                String sqlselect = "select * from empleadoshospital "
                                        + "where idempleado =?";
                                PreparedStatement pst = cn.prepareStatement(sqlselect);
                                pst.setInt(1, idempleado);
                                ResultSet rs = pst.executeQuery();
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
                                    <td><a class="btn btn-outline-warning" 
                                           href="web34detallesempleado.jsp?almacenado=<%=id%>">
                                            Almacenar empleado
                                        </a>
                                    </td>
                                </tr>
                                <%
                                    }
                            rs.close();
                            cn.close();
                            }
                            %>
                        </tbody>
                    </table>
                </div>
                
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
