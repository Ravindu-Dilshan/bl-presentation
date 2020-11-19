<%-- 
    Document   : manage_profile
    Created on : Jan 13, 2020, 1:26:25 PM
    Author     : Admins
--%>

<%@page import="classes.Vendor"%>
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
                                <h2 class="form"><span>Manage Profile</span></h2>
                            </div><!--contenttitle-->
                        <%
                            BussinessService proxy = BussinessServiceProxy.getProxy();
                            String uid = userSession.getUser().getUserID();
                            //String stype = userSession.getUser().getType();
                            String fname = "", lname = "", email = "", company = "", address = "", telephone = "";
                            if (type.equals("vendor") && uid != null) {
                                Vendor v = (Vendor) proxy.getOne(Integer.parseInt(uid), "vendor");
                                if (v != null) {
                                    fname = v.getFName();
                                    lname = v.getLName();
                                    email = v.getEmail();
                                    company = v.getCompany();
                                    address = v.getAddress();
                                    telephone = v.getTelephone();
                                } else {
                                    response.sendRedirect("index.jsp");
                                }
                            } else {
                                User u = (User) proxy.getOne(Integer.parseInt(uid), "user");
                                fname = u.getFName();
                                lname = u.getLName();
                                email = u.getEmail();
                            }
                        %>
                        <form id="form2" class="stdform stdform2" method="post" action="ManageProfile">
                            <p>
                                <label>User ID</label>
                                <span class="field"><input type="text" name="userid" id="userid" class="longinput" 
                                                           readonly="true" value="<%=uid%>"/></span>
                            </p>

                            <p>
                                <label>First Name</label>
                                <span class="field"><input type="text" name="firstname" id="firstname" class="longinput" 
                                                           required value="<%=fname%>"/></span>
                            </p>

                            <p>
                                <label>Last Name</label>
                                <span class="field"><input type="text" name="lastname" id="lastname" class="longinput" 
                                                           required value="<%=lname%>"/></span>
                            </p>

                            <p>
                                <label>Email</label>
                                <span class="field"><input type="email" name="email" id="email" class="longinput" 
                                                           required value="<%=email%>"/></span>
                            </p>
                            <p>
                                <label>Type</label>
                                <span class="field"><input type="text" name="type" id="type" class="longinput" r
                                                           eadonly="true" value="<%=type%>"/></span>
                            </p>
                            <%if (type.equals("vendor")) {%>
                            <p>
                                <label>Company</label>
                                <span class="field"><input type="text" name="company" id="company" class="longinput" 
                                                           required value="<%=company%>"/></span>
                            </p>

                            <p>
                                <label>Address</label>
                                <span class="field"><input type="text" name="address" id="address" class="longinput" 
                                                           required value="<%=address%>"/></span>
                            </p>

                            <p>
                                <label>Telephone</label>
                                <span class="field"><input type="text" name="telephone" id="telephone" class="longinput" 
                                                           required value="<%=telephone%>"/></span>
                            </p>
                            <%}%>
                            <p class="stdformbutton">
                                <button type="submit" name="btnUpdate" class="submit radius2">Update</button>
                            </p>
                        </form>


                        <div class="contenttitle">
                            <h2 class="form"><span>Change Password</span></h2>
                        </div>
                        <form id="form2" class="stdform stdform2" method="post" action="ManageProfile?uid=<%=uid%>">
                            <p>
                                <label>Current Password</label>
                                <span class="field"><input type="text" name="password" id="Cpassword" 
                                                           class="longinput"/></span>
                            </p>

                            <p>
                                <label>New Password</label>
                                <span class="field"><input type="text" name="Npassword" id="Npassword" 
                                                           class="longinput" required/></span>
                            </p>

                            <p>
                                <label>Confirm Password</label>
                                <span class="field"><input type="text" name="Cmpassword" id="Cmpassword" 
                                                           class="longinput" required/></span>
                            </p>

                            <p class="stdformbutton">
                                <button type="submit" name="btnPasswordChange" class="submit radius2">Change</button>
                            </p>
                        </form>
                        <%if (request.getParameter("uerror") != null) {
                                String error = request.getParameter("uerror");
                                if (error.equals("IncorrectPassword")) {
                                    out.println("<div class='notification msgerror'>"
                                            + "<a class='close'></a><p>Incorrect Password"
                                            + "</p></div>");
                                } else if (error.equals("Successful")) {
                                    out.println("<div class='notification msgsuccess'>"
                                            + "<a class='close'></a><p>Task Successfully Finished"
                                            + "</p></div>");
                                } else if (error.equals("noMatch")) {
                                    out.println("<div class='notification msgerror'>"
                                            + "<a class='close'></a><p>Password Do not match"
                                            + "</p></div>");
                                }
                            }%>

                        <br clear="all" />
                        <div class="footer">
                            <p>Black Lotus Cakes © 2020. All Rights Reserved.</p>
                        </div>
                    </div>
                    <!--content-->
                </div>
            </div>
        </div>
    </body>
</html>