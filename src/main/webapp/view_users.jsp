<%-- 
    Document   : view_users
    Created on : Jan 7, 2020, 8:08:55 PM
    Author     : Admins
--%>

<%@page import="com.mycompany.presentationtier.BussinessServiceProxy"%>
<%@page import="com.mycompany.presentationtier.UserSession"%>
<%@page import="java.util.List"%>
<%@page import="classes.User"%>
<%@page import="com.mycompany.bussinesstier.BussinessService"%>
<%@page import="com.mycompany.bussinesstier.BussinessService_Service"%>
<%@page import="com.mycompany.presentationtier.UserLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>BlackLotus</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <script type="text/javascript" src="js/plugins/jquery-1.7.min.js"></script>
        <script type="text/javascript" src="js/plugins/jquery.jgrowl.js"></script>
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/plugins/jquery-ui-1.8.16.custom.min.js"></script>
        <script type="text/javascript" src="js/custom/general.js"></script>
        <script type="text/javascript" src="js/custom/tables.js"></script>
        <script type="text/javascript">
            window.onload = function () {
            <%if (request.getParameter("uerror") != null) {
                    String error = request.getParameter("uerror");
                    if (error.equals("Successful")) {
                        out.println("jQuery.jGrowl('Deleted Successfully');");
                    } else if (error.equals("CannotInuse")) {
                        out.println("jQuery.jGrowl('Cannot Delete User In Use');");
                    }
                }%>
            };
        </script>
    </head>
    <%@include file="header.jsp" %>
    <body class="loggedin">     
        <!-- START OF MAIN CONTENT -->
        <div class="mainwrapper">
            <div class="mainwrapperinner">
                <jsp:include page="dashboard.jsp"></jsp:include>
                <%if (type.equalsIgnoreCase("vendor") || type.equalsIgnoreCase("cashier")) {
                        response.sendRedirect("index.jsp");
                        return;
                    }%>
                <div class="maincontent noright">
                    <div class="maincontentinner">
                        <div class="contenttitle radiusbottom0">
                            <h2 class="table"><span>Users</span></h2>
                        </div><!--contenttitle-->
                        <table cellpadding="0" cellspacing="0" border="0" class="stdtable" id="dyntable">
                            <colgroup>
                                <col class="con0" />
                                <col class="con1" />
                                <col class="con0" />
                                <col class="con1" />
                                <col class="con0" />
                                <col class="con1" />
                                <col class="con0" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="head0">ID</th>
                                    <th class="head0">First name</th>
                                    <th class="head1">Last name</th>
                                    <th class="head0">Email</th>
                                    <th class="head0">Type</th>
                                    <th class="head1"></th>
                                    <th class="head0"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    BussinessService proxy = BussinessServiceProxy.getProxy();
                                    List<User> uu = proxy.getAllUsers();
                                    if (uu.isEmpty()) {
                                        out.println("No records");
                                    } else {
                                        for (User u : uu) {
                                            out.print("<tr>"
                                                    + "<td class='center'>#" + u.getUserID() + "</td>"
                                                    + "<td td class='center'>" + u.getFName() + "</td>"
                                                    + "<td class='center'>" + u.getLName() + "</td>"
                                                    + "<td class='center'>" + u.getEmail() + "</td>"
                                                    + "<td class='center'>" + u.getType() + "</td>"
                                                    + "<td align='center'> <span><a href='manage_users.jsp?task=update&uid=" + u.getUserID() + "' target='_blank' "
                                                    + "class='btn btn2 btn_book'><span>Update</span></a></span></td>"
                                                    + "<td align='center'><span><a href='ManageUsers?btnDelete&uid=" + u.getUserID() + "'"
                                                    + "class='btn btn2 btn_trash'><span>Delete</span></a></span></td>"
                                                    + "</tr>");
                                        }
                                    }
                                %> 
                            </tbody>
                        </table>

                        <br clear="all" />

                    </div>
                    <!--content-->

                    <a href='manage_users.jsp?task=add' target="_blank" class="stdbtn btn_black anchorbutton">Add new user</a>

                    <div class="footer">
                        <p>Black Lotus Cakes © 2020. All Rights Reserved.</p>
                    </div>




                </div><!--maincontentinner-->

                <!--footer-->

            </div><!--maincontent-->

        </div><!--mainwrapperinner-->
        </div><!--mainwrapper-->
        <!-- END OF MAIN CONTENT -->


    </body>
</html>
