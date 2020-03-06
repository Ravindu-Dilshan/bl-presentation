<%-- 
    Document   : manage_vendors
    Created on : Jan 9, 2020, 12:03:07 PM
    Author     : Admins
--%>
<%@page import="com.mycompany.presentationtier.BussinessServiceProxy"%>
<%@page import="classes.Vendor"%>
<%@page import="classes.User"%>
<%@page import="com.mycompany.bussinesstier2.BussinessService"%>
<%@page import="com.mycompany.bussinesstier2.BussinessService_Service"%>
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
                                <h2 class="form"><span>Manage Vendors</span></h2>
                            </div><!--contenttitle-->

                        <%
                            BussinessService proxy = BussinessServiceProxy.getProxy();
                            Vendor v = null;
                            String task = "", vid = "0000";
                            if (request.getParameter("task") != null) {
                                task = request.getParameter("task");
                                if (request.getParameter("vid") != null) {
                                    vid = request.getParameter("vid");
                                    v = (Vendor) proxy.getOne(Integer.parseInt(vid), "vendor");
                                }
                            } else {
                                response.sendRedirect("view_vendor.jsp");
                            }%>
                        <%String fname = "", lname = "", email = "", company = "", address = "", telephone = "";
                            if (v != null) {
                                fname = v.getFName();
                                lname = v.getLName();
                                email = v.getEmail();
                                company = v.getCompany();
                                address = v.getAddress();
                                telephone = v.getTelephone();
                            }
                        %>
                        <form id="form2" class="stdform stdform2" method="post" action="ManageVendors">
                            <p>
                                <label>User ID</label>
                                <span class="field"><input type="text" name="userid" id="userid" 
                                                           class="longinput" readonly="true" value="<%=vid%>"/></span>
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
                                <span class="field"><input type="text" name="email" id="email" class="longinput" 
                                                           required value="<%=email%>"/></span>
                            </p>
                            <p>
                                <label>Company</label>
                                <span class="field"><input type="text" name="company" id="company" 
                                                           class="longinput" required value="<%=company%>"/></span>
                            </p>
                            <p>
                                <label>Address</label>
                                <span class="field"><textarea rows="3" type="text" name="address" id="address" 
                                                              class="longinput" required><%=address%></textarea>></span>
                            </p>
                            <p>
                                <label>Telephone</label>
                                <span class="field"><input type="text" name="telephone" id="telephone" 
                                                           class="longinput" required value="<%=telephone%>"/></span>
                            </p>

                            <p class="stdformbutton">
                                <button type="submit" name="btnUpdate" class="submit radius2">Update Vendor</button>
                            </p>
                        </form>
                        <%if (request.getParameter("verror") != null) {
                                String error = request.getParameter("verror");
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

