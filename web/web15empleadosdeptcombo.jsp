
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
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
        <h1>Empleados departamentos select</h1>
        <form method="post">
            <select name="selectdeptno" class="form-control" style="margin-bottom: 10px">
                <%
                    String sqldept = "select * from dept";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sqldept);
                    while (rs.next()) {
                        String nombre = rs.getString("DNOMBRE");
                        String deptno = rs.getString("DEPT_NO");
                %>
                <option value="<%=deptno%>"><%=nombre%></option>
                <%
                    }
                    rs.close();
                %>
            </select>
            <button type="submit" class="btn btn-outline-success">Mostrar empleados</button>
        </form>
            <hr/>
            <table class="table">
                <thead>
                    <tr>
                        <th>APELLIDO</th>
                        <th>OFICIO</th>
                        <th>DEPARTAMENTO</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String dato = request.getParameter("selectdeptno");
                        if (dato != null){
                            int num = Integer.parseInt(dato);
                            String sqlemp = "select * from emp where dept_no=?";
                            PreparedStatement pst = cn.prepareStatement(sqlemp);
                            pst.setInt(1, num);
                            rs = pst.executeQuery();
                            while(rs.next()){
                                String ape = rs.getString("APELLIDO");
                                String ofi = rs.getString("OFICIO");
                                String numero = rs.getString("DEPT_NO");
                    %>
                    <tr>
                        <td><%=ape%></td>
                        <td><%=ofi%></td>
                        <td><%=numero%></td>
                    </tr>
                    <%
                            }
                            rs.close();
                        }
                        cn.close();
                    %>
                </tbody>
            </table>
    </body>
</html>
