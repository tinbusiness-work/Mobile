<%-- 
    Document   : login
    Created on : Dec 5, 2023, 3:49:47 PM
    Author     : tinhtse173630
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <!--your code here-->
        <form action="MainController" method="POST">
            UserID <input name="id" /> 
            <br>
            Password <input type="password" name="pass" />
            <br>
            <br>
            <input type="reset" value="Reset">
            <input name="action"  type="submit" value="Login" /> 
            <%
                String error = (String) request.getAttribute("ERROR");
                if (error == null) {
                    error = "";
                }
            %>
            <%= error%>
        </form>
    </body>
</html>
