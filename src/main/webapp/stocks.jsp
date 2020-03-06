<%-- 
    Document   : products
    Created on : Jan 13, 2020, 7:38:03 PM
    Author     : Admins
--%>


<%@page import="classes.Stock"%>
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
                        <%String category = "All";
                            if (request.getParameter("category") != null) {
                                category = request.getParameter("category");
                            }%>
                        <div class="contenttitle radiusbottom0">
                            <h2 class="table"><span>Stock catalog</span></h2>
                        </div>
                        <%BussinessService proxy = BussinessServiceProxy.getProxy();
                            List<Stock> ss = proxy.getAllStocks();
                            if (ss.isEmpty()) {
                                out.println("No records");
                            } else {
                                for (Stock s : ss) {
                                    if (category.equalsIgnoreCase("all") || category.equalsIgnoreCase("")) {

                        %>
                        <div class="one_fourth widgetcontent">
                            <div class="widgetbox uncollapsible">
                                <div class="widgetcontent">
                                    <img src="<%out.println(s.getProduct().getImage());%>" class="cardimg" alt="Product Image"/>
                                    <div><h2 class="general"><span><%out.println(s.getProduct().getName());%></span>
                                        </h2><h4><%out.println(s.getLastUpdate());%></h4></div>
                                    <p style="height: 50px;overflow: auto;"><%out.println(s.getProduct().getDiscription());%></p>
                                    <span><h4>Available: <%out.println(s.getQuantity());%> Units</h4></span>
                                    <span><h1>Rs.<%out.println(s.getProduct().getPrice());%></h1></span>
                                    <form id="form2" class="stdform" method="post" action="AddToCart?stockid=<%out.println(s.getStockID());%>">
                                        <p>
                                            <label style="float:none;">Quantity</label>
                                            <span><input type="number" name="quantity" id="productid" style="width: 25%;" value="1"/></span>
                                        </p>
                                        <button type="submit" name="btnAdd" style="width: 100%;" class="submit radius2">Add to cart</button>
                                    </form>
                                </div><!--widgetcontent-->
                            </div><!--widgetbox-->
                        </div>

                        <%
                        } else {
                            if (s.getProduct().getCategory().getName().equalsIgnoreCase(category)) {
                        %>
                        <div class="one_fourth widgetcontent">
                            <div class="widgetbox uncollapsible">
                                <div class="widgetcontent">
                                    <img src="<%out.println(s.getProduct().getImage());%>" class="cardimg" alt="product Image"/>
                                    <div><h2 class="general"><span><%out.println(s.getProduct().getName());%></span></h2>
                                        <h4><%out.println(s.getLastUpdate());%></h4></div>
                                    <p style="height: 50px;overflow: auto;"><%out.println(s.getProduct().getDiscription());%></p>
                                    <span><h4>Available: <%out.println(s.getQuantity());%> Units</h4></span>
                                    <span><h1>Rs.<%out.println(s.getProduct().getPrice());%></h1></span>
                                    <form id="form2" class="stdform" method="post" action="<%out.println(s.getStockID());%>">
                                        <p>
                                            <label style="float:none;">Quantity</label>
                                            <span><input type="number" name="productid" id="productid" style="width: 25%;" value="1"/></span>
                                        </p>
                                        <button type="submit" name="btnAdd" style="width: 100%;" class="submit radius2">Add to cart</button>
                                    </form>
                                </div><!--widgetcontent-->
                            </div><!--widgetbox-->
                        </div>
                        <%
                                        }
                                    }
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

        <!-- END OF MAIN CONTENT -->


    </body>
</html>

