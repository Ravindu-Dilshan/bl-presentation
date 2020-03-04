<%-- 
    Document   : dashboard
    Created on : Dec 27, 2019, 11:03:16 AM
    Author     : Admins
--%>
<%@page import="com.mycompany.presentationtier.BussinessServiceProxy"%>
<%@page import="classes.Category"%>
<%@page import="com.mycompany.bussinesstier.BussinessService"%>
<%@page import="com.mycompany.presentationtier.GetUserSession"%>
<%@page import="com.mycompany.presentationtier.UserSession"%>
<%@page import="com.mycompany.presentationtier.UserLogin"%>
<!-- START OF MAIN CONTENT -->
<%
    String type = "";
    UserSession userSession = GetUserSession.getSession(request, session);
    if (userSession != null) {
        type = userSession.getUser().getType();
    }
%>
<div class="mainleft">
    <div class="mainleftinner">
        <div class="leftmenu">
            <ul><%BussinessService proxy = BussinessServiceProxy.getProxy();%>
                <%if (type.equalsIgnoreCase("admin")) {%>
                <li><a href="view_products.jsp" class="tables menudrop"><span>Products</span></a>
                    <ul>
                        <%for (Category c : proxy.getAllCategory()) {%>
                        <li><a href="view_products.jsp?category=<%=c.getName()%>">
                                <span><%=c.getName()%></span></a></li>
                                <%}%>
                    </ul>
                </li>
                <li><a href="manage_category.jsp" class="tables"><span>Categories</span></a></li>
                <li><a href="view_stocks.jsp" class="tables"><span>Stocks</span></a></li>
                <li><a href="view_users.jsp" class="users"><span>Users</span></a></li>
                <li><a href="view_vendors.jsp" class="users"><span>Vendors</span></a></li>
                <li><a href="view_orders.jsp" class="calendar"><span>Orders</span></a></li>
                <li><a href="view_sales.jsp" class="charts"><span>Sales</span></a></li>
                <li><a href="reports.jsp" class="editor"><span>Reports</span></a></li>
                    <%} else if (type.equalsIgnoreCase("manager")) {%>
                <li><a href="view_products.jsp" class="tables menudrop"><span>Products</span></a>
                    <ul>
                        <%for (Category c : proxy.getAllCategory()) {%>
                        <li><a href="view_products.jsp?category=<%=c.getName()%>">
                                <span><%=c.getName()%></span></a></li>
                                <%}%>
                    </ul>
                </li>
                <li><a href="manage_category.jsp" class="tables"><span>Categories</span></a></li>
                <li><a href="view_stocks.jsp" class="tables"><span>Stocks</span></a></li>
                <li><a href="view_orders.jsp" class="calendar"><span>Orders</span></a></li>
                <li><a href="view_sales.jsp" class="charts"><span>Sales</span></a></li>
                <li><a href="reports.jsp" class="editor"><span>Reports</span></a></li>
                    <%} else if (type.equalsIgnoreCase("vendor")) {%>
                <li><a href="products.jsp" class="grid menudrop"><span>Products</span></a>
                    <ul>
                        <%for (Category c : proxy.getAllCategory()) {%>
                        <li><a href="products.jsp?category=<%=c.getName()%>">
                                <span><%=c.getName()%></span></a></li>
                                <%}%>
                    </ul>
                </li>
                <li><a href="stocks.jsp" class="grid"><span>Stocks</span></a></li>
                <li><a href="shopping_cart.jsp" class="tables"><span>Shopping Cart</span></a></li>
                    <%} else if (type.equalsIgnoreCase("cashier")) {%>
                <li><a href="sale_products.jsp" class="grid menudrop"><span>Products</span></a>
                    <ul>
                        <%for (Category c : proxy.getAllCategory()) {%>
                        <li><a href="sale_products.jsp?category=<%=c.getName()%>">
                                <span><%=c.getName()%></span></a></li>
                                <%}%>
                    </ul>
                </li>
                <li><a href="cashier_sales.jsp" class="tables"><span>Sales</span></a></li>
                <li><a href="payment.jsp" class="tables"><span>Cart</span></a></li>
                    <%}%>
            </ul>

        </div><!--leftmenu-->
        <div id="togglemenuleft"><a></a></div>
    </div><!--mainleftinner-->
</div><!--mainleft-->

