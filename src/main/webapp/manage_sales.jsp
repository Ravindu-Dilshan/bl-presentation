<%-- 
    Document   : manage_sales
    Created on : Jan 17, 2020, 12:29:09 PM
    Author     : Admins
--%>

<%@page import="classes.Sale"%>
<%@page import="com.mycompany.presentationtier.BussinessServiceProxy"%>
<%@page import="classes.Stock"%>
<%@page import="java.util.List"%>
<%@page import="classes.Category"%>
<%@page import="classes.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.bussinesstier2.BussinessService"%>
<%@page import="com.mycompany.bussinesstier2.BussinessService_Service"%>
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
                                <h2 class="form"><span>Manage Sales</span></h2>
                            </div><!--contenttitle-->

                        <%
                            BussinessService proxy = BussinessServiceProxy.getProxy();
                            Sale s = null;
                            String sid = null;
                            if (request.getParameter("sid") != null) {
                                sid = request.getParameter("sid");
                                s = (Sale) proxy.getOne(Integer.parseInt(sid), "sale");
                            } else {
                                response.sendRedirect("view_sales.jsp");
                            }%>

                        <%String amount = "", date = "", payTyepe = "", cashier = "";
                            if (s != null) {
                                amount = s.getAmount();
                                date = s.getDate();
                                payTyepe = s.getPaymentType();
                                cashier = s.getUser().getFName();
                            }
                        %>
                        <form id="form2" class="stdform stdform2" method="post" action="ManageSales">
                            <p>
                                <label>Sale ID</label>
                                <span class="field"><input type="text" name="saleid" id="stockid" class="longinput" 
                                                           readonly="true" value="<%=sid%>"/></span>
                            </p>

                            <p>
                                <label>Amount (Rs.)</label>
                                <span class="field"><input type="number" name="quantity" id="quantity" class="longinput" 
                                                           readonly="true" required value="<%=amount%>"/></span>
                            </p>

                            <p>
                                <label>Date</label>
                                <span class="field"><input type="text" name="date" id="date" class="longinput" 
                                                           readonly="true" value = "<%=date%>"/></span>
                            </p>

                            <p>
                                <label>Cashier</label>
                                <span class="field"><input type="text" name="date" id="date" class="longinput" 
                                                           readonly="true" value = "<%=cashier%>"/></span>
                            </p>
                            <p>
                                <label>Payment Type</label>
                                <span class="field"><select name="payment" id="selection2">
                                        <option value="Cash"><%=payTyepe%></option>
                                    </select></span>
                            </p>

                            <p class="stdformbutton">
                                <!--<button type="submit" name="btnUpdate" class="submit radius2">Update</button>-->
                                <button type="submit" name="btnDelete" class="submit radius2">Delete</button>
                            </p>
                        </form>
                        <br>
                            <%if (request.getParameter("serror") != null) {
                                    String error = request.getParameter("serror");
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

