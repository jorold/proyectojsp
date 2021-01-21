<%@page import="java.sql.PreparedStatement"%>
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
        <jsp:include page="includes/webhead.jsp"/>
        <title>JSP Page</title>
        <style>
            button{
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="includes/webmenudepartamentos.jsp"/>
        <section>
            <main role="main" class="container">

                <div class="starter-template">
                    <h1>Crear departamentos</h1>
                    <form method="post">
                        <div>
                            <label>Número: </label>
                            <input type="text" name="cajanumero"
                                   class="form-control" required/>
                        </div>
                        <div>
                            <label>Nombre: </label>
                            <input type="text" name="cajanombre"
                                   class="form-control" required/>
                        </div>
                        <div>
                            <label>Localidad: </label>
                            <input type="text" name="cajalocalidad"
                                   class="form-control" required/>
                        </div>
                        <div>
                            <button type="submit" class="btn-lg btn-success">
                                Insertar
                            </button>
                        </div>
                    </form>
                    <%
                    String cajanumero = request.getParameter("cajanumero");
                    String cajanombre = request.getParameter("cajanombre");
                    String cajalocalidad = request.getParameter("cajalocalidad");
                    if(cajanumero != null){
                        int numero = Integer.parseInt(cajanumero);
                        String sql = "insert into dept values (?,?,?)";
                        PreparedStatement pst = cn.prepareStatement(sql);
                        pst.setInt(1, numero);
                        pst.setString(2, cajanombre);
                        pst.setString(3, cajalocalidad);
                        int insertados = pst.executeUpdate();
                        cn.close();
                        //tenemos dos opciones
                        //1)mostrar un mensaje al usuario
                        //2)ir a otra página, para hacer redirecciones en java
                        //se utiliza la etiqueta forward
                        
                        %>
                        <h2 style="color:blue">Insertados: <%=insertados%></h2>
                        <jsp:forward page="web27indexdept.jsp"/>
                        <%
                    }
                    %>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
