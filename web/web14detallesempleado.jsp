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
        <h1>Detalles empleado</h1>
        <form method="post">
            <label>Número empleado</label>
            <select name="cajanumero">
               <%
                   String sql = "select * from emp";
                   Statement st = cn.createStatement();
                   ResultSet rs = st.executeQuery(sql);
                   while (rs.next()){
                       String apellido = rs.getString("APELLIDO");
                       String empno = rs.getString("EMP_NO");
                       %>
                       <option value="<%=empno%>"><%=apellido%></option>
                        <%
                   }
                   rs.close();
               %>
            </select>
            <button type="submit">Mostrar detalles</button>
        </form>        
            <%
                String dato = request.getParameter("cajanumero");
                if (dato != null){
                    int empleado = Integer.parseInt(dato);
                    String sqlempleado = "select * from emp where emp_no=?";
                    PreparedStatement pst = cn.prepareStatement(sqlempleado);
                    pst.setInt(1, empleado);
                    rs = pst.executeQuery();                  
                        if (rs.next()){
                        String ap = rs.getString("APELLIDO");
                        String of = rs.getString("OFICIO");
                        String sal = rs.getString("SALARIO");  
                        %>
                        <h1><%=ap%></h1>
                        <h1><%=of%></h1>
                        <h1><%=sal%></h1>
                        <%
                        } else {
                        %>
                        <h1 style="color:red">No existe empleado con ese número</h1>
                        <%
                        }                  
                        rs.close();
                        cn.close();
                }
            %>
    </body>
</html>
