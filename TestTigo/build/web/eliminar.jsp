<%@page contentType="text/html" language="java" pageEncoding="UTF-8"%>
<jsp:useBean id="bnConn" class="Resources.BeanConnection" scope="page" />
<%
    String id=request.getParameter("id");
    if(bnConn.deleteRecord(id))
        out.println(id);
    else
        out.println("fail");
%>