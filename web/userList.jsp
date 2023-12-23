<%-- 
    Document   : userList
    Created on : Dec 5, 2023, 3:52:22 PM
    Author     : tinhtse173630
--%>

<%@page import="java.util.List"%>
<%@page import="dto.Mobile"%>
<%@page import="dto.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
    </head>
    <body>
        <%
            Users loginUser = (Users) session.getAttribute("LOGIN_USER");
            if (loginUser == null || loginUser.getRole() != 0) {
                response.sendRedirect("login.jsp");
                return;
            }

            String minPrice = request.getParameter("minPrice");
            String maxPrice = request.getParameter("maxPrice");
            if (minPrice == null || minPrice.isEmpty()) {
                minPrice = "0";
            }
            if (maxPrice == null || maxPrice.isEmpty()) {
                maxPrice = "999999";
            }
        %>

        <a href="MainController?action=Logout" class="Logout">Logout</a>    
        <form action="MainController">
            <input type="number" placeholder="Minimum Price" name="minPrice" value="<%=minPrice%>" />
            <input type="number" placeholder="Maximum Price" name="maxPrice" value="<%=maxPrice%>"/>
            <input type="submit" name="action" value="searchPrice" />
        </form>
        <%
            List<Mobile> listMobilePriceInRange = (List<Mobile>) request.getAttribute("LIST_MOBILE_PRICE_RANGE");
            if (listMobilePriceInRange != null) {
                if (listMobilePriceInRange.size() > 0) {
        %>
        </br>
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
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 1;
                    for (Mobile c : listMobilePriceInRange) {
                %>           
            <form action="MainController" >
                <tr>
                    <td><%= count++%></td>
                    <td>
                        <input type="text" name="mobileId" value="<%= c.getMobileId()%>" required="" size="10" readonly="" />
                    </td>
                    <td>
                        <input type="text" name="description" value="<%= c.getDescription()%>" required="" size="30" />
                    </td>
                    <td>
                        <input type="text" name="price" value="<%= c.getPrice()%>" required="" size="10" min="0" inputmode="decimal" pattern="[0-9]*[.,]?[0-9]*"/>
                    </td>
                    <td>
                        <input type="text" name="mobileName" value="<%= c.getMobileName()%>" required="" size="15" />
                    </td>
                    <td>
                        <input type="number" name="yearOfProduction" value="<%= c.getYearOfProduction()%>" min="1870" max="2023" required=""  style="width: 60px;" />
                    </td>
                    <td>
                        <input type="number" name="quantity" value="<%= c.getQuantity()%>" min="0" required=""  style="width: 40px;" />
                    </td>
                    <td>
                        <input type="text" name="notSale" value="<%= c.isNotSale()%>" required="" readonly="" size="7" />
                    </td>
                    <td>
                        <input type="submit" name="action" value="Update"/>
                        <input type="hidden" name="mobileId" value="<%= c.getMobileId()%>"/>
                        <input type="hidden" name="minPrice" value="<%= minPrice%>"/>
                        <input type="hidden" name="maxPrice" value="<%= maxPrice%>"/>
                    </td>
                    <td>
                        <a href="MainController?minPrice=<%= minPrice%>&maxPrice=<%= maxPrice%>&action=addToCart&mobileId=<%=c.getMobileId()%>">Add To Cart</a>
                    </td>
                </tr>
            </form>

            <%
                }
            %>
        </tbody>
    </table>

    <h1><a href="viewCart.jsp">View Cart</h1>

    <div class="error-message">
        <%
            String error = (String) request.getAttribute("ERROR");
            if (error == null) {
                error = "";
            }
        %>
        <%= error%>
    </div>

    <%
            }
        }
    %>
    
</body>
</html>
