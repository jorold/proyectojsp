<!--create view empleadoshospital
as
select empleado_no as idempleado,
apellido, funcion, hospital_cod
from plantilla
union
select doctor_no, apellido, especialidad, 
hospital_cod
from doctor;-->
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
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">

                <div class="starter-template">
                    <h1>Hospitales</h1>
                    <%
                    String sql = "select hospital_cod, nombre from hospital";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sql);
                        %>
                        <ul class="list-group-item">
                            <%
                            while(rs.next()){
                                String nombre = rs.getString("NOMBRE");
                                String cod = rs.getString("HOSPITAL_COD");
                                %>                                
                                <li class="list-group-item">
                                    <a href="web34empleadoshospital.jsp?hospital=<%=cod%>">
                                        Hospital: <%=nombre%>
                                    </a>
                                </li>                   
                                <%
                            }
                            rs.close();
                            cn.close();
                            %>
                        </ul>
                        <%
                    %>              
                </div>

            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
