<%-- 
    Document   : viewCart
    Created on : Dec 7, 2023, 11:23:05 AM
    Author     : tinhtse173630
--%>

<%@page import="dao.DAO"%>
<%@page import="dto.Mobile"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart Page</title>
    </head>
    <body>

        <table class="table" border="1">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Mobile ID</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Mobile Name</th>
                    <th>Year Of Production</th>
                    <th>Quantity</th>
                    <th>Not Sale</th>
                    <th>Delete To Cart</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 1;

                    HashMap<String, Integer> cart = (HashMap<String, Integer>) session.getAttribute("cart");
                    if (cart != null) {
                        Set<String> mobileIds = cart.keySet();
                        for (String mobileId : mobileIds) {
                            int number = cart.get(mobileId);
                            DAO dao = new DAO();
                            List<Mobile> mobileList = dao.getMobileList(mobileId);
                            if (mobileList != null) {
                                for (Mobile c : mobileList) {
                %>           
            <form action="MainController" >
                <tr>
                    <td><%= count++%></td>
                    <td>
                        <%= c.getMobileId()%>
                    </td>
                    <td>
                        <%= c.getDescription()%>
                    </td>
                    <td>
                        <%= c.getPrice()%>
                    </td>
                    <td>
                        <%= c.getMobileName()%>
                    </td>
                    <td>
                        <%= c.getYearOfProduction()%>
                    </td>
                    <td>
                        <input type="number" name="quantity" value="<%= number%>" readonly="">
                    </td>
                    <td>
                        <%= c.isNotSale()%>
                    </td>

                    <td>
                        <input type="hidden" name="action" value="addToDataBase">
                        <input type="hidden" name="mobileId" value="<%=c.getMobileId()%>">
                        <input type="hidden" name="quantity" value="<%=number%>">

                        <button type="submit">Add to Database</button>
                    </td>

                    <td>
                        <a href="MainController?&action=deleteToCart&mobileId=<%=c.getMobileId()%>">Delete To Cart</a>
                    </td>
                </tr>
                </tbody>
                <%
                            }
                        }
                    }
                } else {
                %>
                <tr><td>Your cart is empty</td></tr>
                <%
                    }
                %>
            </form>
        </table>

        <h1>
            <a href="userList.jsp"> User Page</a>
        </h1>
    </body>
</html>
