<%-- 
    Document   : manage_sales
    Created on : Jan 17, 2020, 12:29:09 PM
    Author     : Admins
--%>

<%@page import="classes.Order"%>
<%@page import="classes.Sale"%>
<%@page import="com.mycompany.presentationtier.BussinessServiceProxy"%>
<%@page import="classes.Stock"%>
<%@page import="java.util.List"%>
<%@page import="classes.Category"%>
<%@page import="classes.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.bussinesstier.BussinessService"%>
<%@page import="com.mycompany.bussinesstier.BussinessService_Service"%>
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
                                <h2 class="form"><span>Manage Orders</span></h2>
                            </div><!--contenttitle-->

                        <%
                            BussinessService proxy = BussinessServiceProxy.getProxy();
                            Order o = null;
                            String oid = null;
                            if (request.getParameter("oid") != null) {
                                oid = request.getParameter("oid");
                                o = (Order) proxy.getOne(Integer.parseInt(oid), "order");
                            } else {
                                response.sendRedirect("view_orders.jsp");
                            }%>

                        <%String amount = "", date = "", company = "", vendor = "", status = "";
                            if (o != null) {
                                vendor = o.getVendor().getFName();
                                company = o.getVendor().getCompany();
                                amount = o.getAmount();
                                date = o.getDate();
                                status = o.getStatus();
                            }
                        %>
                        <form id="form2" class="stdform stdform2" method="post" action="ManageOrders">
                            <p>
                                <label>Order ID</label>
                                <span class="field"><input type="text" name="orderid" id="orderid" class="longinput" 
                                                           readonly="true" value="<%=oid%>"/></span>
                            </p>

                            <p>
                                <label>Amount (Rs.)</label>
                                <span class="field"><input type="number" name="quantity" id="quantity" class="longinput" 
                                                           readonly="true" required value="<%=amount%>"/></span>
                            </p>

                            <p>
                                <label>Delivery Date</label>
                                <span class="field"><input type="text" name="date" id="date" class="longinput" 
                                                           readonly="true" value = "<%=date%>"/></span>
                            </p>

                            <p>
                                <label>Vendor</label>
                                <span class="field"><input type="text" name="vendor" id="vendor" class="longinput" 
                                                           readonly="true" value = "<%out.print(vendor + "(" + company + ")");%>"/></span>
                            </p>
                            <p>
                                <label>Status</label>
                                <span class="field"><select name="status" id="selection2">
                                        <%if (!status.equals("Deleted By Vendor")) {%>
                                        <button type="submit" name="btnUpdate" class="submit radius2">Update</button>
                                        <option value="Pending" <%if (status.equals("Pending")) {
                                                out.println("selected");
                                            }%>>Pending</option>
                                        <option value="Processing" <%if (status.equals("Processing")) {
                                                out.println("selected");
                                            }%>>Processing</option>
                                        <option value="Processed" <%if (status.equals("Processed")) {
                                                out.println("selected");
                                            }%>>Processed</option>
                                        <option value="Delivered" <%if (status.equals("Delivered")) {
                                                out.println("selected");
                                            }%>>Delivered</option>
                                        <option value="Rejected" <%if (status.equals("Rejected")) {
                                                out.println("selected");
                                            }%>>Rejected</option>
                                        <%} else {%>
                                        <option value="Deleted By Vendor">Deleted By Vendor</option>
                                        <%}%>
                                    </select></span>
                            </p>

                            <p class="stdformbutton">
                                <%if (!status.equals("Deleted By Vendor")) {%>
                                <button type="submit" name="btnUpdate" class="submit radius2">Update</button>
                                <%}%>
                                <button type="submit" name="btnDelete" class="submit radius2">Delete</button>
                            </p>
                        </form>
                        <br>
                            <!--<span><a href='bill.jsp?sid=<%//=sid%>' target='_blank' class='btn btn2 btn_book'><span>Get Bill</span></a></span>-->
                            <%if (request.getParameter("oerror") != null) {
                                    String error = request.getParameter("oerror");
                                    if (error.equals("Successful")) {
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

