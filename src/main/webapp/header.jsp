<%-- 
    Document   : header
    Created on : Dec 27, 2019, 11:11:03 AM
    Author     : Admins
--%>

<%@page import="com.mycompany.presentationtier.GetUserSession"%>
<%@page import="com.mycompany.presentationtier.UserSession"%>
<%@page import="com.mycompany.presentationtier.UserLogin"%>
<!-- START OF HEADER -->
<div class="header radius3">
    <div class="headerinner">

        <a href="#"><img src="images/logoWhite.png" alt="" width="120" height="60" alt="" /></a>

        <%
            String name = "name";
            String type = "";
            UserSession userSession = GetUserSession.getSession(request, session);
            if (userSession == null) {
                response.sendRedirect("index.jsp");
                return;
            } else {
                name = userSession.getUser().getFName();
                type = userSession.getUser().getType();
            }
        %>
        <div class="headright">
            <div id="notiPanel" class="headercolumn">
            </div>
            <div id="userPanel" class="headercolumn">
                <a href="#" class="userinfo radius2">
                    <img src="images/avatar.png" alt="" class="radius2" />
                    <span><strong><%out.println(name);%></strong></span>
                </a>
                <div class="userdrop">
                    <ul>
                        <li><a href="manage_profile.jsp">Account Settings</a></li>
                            <%if (type.equalsIgnoreCase("Cashier")) {%>
                        <li><a href="cashier_sales.jsp">My Sales</a></li>
                            <%} else if (type.equalsIgnoreCase("vendor")) {%>
                        <li><a href="vendor_orders.jsp">My Orders</a></li>
                            <%}%>

                        <li><a href="UserLogout">Logout</a></li>
                    </ul>
                </div><!--userdrop-->
            </div><!--headercolumn-->
        </div><!--headright-->

    </div><!--headerinner-->
</div><!--header-->
<!-- END OF HEADER -->
