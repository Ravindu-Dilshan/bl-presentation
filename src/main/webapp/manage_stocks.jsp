<%-- 
    Document   : manage_stocks
    Created on : Jan 9, 2020, 12:44:59 PM
    Author     : Admins
--%>

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
                                <h2 class="form"><span>Manage Stocks</span></h2>
                            </div><!--contenttitle-->

                        <%
                            BussinessService proxy = BussinessServiceProxy.getProxy();
                            Stock s = null;
                            String task = "", sid = "0000";
                            if (request.getParameter("task") != null) {
                                task = request.getParameter("task");
                                if (request.getParameter("sid") != null) {
                                    sid = request.getParameter("sid");
                                    s = (Stock) proxy.getOne(Integer.parseInt(sid), "stock");
                                }
                            } else {
                                response.sendRedirect("view_stocks.jsp");
                            }%>

                        <%String quantity = "", date = "", product = "";
                            if (s != null) {
                                quantity = s.getQuantity();
                                date = s.getLastUpdate();
                                product = s.getProduct().getProductID();
                            }
                        %>
                        <form id="form2" class="stdform stdform2" method="post" action="ManageStocks">
                            <p>
                                <label>Stock ID</label>
                                <span class="field"><input type="text" name="stockid" id="stockid" 
                                                           class="longinput" readonly="true" value="<%=sid%>"/></span>
                            </p>

                            <p>
                                <label>Quantity</label>
                                <span class="field"><input type="number" name="quantity" id="quantity" 
                                                           class="longinput" required value="<%=quantity%>"/></span>
                            </p>

                            <p>
                                <label>Last Updated Date</label>
                                <span class="field"><input type="text" name="date" id="date" class="longinput" 
                                                           readonly="true" value = "<%=date%>"/></span>
                            </p>
                            <p>
                                <label>Product</label>
                                <span class="field"><select name="product" id="selection2" required>
                                        <%for (Product p : proxy.getAllProducts()) {%>
                                        <option value="<%=p.getProductID()%>"
                                                <%if (product.equals(p.getProductID())) {
                                                        out.println("selected");
                                                    }%>>
                                            <%out.println(p.getName());%>
                                        </option>
                                        <%}%>
                                    </select></span>
                            </p>

                            <p class="stdformbutton">
                                <%if (task.equals("update")) {%>
                                <button type="submit" name="btnUpdate" class="submit radius2">Update Stock</button>
                                <%} else if (task.equals("add")) {%>
                                <button type="submit" name="btnAdd" class="submit radius2">Add Stock</button>
                                <%}%>
                            </p>
                        </form>
                        <%if (request.getParameter("serror") != null) {
                                String error = request.getParameter("serror");
                                if (error.equals("noImage")) {
                                    out.println("<div class='notification msgerror'>"
                                            + "<a class='close'></a><p>Please Select an Image"
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

