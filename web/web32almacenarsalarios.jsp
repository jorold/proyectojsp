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
        <title>Almacenar</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">

                <div class="starter-template">
                    <a href="web32mostrarsalarios.jsp">Mostrar salarios</a>
                    <h1>Almacenar salarios</h1>
                    <%
                    String sql = "select * from emp";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sql);
                    %>
                    <ul class="list-group">
                        <%
                        while(rs.next()){
                            String apellido = rs.getString("APELLIDO");
                            String sal = rs.getString("SALARIO");
                            %>
                            <li class="list-group-item">
                                <a href="web32almacenarsalarios.jsp?salario=<%=sal%>">
                                    Almacenar salario <%=apellido%>
                                </a>
                            </li>
                            <%
                        }
                        rs.close();
                        cn.close();
                        %>
                    </ul>
                    <%
                        //vamos a almacenar cada salario que venga de forma persistente
                        int sumasalarial = 0;
                        //preguntamos si hemos recibido algún dato
                        if(session.getAttribute("sumasalarial") != null){
                           //tenemos algo en session
                           sumasalarial = (Integer)session.getAttribute("sumasalarial");
                        }else{
                            //no hay nada almacenado e inicializamos la variable
                            sumasalarial = 0;
                        }
                        String dato = request.getParameter("salario");
                        if (dato != null){
                            int salario = Integer.parseInt(dato);
                            //sumamos el salario a la suma salarial
                            sumasalarial += salario;
                            //almacenamos la suma salarial en la session
                            //para hacerla persistente
                            session.setAttribute("sumasalarial", sumasalarial);
                            %>
                            <h1 style="color:darkmagenta">Datos almacenados: <%=dato%></h1>
                            <%
                        }
                    %>
                </div>

            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>

