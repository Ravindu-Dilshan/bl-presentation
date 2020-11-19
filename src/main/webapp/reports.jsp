<%-- 
    Document   : reports
    Created on : Jan 27, 2020, 9:58:28 AM
    Author     : Admins
--%>

<%@page import="classes.Sale"%>
<%@page import="classes.Category"%>
<%@page import="classes.Stock"%>
<%@page import="classes.Vendor"%>
<%@page import="classes.User"%>
<%@page import="classes.Order"%>
<%@page import="com.mycompany.presentationtier.BussinessServiceProxy"%>
<%@page import="java.util.List"%>
<%@page import="classes.Product"%>
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
        <script type="text/javascript" src="js/custom/general.js"></script>
        <style>
            @media print {
                .pbtn{
                    visibility: hidden;
                }
            }
        </style>
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
                        <div>
                            <div class="widgetbox" id="users">
                                <div class="title"><h2 class="general"><span>Users</span></h2></div>
                                <div class="widgetcontent">
                                    <table cellpadding="0" cellspacing="0" border="0" class="stdtable">
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
                                                                + "<td class='center'>" + u.getType() + "</td>");
                                                    }
                                                }
                                            %> 
                                        </tbody>
                                    </table>
                                    <div>
                                        <button class="pbtn" onclick="printContent('users')">Print this page</button>
                                    </div>
                                </div>
                            </div>

                        </div>


                        <div>
                            <div class="widgetbox" id="vendors">
                                <div class="title"><h2 class="general"><span>Vendors</span></h2></div>
                                <div class="widgetcontent">
                                    <table cellpadding="0" cellspacing="0" border="0" class="stdtable">
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
                                                <th class="head0">Company</th>
                                                <th class="head1">Address</th>
                                                <th class="head0">Telephone</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Vendor> vv = proxy.getAllVendors();
                                                if (vv.isEmpty()) {
                                                    out.println("No records");
                                                } else {
                                                    for (Vendor v : vv) {
                                                        out.print("<tr>"
                                                                + "<td align='center'>#" + v.getUserID() + "</td>"
                                                                + "<td align='center'>" + v.getFName() + "</td>"
                                                                + "<td align='center'>" + v.getLName() + "</td>"
                                                                + "<td align='center'>" + v.getEmail() + "</td>"
                                                                + "<td align='center'>" + v.getCompany() + "</td>"
                                                                + "<td align='center'>" + v.getAddress() + "</td>"
                                                                + "<td align='center'>" + v.getTelephone() + "</td>");
                                                    }
                                                }
                                            %> 
                                        </tbody>
                                    </table>
                                    <div>
                                        <button class="pbtn" onclick="printContent('vendors')">Print this page</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div>
                            <div class="widgetbox" id="products">
                                <div class="title"><h2 class="general"><span>Products</span></h2></div>
                                <div class="widgetcontent">
                                    <table cellpadding="0" cellspacing="0" border="0" class="stdtable mediatable" id="dyntable">
                                        <colgroup>
                                            <col class="con0" />
                                            <col class="con1" />
                                            <col class="con0" />
                                            <col class="con1" />
                                            <col class="con0" />
                                            <col class="con1" />
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">ID</th>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">Products name</th>
                                                <th class="head1" rowspan="1" colspan="1" style="width:30%;">Description</th>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">Price (Rs.)</th>
                                                <th class="head1" rowspan="1" colspan="1" style="width:10%;">Image</th>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">Category</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Product> pp = proxy.getAllProducts();
                                                if (pp.isEmpty()) {
                                                    out.println("No records");
                                                } else {
                                                    for (Product p : pp) {
                                                        out.print("<tr>"
                                                                + "<td class='center'>#" + p.getProductID() + "</td>"
                                                                + "<td class='center'>" + p.getName() + "</td>"
                                                                + "<td class='justify'>" + p.getDiscription() + "</td>"
                                                                + "<td class='center'>" + p.getPrice() + ".00</td>"
                                                                + "<td class='center'><a href='" + p.getImage() + "' "
                                                                + "target='_blank'><img width='70' onerror='if (this.src != \"images/products/a.jpg\") this.src = \"images/products/a.jpg\";'"
                                                                + "src='" + p.getImage() + "'/></a></td>"
                                                                + "<td class='center'>" + p.getCategory().getName() + "</td>");
                                                    }
                                                }
                                            %> 
                                        </tbody>
                                    </table>
                                    <div>
                                        <button class="pbtn" onclick="printContent('products')">Print this page</button>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div>
                            <div class="widgetbox" id="stocks">
                                <div class="title"><h2 class="general"><span>Stocks</span></h2></div>
                                <div class="widgetcontent">
                                    <table cellpadding="0" cellspacing="0" border="0" class="stdtable mediatable" id="dyntable">
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
                                                <th class="head0">Available Quantity (Unit)</th>
                                                <th class="head1">Last Updated</th>
                                                <th class="head0">Product Name</th>
                                                <th class="head1">Image</th>
                                                <th class="head1">Price (Rs.)</th>
                                                <th class="head0">Category</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Stock> ss = proxy.getAllStocks();
                                                if (ss.isEmpty()) {
                                                    out.println("No records");
                                                } else {
                                                    for (Stock s : ss) {
                                                        if (Integer.parseInt(s.getQuantity()) < 50) {
                                                            out.print("<tr class='low'>");
                                                        } else {
                                                            out.print("<tr>");
                                                        }
                                                        out.print("<td class='center'>#" + s.getStockID() + "</td>"
                                                                + "<td class='center'>" + s.getQuantity() + "</td>"
                                                                + "<td class='center'>" + s.getLastUpdate() + "</td>"
                                                                + "<td class='center'>" + s.getProduct().getName() + "</td>"
                                                                + "<td class='center'><a href='" + s.getProduct().getImage() + "' "
                                                                + "target='_blank'><img width='70' onerror='if (this.src != \"images/products/a.jpg\") this.src = \"images/products/a.jpg\";'"
                                                                + "src='" + s.getProduct().getImage() + "'/></a></td>"
                                                                + "<td class='center'>" + s.getProduct().getPrice() + ".00</td>"
                                                                + "<td class='center'>" + s.getProduct().getCategory().getName() + "</td>");
                                                    }
                                                }
                                            %> 
                                        </tbody>
                                    </table>
                                    <div>
                                        <button class="pbtn" onclick="printContent('stocks')">Print this page</button>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div>
                            <div class="widgetbox" id="sales">
                                <div class="title"><h2 class="general"><span>Sales</span></h2></div>
                                <div class="widgetcontent">
                                    <table cellpadding="0" cellspacing="0" border="0" class="stdtable mediatable" id="dyntable">
                                        <colgroup>
                                            <col class="con0" />
                                            <col class="con1" />
                                            <col class="con0" />
                                            <col class="con1" />
                                            <col class="con0" />
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">ID</th>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">Date</th>
                                                <th class="head1" rowspan="1" colspan="1" style="width:10%;">Amount (Rs.)</th>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">Payment Type</th>
                                                <th class="head1" rowspan="1" colspan="1" style="width:10%;">Cashier</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Sale> sl = proxy.getAllSales();
                                                if (sl.isEmpty()) {
                                                    out.println("No records");
                                                } else {
                                                    for (Sale s : sl) {
                                                        out.print("<tr>"
                                                                + "<td class='center'>#" + s.getSaleID() + "</td>"
                                                                + "<td class='center'>" + s.getDate() + "</td>"
                                                                + "<td class='center'>" + s.getAmount() + ".00</td>"
                                                                + "<td class='center'>" + s.getPaymentType() + "</td>"
                                                                + "<td class='center'>" + s.getUser().getFName() + "</td>");
                                                    }
                                                }
                                            %> 
                                        </tbody>
                                    </table>
                                    <div>
                                        <button class="pbtn" onclick="printContent('sales')">Print this page</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div>
                            <div class="widgetbox" id="orders">
                                <div class="title"><h2 class="general"><span>Orders</span></h2></div>
                                <div class="widgetcontent">
                                    <table cellpadding="0" cellspacing="0" border="0" class="stdtable mediatable" id="dyntable">
                                        <colgroup>
                                            <col class="con0" />
                                            <col class="con1" />
                                            <col class="con0" />
                                            <col class="con1" />
                                            <col class="con0" />
                                            <col class="con1" />
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">ID</th>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">Delivery Date</th>
                                                <th class="head1" rowspan="1" colspan="1" style="width:10%;">Vendor</th>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">Company</th>
                                                <th class="head1" rowspan="1" colspan="1" style="width:10%;">Amount (Rs.)</th>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Order> oo = proxy.getAllOrders();
                                                if (oo.isEmpty()) {
                                                    out.println("No records");
                                                } else {
                                                    for (Order o : oo) {
                                                        out.print("<tr>"
                                                                + "<td class='center'>#" + o.getOrderID() + "</td>"
                                                                + "<td class='center'>" + o.getDate() + "</td>"
                                                                + "<td class='center'>" + o.getVendor().getFName() + "</td>"
                                                                + "<td class='center'>" + o.getVendor().getCompany() + "</td>"
                                                                + "<td class='center'>" + o.getAmount() + ".00</td>"
                                                                + "<td class='center'>" + o.getStatus() + "</td>");
                                                    }
                                                }
                                            %> 
                                        </tbody>
                                    </table>
                                    <div>
                                        <button class="pbtn" onclick="printContent('orders')">Print this page</button>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div>
                            <div class="widgetbox" id="category">
                                <div class="title"><h2 class="general"><span>Category</span></h2></div>
                                <div class="widgetcontent">
                                    <table cellpadding="0" cellspacing="0" border="0" class="stdtable mediatable" id="dyntable">
                                        <colgroup>
                                            <col class="con0" />
                                            <col class="con1" />
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">ID</th>
                                                <th class="head0" rowspan="1" colspan="1" style="width:10%;">Name</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                List<Category> cc = proxy.getAllCategory();
                                                if (cc.isEmpty()) {
                                                    out.println("No records");
                                                } else {
                                                    for (Category c : cc) {
                                                        out.print("<tr>"
                                                                + "<td class='center'>#" + c.getCategoryID() + "</td>"
                                                                + "<td class='center'>" + c.getName() + "</td>");
                                                    }
                                                }
                                            %> 
                                        </tbody>
                                    </table>
                                    <div>
                                        <button class="pbtn" onclick="printContent('category')">Print this page</button>
                                    </div>
                                </div>
                            </div>
                        </div>



                    </div>
                    <div class="footer">
                        <p>Black Lotus Cakes © 2020. All Rights Reserved.</p>
                    </div>
                </div>


            </div><!--mainwrapperinner-->
        </div><!--mainwrapper-->
        <!-- END OF MAIN CONTENT -->

        <script>
            function printContent(ele) {
                var restorepage = jQuery('body').html();
                var printcontent = jQuery('#' + ele).clone();
                var enteredtext = jQuery('#text').val();
                jQuery('body').empty().html(printcontent);
                window.print();
                jQuery('body').html(restorepage);
                jQuery('#text').html(enteredtext);
                location.reload();
            }

        </script>
    </body>
</html>

