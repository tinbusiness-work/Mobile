<%-- 
    Document   : staff
    Created on : Dec 5, 2023, 3:51:47 PM
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
        <title>Staff Page</title>
    </head>
    <body>
        <%
            Users loginUser = (Users) session.getAttribute("LOGIN_USER");
            if (loginUser == null || (loginUser.getRole() != 2 && loginUser.getRole() != 1)) {
                response.sendRedirect("login.jsp");
                return;
            }
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
        %>
        <a href="MainController?action=Logout" class="Logout">Logout</a>    
        <form action ="MainController">
            <input type ="text" placeholder="Search by ID " name ="search" value="<%=search%>" />
            <input type ="submit" name ="action" value ="Search" />
        </form>
        <%
            List<Mobile> listMobile = (List<Mobile>) request.getAttribute("LIST_MOBILE");
            if (listMobile != null) {
                if (listMobile.size() > 0) {
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
                    for (Mobile c : listMobile) {
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
                        <input type="text" name="price" value="<%= c.getPrice()%>" required="" size="10" min="0" inputmode="decimal" pattern="[0-9]*[.]?[0-9]*"/>
                    </td>
                    <td>
                        <input type="text" name="mobileName" value="<%= c.getMobileName()%>" required="" readonly="" size="15" />
                    </td>
                    <td>
                        <input type="number" name="yearOfProduction" value="<%= c.getYearOfProduction()%>" min="1870" max="2023" required="" readonly="" style="width: 60px;" />
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
                        <input type="hidden" name="search" value="<%= search%>"/>
                    </td>
                    <td>
                        <a href="MainController?search=<%=search%>&action=Delete&mobileId=<%=c.getMobileId()%>">Delete</a>
                    </td>
                </tr>
            </form>

            <%
                }
            %>
        </tbody>
    </table>
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

    <div>
        <form action="staffList.jsp" method="POST">
            <input type="submit" name="status" value="add">
        </form>
    </div>

    <% String status = request.getParameter("status");
        if (status != null && status.equals("add")) {
    %>

    <h1>Add New Mobile</h1>
    <form action="MainController" method="POST" >
        Mobile ID: <input type="text" name="mobileId" placeholder="Enter mobile ID (e.g. M123)"  pattern="[A-Z]\d{3}" required=""><br>
        Description: <input type="text" name="description" placeholder="Enter description (e.g. Samsung)" required="" size="30"><br>
        Price <input type="text" name="price" placeholder="Enter price (e.g. 55.52)" required="" min="0" inputmode="decimal" pattern="[0-9]*[.,]?[0-9]*"><br>
        Mobile Name: <input type="text" name="mobileName" placeholder="Enter mobile name (e.g. Samsung galaxy A18)" required="" size="40"><br>
        Year Of Production: <input type="number" name="yearOfProduction" placeholder="Enter year (e.g.2022)" min="1870" max="2023" required="" style="width: 200px;"><br>
        Quantity: <input type="text" name="quantity" placeholder="Enter quantity (e.g. 30)" min="0" required=""><br>
        Not Sale:
        True<input type="radio" name="notSale" value="True">
        False<input type="radio" name="notSale" value="False"> <br>
        <input type="submit" name="action" value="insert">
        <input type="reset" value="Reset">
    </form>

    <%}%>
</body>
</html>
