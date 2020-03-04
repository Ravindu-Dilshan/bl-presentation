<%-- 
    Document   : products
    Created on : Jan 13, 2020, 7:38:03 PM
    Author     : Admins
--%>


<%@page import="classes.Stock"%>
<%@page import="com.mycompany.presentationtier.BussinessServiceProxy"%>
<%@page import="java.util.List"%>
<%@page import="classes.Product"%>
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
        <script type="text/javascript" src="js/plugins/jquery.jgrowl.js"></script>
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/plugins/jquery-ui-1.8.16.custom.min.js"></script>
        <script type="text/javascript" src="js/custom/general.js"></script>
        <script type="text/javascript" src="js/custom/tables.js"></script>
        <script type="text/javascript">
            window.onload = function () {
            <%if (request.getParameter("perror") != null) {
                    String error = request.getParameter("perror");
                    if (error.equals("Successful")) {
                        out.println("jQuery.jGrowl('Deleted Successfully');");
                    } else if (error.equals("CannotInuse")) {
                        out.println("jQuery.jGrowl('Cannot Delete Product In Use');");
                    }
                }%>
                jQuery('.view').colorbox();
            };
        </script>
    </head>
    <%@include file="header.jsp" %>
    <body class="loggedin">     
        <!-- START OF MAIN CONTENT -->
        <div class="mainwrapper">
            <div class="mainwrapperinner">
                <jsp:include page="dashboard.jsp"></jsp:include>
                    <div class="maincontent noright">
                        <div class="maincontentinner container">
                        <%BussinessService proxy = BussinessServiceProxy.getProxy();
                            String pid = "";
                            Product p = null;
                            if (request.getParameter("pid") != null) {
                                pid = request.getParameter("pid");
                                p = (Product) proxy.getOne(Integer.parseInt(pid), "product");
                            } else {
                                response.sendRedirect("products.jsp");
                            }%>

                        <br>
                            <div>
                                <div class="coloumn">
                                    <div>
                                        <div>
                                            <img width="100%" src="<%out.println(p.getImage());%>" alt="Product Image">
                                        </div>
                                    </div>
                                    <div style="padding: 20px;">
                                        <h1 style="font-size: 70px;"><%out.println(p.getName());%></h1>
                                        <div>
                                            <p style="font-size: 15px;"><%out.println(p.getDiscription());%></p>
                                        </div>
                                        <h2 style="font-size: 50px;">Rs.<%out.println(p.getPrice());%></h2>
                                    </div>
                                </div>
                            </div>

                            <br><br>
                                    <div class="contenttitle radiusbottom0">
                                        <h2 class="table"><span>Stock Catalog</span></h2>
                                    </div>
                                    <table cellpadding="0" cellspacing="0" border="0" class="stdtable mediatable" id="dyntable">
                                        <colgroup>
                                            <col class="con0" />
                                            <col class="con1" />
                                            <col class="con0" />
                                            <col class="con1" />
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th class="head0">Available Quantity (Unit)</th>
                                                <th class="head1">Last Updated</th>
                                                <th class="head1"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Stock> ss = proxy.getAllStocks();
                                                if (ss.isEmpty()) {
                                                    out.println("No records");
                                                } else {
                                                    for (Stock s : ss) {
                                                        if (s.getProduct().getProductID().equals(pid)) {
                                                            out.print("<td class='center'>" + s.getQuantity() + "</td>"
                                                                    + "<td class='center'>" + s.getLastUpdate() + "</td>"
                                                                    + "<td align='center'>"
                                                                    + "<form id='form2' style='display: ruby;' class='stdform' "
                                                                    + "method='post'action='AddToCart?stockid=" + s.getStockID() + "'>"
                                                                    + "<p><label style = 'float:none;'> Quantity </label> "
                                                                    + "<span> <input type = 'number' name = 'quantity' style = 'width: 25%;' value = '1' /> </span> "
                                                                    + "</p><button type='submit' name='btnAdd'class='submit radius2'>Add to cart</button></span>"
                                                                    + "</form>"
                                                                    + "</td>"
                                                                    + "</tr>");
                                                        }
                                                    }
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                    <div class="footer">
                                        <p>Black Lotus Cakes © 2020. All Rights Reserved.</p>
                                    </div>
                                    <br clear="all" />
                                    <!--content-->

                                    </div><!--maincontentinner-->

                                    <!--footer-->

                                    </div><!--maincontent-->

                                    </div><!--mainwrapperinner-->
                                    </div>

                                    <!-- END OF MAIN CONTENT -->


                                    </body>
                                    </html>

