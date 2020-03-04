<%-- 
    Document   : manage_users
    Created on : Dec 30, 2019, 8:12:07 PM
    Author     : Admins
--%>
<%@page import="com.mycompany.presentationtier.BussinessServiceProxy"%>
<%@page import="classes.User"%>
<%@page import="com.mycompany.bussinesstier.BussinessService"%>
<%@page import="com.mycompany.bussinesstier.BussinessService_Service"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>BlackLotus</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <script type="text/javascript" src="js/plugins/jquery-1.7.min.js"></script>
        <script type="text/javascript" src="js/plugins/jquery-ui-1.8.16.custom.min.js"></script>
        <script type="text/javascript" src="js/plugins/jquery.validate.min.js"></script>
        <script type="text/javascript" src="js/custom/general.js"></script>
        <script type="text/javascript" src="js/custom/form.js"></script>
    </head>
    <%@include file="header.jsp" %>
    <body class="loggedin">     
        <!-- START OF MAIN CONTENT -->
        <div class="mainwrapper">
            <div class="mainwrapperinner">
                <jsp:include page="dashboard.jsp"></jsp:include>
                    <div class="maincontent noright">
                        <div class="maincontentinner">
                            <div class="contenttitle">
                                <h2 class="form"><span>Manage Users</span></h2>
                            </div><!--contenttitle-->

                        <%
                            BussinessService proxy = BussinessServiceProxy.getProxy();
                            User u = null;
                            String task = "", uid = "0000";
                            if (request.getParameter("task") != null) {
                                task = request.getParameter("task");
                                if (request.getParameter("uid") != null) {
                                    uid = request.getParameter("uid");
                                    u = (User) proxy.getOne(Integer.parseInt(uid), "user");
                                }
                            } else {
                                response.sendRedirect("view_users.jsp");
                            }%>
                        <%String fname = "", lname = "", email = "", utype = "";
                            if (u != null) {
                                fname = u.getFName();
                                lname = u.getLName();
                                email = u.getEmail();
                                utype = u.getType();
                            }
                        %>
                        <form id="form2" class="stdform stdform2" method="post" action="ManageUsers">
                            <p>
                                <label>User ID</label>
                                <span class="field"><input type="text" name="userid" id="userid" 
                                                           class="longinput" readonly="true" value="<%=uid%>"/></span>
                            </p>

                            <p>
                                <label>First Name</label>
                                <span class="field"><input type="text" name="firstname" id="firstname" 
                                                           class="longinput" required value="<%=fname%>"/></span>
                            </p>

                            <p>
                                <label>Last Name</label>
                                <span class="field"><input type="text" name="lastname" id="lastname" 
                                                           class="longinput" required value="<%=lname%>"/></span>
                            </p>

                            <p>
                                <label>Email</label>
                                <span class="field"><input type="email" name="email" id="email" 
                                                           class="longinput" required value="<%=email%>"/></span>
                            </p>
                            <%if (task.equals("add")) {%>
                            <p>
                                <label>Password</label>
                                <span class="field"><input type="password" name="password" 
                                                           id="password" class="longinput" required/></span>
                            </p>
                            <%}%>
                            <p>
                                <label>Type</label>
                                <span class="field"><select name="type" id="selection2" required>
                                        <option value="Cashier" <%if (utype.equals("Cashier")) {
                                                out.println("selected");
                                            }%>>Cashier</option>
                                        <option value="Manager" <%if (utype.equals("Manager")) {
                                                out.println("selected");
                                            }%>>Manager</option>
                                        <option value="Admin" <%if (utype.equals("Admin")) {
                                                out.println("selected");
                                            }%>>Admin</option>
                                    </select></span>
                            </p>


                            <p class="stdformbutton">
                                <%if (task.equals("update")) {%>
                                <button type="submit" name="btnUpdate" class="submit radius2">Update User</button>
                                <%} else if (task.equals("add")) {%>
                                <button type="submit" name="btnAdd" class="submit radius2">Add User</button>
                                <%}%>
                            </p>
                        </form>
                        <%if (request.getParameter("uerror") != null) {
                                String error = request.getParameter("uerror");
                                if (error.equals("EmailInUse")) {
                                    out.println("<div class='notification msgerror'>"
                                            + "<a class='close'></a><p>Email Already In Use"
                                            + "</p></div>");
                                } else if (error.equals("Successful")) {
                                    out.println("<div class='notification msgsuccess'>"
                                            + "<a class='close'></a><p>Task Successfully Finished"
                                            + "</p></div>");
                                }
                            }%>

                        <br clear="all" />
                        <div class="footer">
                            <p>Black Lotus Cakes © 2020. All Rights Reserved.</p>
                        </div>
                    </div>
                    <!--content-->
