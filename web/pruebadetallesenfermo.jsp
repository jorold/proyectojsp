
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Detalles enfermo</h1>
        <form method="post">
            <label>Número inscripción</label>
            <select name="cajainscripcion">
              <%
                  String sqlconsulta = "select * from enfermo";
                  Statement st = cn.createStatement();
                  ResultSet rs = st.executeQuery(sqlconsulta);
                  while(rs.next()){
                      String num = rs.getString("INSCRIPCION");
                      String ape = rs.getString("APELLIDO");
              %>
              <option value="<%=num%>"><%=ape%></option>
              <%
                  }
                  rs.close();
              %>  
            </select>
            <button type="submit">Consultar</button>
        </form>
            <%
                String dato = request.getParameter("cajainscripcion");
                if(dato != null){
                int numero = Integer.parseInt(dato);
                String sql = "select * from enfermo where inscripcion=?";
                PreparedStatement pst = cn.prepareCall(sql);
                pst.setInt(1, numero);
                rs = pst.executeQuery();
                while(rs.next()){
                String ins = rs.getString("INSCRIPCION");
                String apell = rs.getString("APELLIDO");
                String sexo = rs.getString("SEXO");
            %>
            <ul>
                <li><%=ins%></li>
                <li><%=apell%></li>
                <li><%=sexo%></li>
            </ul>
            <%
                }
                rs.close();
                cn.close();
                }
            %>
    </body>
</html>
