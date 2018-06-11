<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" language="java" pageEncoding="UTF-8"%>
<jsp:useBean id="bnConn" class="Resources.BeanConnection" scope="page" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consultar</title>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
    </head>
    <body class="container">
        <h1>Consultar</h1>
        <a href="menu.html">Menu</a><br/>
        <table class="table table-striped table-condensed table-hover">
            <thead>
                <tr class="row">
                    <th class="col-sm-1" custom-sort order="'deletebtn'" sort="sort">&nbsp;</th>
                    <th class="col-sm-1" custom-sort order="'updatebtn'" sort="sort">&nbsp;</th>
                    <th class="col-sm-4" custom-sort order="'id'" sort="sort">Id&nbsp;</th>
                    <th class="col-sm-4" custom-sort order="'name'" sort="sort">Name&nbsp;</th>
                </tr>
            </thead>
            <tbody>
            <%
                ResultSet rs=bnConn.getAll();
                while(rs!=null && rs.next()){
                    out.println("<tr class=\"row\" >");
                    out.println("<td class=\"col-sm-1\" ><button onclick=\"deleteRecord('"+rs.getInt("id")+"')\" >Borrar</button></td>");
                    out.println("<td class=\"col-sm-1\" ><button onclick=\"updateRecord('"+rs.getInt("id")+"')\" >Guardar</button></td>");
                    out.println("<td class=\"col-sm-4\" >"+rs.getInt("id")+"</td>");
                    out.println("<td class=\"col-sm-4\" ><input type=\"text\" id=\"txt"+rs.getInt("id")+"\" value=\""+rs.getString("name")+"\" /></td>");
                    out.println("</tr>");
                }
            %>
            </tbody>
        </table>
        <a href="menu.html">Menu</a><br/>
    </body>
    <script>
        function deleteRecord(myId){
            $.post( "eliminar.jsp", { id: myId })
                .done(function( data ) {
                    //alert( "Eliminado: " + data );
                    location.reload();
                });
        }
        function updateRecord(myId){
            var myName=document.getElementById("txt"+myId).value;
            $.post( "actualizar.jsp", { id: myId , name: myName})
                .done(function( data ) {
                    //alert( "Eliminado: " + data );
                    location.reload();
                });
        }
    </script>
</html>
