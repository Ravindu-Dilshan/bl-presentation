<%-- 
    Document   : shopping_cart
    Created on : Jan 14, 2020, 3:52:38 PM
    Author     : Admins
--%>

<%@page import="classes.Item"%>
<%@page import="com.mycompany.presentationtier.ShoppingCartSession"%>
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
            <%if (request.getParameter("serror") != null) {
                    String error = request.getParameter("serror");
                    if (error.equals("Successful")) {
                        out.println("jQuery.jGrowl('Deleted Successfully');");
                    } else if (error.equals("CannotInuse")) {
                        out.println("jQuery.jGrowl('Cannot Delete Stock In Use');");
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
                        <div class="maincontentinner">
                            <div class="contenttitle radiusbottom0">
                                <h2 class="table"><span>Cart</span></h2>
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
                                        <th class="head0">Stock ID</th>
                                        <th class="head0">Product Name</th>
                                        <th class="head0">Price(Rs.)</th>
                                        <th class="head1">Quantity</th>
                                        <th class="head0">Amount(Rs.)</th>
                                        <th class="head1">Image</th>
                                        <th class="head0">Category</th>
                                        <th class="head1"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    ShoppingCartSession ses = GetUserSession.getCartSession(request, session);
                                    int amount = 0;
                                    if (ses == null) {
                                        response.sendRedirect("products.jsp");
                                    } else {
                                        List<Item> ii = ses.getItemList();
                                        if (ii.isEmpty()) {
                                            out.println("<h1>No records</h1>");
                                        } else {
                                            for (Item i : ii) {
                                                int value = Integer.parseInt(i.getStock().getProduct().getPrice()) * Integer.parseInt(i.getQuantity());
                                                amount += value;
                                                out.print("<td class='center'>#" + i.getStock().getStockID() + "</td>"
                                                        + "<td class='center'>" + i.getStock().getProduct().getName() + "</td>"
                                                        + "<td class='center'>" + i.getStock().getProduct().getPrice() + ".00</td>"
                                                        + "<td class='center'>" + i.getQuantity() + "</td>"
                                                        + "<td class='center'>" + value + ".00</td>"
                                                        + "<td class='center'><a href='" + i.getStock().getProduct().getImage() + "' "
                                                        + "target='_blank'><img width='70' src='" + i.getStock().getProduct().getImage() + "'/></a></td>"
                                                        + "<td class='center'>" + i.getStock().getProduct().getCategory().getName() + "</td>"
                                                        + "<td align='center'><span><a href='AddToCart?btnRemove&sid=" + i.getStock().getStockID() + "'"
                                                        + "class='btn btn2 btn_trash'><span>Delete</span></a></span></td>"
                                                        + "</tr>");
                                            }
                                        }
                                    }
                                %> 
                            </tbody>
                        </table>
                        <div style="padding-left: 20px;"><h1>Full Amount = Rs.<%=amount%>.00</h1></div>
                        <form id="form2" class="stdform stdform2" method="post" action="ManageOrders">
                            <p>
                                <label>Date to Delivery</label>
                                <span class="field"><input type="date" name="date" id="email2" class="date" required /></span>
                                <input type="number" name="amount" class="date" readonly="true" hidden value="<%=amount%>"/>
                            </p>

                            <p class="stdformbutton">
                                <button class="submit radius2" name="btnAdd">Finish Order</button>
                            </p>
                        </form>

                        <%if (request.getParameter("oerror") != null) {
                                String error = request.getParameter("oerror");
                                if (error.equals("empty")) {
                                    out.println("<div class='notification msgerror'>"
                                            + "<a class='close'></a><p>Cart is Empty"
                                            + "</p></div>");
                                } else if (error.equals("Successful")) {
                                    out.println("<div class='notification msgsuccess'>"
                                            + "<a class='close'></a><p>Order Successfully Added"
                                            + "</p></div>");
                                }
                            }%>
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