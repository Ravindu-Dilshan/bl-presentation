<%-- 
    Document   : view_stocks
    Created on : Jan 9, 2020, 12:44:44 PM
    Author     : Admins
--%>

<%@page import="com.mycompany.presentationtier.BussinessServiceProxy"%>
<%@page import="classes.Stock"%>
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
        <script type="text/javascript" src="js/plugins/jquery.jgrowl.js"></script>
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/plugins/jquery-ui-1.8.16.custom.min.js"></script>
        <script type="text/javascript" src="js/custom/general.js"></script>
        <script type="text/javascript" src="js/custom/tables.js"></script>
        <script type="text/javascript">
            window.onload = function () {
            <%if (request.getParameter("added") != null) {
                    out.println("jQuery.jGrowl('Added Successfully');");
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
                        <div class="maincontentinner">
                            <div class="contenttitle radiusbottom0">
                                <h2 class="table"><span>Products Stock Catalog</span></h2>
                            </div><!--contenttitle-->
                            <table cellpadding="0" cellspacing="0" border="0" class="stdtable mediatable" id="dyntable">
                                <colgroup>
                                    <col class="con0" />
                                    <col class="con1" />
                                    <col class="con0" />
                                    <col class="con1" />
                                    <col class="con0" />
                                    <col class="con1" />
                                    <col class="con0" />
                                    <col class="con1" />
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
                                        <th class="head1"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    BussinessService proxy = BussinessServiceProxy.getProxy();
                                    List<Stock> ss = proxy.getAllStocks();
                                    if (ss.isEmpty()) {
                                        out.println("No records");
                                    } else {
                                        if (request.getParameter("category") != null) {
                                            String cat = request.getParameter("category");
                                            for (Stock s : ss) {
                                                if (cat.equals(s.getProduct().getCategory().getName().trim())) {
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
                                                            + "target='_blank'><img onerror='if (this.src != \"images/products/a.jpg\") this.src = \"images/products/a.jpg\";'"
                                                            + "width='70' src='" + s.getProduct().getImage() + "'/></a></td>"
                                                            + "<td class='center'>" + Double.parseDouble(s.getProduct().getPrice()) + "</td>"
                                                            + "<td class='center'>" + s.getProduct().getCategory().getName() + "</td>"
                                                            + "<td align='center'> "
                                                            + "<form id='form2' style='display: ruby;' class='stdform' "
                                                            + "method='post'action='AddToCart?stockid=" + s.getStockID() + "'>"
                                                            + "<p><label style = 'float:none;'> Quantity </label> "
                                                            + "<span> <input type = 'number' name = 'quantity' style = 'width: 25%;' value = '1' /> </span> "
                                                            + "</p><button type='submit' name='btnAddSale'class='submit radius2'>Add to sale</button></span>"
                                                            + "</form></td>"
                                                            + "</tr>");
                                                }
                                            }
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
                                                        + "target='_blank'><img onerror='if (this.src != \"images/products/a.jpg\") this.src = \"images/products/a.jpg\";'"
                                                        + "width='70' src='" + s.getProduct().getImage() + "'/></a></td>"
                                                        + "<td class='center'>" + Double.parseDouble(s.getProduct().getPrice()) + "</td>"
                                                        + "<td class='center'>" + s.getProduct().getCategory().getName() + "</td>"
                                                        + "<td align='center'> "
                                                        + "<form id='form2' style='display: ruby;' class='stdform' "
                                                        + "method='post'action='AddToCart?stockid=" + s.getStockID() + "'>"
                                                        + "<p><label style = 'float:none;'> Quantity </label> "
                                                        + "<span> <input type = 'number' name = 'quantity' style = 'width: 25%;' value = '1' /> </span> "
                                                        + "</p><button type='submit' name='btnAddSale'class='submit radius2'>Add to sale</button></span>"
                                                        + "</form></td>"
                                                        + "</tr>");
                                            }
                                        }
                                    }
                                %> 
                            </tbody>
                        </table>

                        <br clear="all" />
                        <a href='payment.jsp' class="stdbtn btn_black anchorbutton">View Cart</a>
                        <div class="footer">
                            <p>Black Lotus Cakes © 2020. All Rights Reserved.</p>
                        </div>
                    </div>
                    <!--content-->





                </div><!--maincontentinner-->

                <!--footer-->

            </div><!--maincontent-->

        </div><!--mainwrapperinner-->
        </div><!--mainwrapper-->
        <!-- END OF MAIN CONTENT -->


    </body>
</html>


