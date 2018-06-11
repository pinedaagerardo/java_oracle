<%@page contentType="text/html" language="java" pageEncoding="UTF-8"%>
<jsp:useBean id="bnConn" class="Resources.BeanConnection" scope="page" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insertar</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
    </head>
    <body class="container">
        <h1>Insertar</h1>
        <form action="fun1.jsp" method="post">
            <input type="text" name="txtVal" />
            <input type="submit" value="Enviar" />
        </form>
        El nuevo valor es:&nbsp;
        <%
            String valor = request.getParameter("txtVal");
            if(valor!=null && bnConn.insertNew(valor))
                out.println(valor);
            else
                out.println("Error. Insertar un valor");
        %> <br/>
        <a href="menu.html">Menu</a><br/>
    </body>
</html>
