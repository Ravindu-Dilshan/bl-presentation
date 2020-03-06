<%-- 
    Document   : view_orders
    Created on : Jan 17, 2020, 12:30:25 PM
    Author     : Admins
--%>

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
        <script type="text/javascript" src="js/plugins/jquery.jgrowl.js"></script>
        <script type="text/javascript" src="js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/plugins/jquery-ui-1.8.16.custom.min.js"></script>
        <script type="text/javascript" src="js/custom/general.js"></script>
        <script type="text/javascript" src="js/custom/tables.js"></script>
        <script type="text/javascript">
            window.onload = function () {
            <%if (request.getParameter("oerror") != null) {
                    String error = request.getParameter("oerror");
                    if (error.equals("Successful")) {
                        out.println("jQuery.jGrowl('Deleted Successfully');");
                    } else if (error.equals("CannotInuse")) {
                        out.println("jQuery.jGrowl('Cannot Delete Product In Use');");
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
                    <div class="maincontent noright">
                        <div class="maincontentinner">
                            <div class="contenttitle radiusbottom0">
                                <h2 class="table"><span>My Orders</span></h2>
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
                                    <col class="con0" />
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th class="head0" rowspan="1" colspan="1" style="width:10%;">ID</th>
                                        <th class="head0" rowspan="1" colspan="1" style="width:10%;">Delivery Date</th>
                                        <th class="head1" rowspan="1" colspan="1" style="width:10%;">Vendor</th>
                                        <th class="head0" rowspan="1" colspan="1" style="width:10%;">Company</th>
                                        <th class="head1" rowspan="1" colspan="1" style="width:10%;">Amount (Rs.)</th>
                                        <th class="head0" rowspan="1" colspan="1" style="width:10%;">Status</th>
                                        <th class="head1" rowspan="1" colspan="1" style="width:10%;"></th>
                                        <th class="head0" rowspan="1" colspan="1" style="width:10%;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%if (userSession != null) {
                                        String vid = userSession.getUser().getUserID();
                                        BussinessService proxy = BussinessServiceProxy.getProxy();
                                        List<Order> oo = proxy.getAllOrders();
                                        if (oo.isEmpty()) {
                                            out.println("No records");
                                        } else {
                                            for (Order o : oo) {
                                                if (o.getVendor().getUserID().equals(vid) && !o.getStatus().equals("Deleted By Vendor")) {
                                                    out.print("<tr>"
                                                            + "<td class='center'>#" + o.getOrderID() + "</td>"
                                                            + "<td class='center'>" + o.getDate() + "</td>"
                                                            + "<td class='center'>" + o.getVendor().getFName() + "</td>"
                                                            + "<td class='center'>" + o.getVendor().getCompany() + "</td>"
                                                            + "<td class='center'>" + o.getAmount() + ".00</td>"
                                                            + "<td class='center'>" + o.getStatus() + "</td>"
                                                            + "<td align='center'><span><a href='invoice.jsp?oid=" + o.getOrderID() + "' target='_blank'"
                                                            + "class='btn btn2 btn_book'><span>Get Invoice</span></a></span></td>"
                                                            + "<td align='center'> <span><a href='ManageOrders?DeletebyVendor&orderid=" + o.getOrderID() + "'"
                                                            + "class='btn btn2 btn_book'><span>Delete</span></a></span></td>"
                                                            + "</tr>");
                                                }
                                            }
                                        }
                                    }
                                %> 
                            </tbody>
                        </table>

                        <br clear="all" />

                    </div>
                    <!--content-->

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
