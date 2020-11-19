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
                        <%String category = "";
                            if (request.getParameter("category") != null) {
                                category = request.getParameter("category").trim();
                            }%>
                        <div class="contenttitle radiusbottom0">
                            <h2 class="table"><span>Product catalog</span></h2>
                        </div>
                        <%BussinessService proxy = BussinessServiceProxy.getProxy();
                            List<Product> pp = proxy.getAllProducts();
                            if (pp.isEmpty()) {
                                out.println("No records");
                            } else {
                                for (Product p : pp) {
                                    if (category.equalsIgnoreCase("")) {
                        %>
                        <div class="one_fourth widgetcontent">
                            <div class="widgetbox uncollapsible">
                                <div class="widgetcontent">
                                    <img onerror='if (this.src != "images/products/a.jpg") this.src = "images/products/a.jpg";' src="<%out.println(p.getImage());%>" class="cardimg" alt="Product Image"/>
                                    <div><h2 class="general"><span><%out.println(p.getName());%></span></h2></div>
                                    <p style="height: 60px;overflow: hidden;"><%out.println(p.getDiscription());%></p>
                                    <span><h1>Rs.<%out.println(p.getPrice());%></h1></span>
                                    <a href='product_stock.jsp?pid=<%out.println(p.getProductID());%>' 
                                       target="_blank" style="width:20%;text-align: center;" class="stdbtn btn_black anchorbutton">Buy</a>
                                </div><!--widgetcontent-->
                            </div><!--widgetbox-->
                        </div><!--one_half-->

                        <%
                        } else {
                            if (category.equals(p.getCategory().getName().trim())) {
                        %>

                        <div class="one_fourth widgetcontent">
                            <div class="widgetbox uncollapsible" style="text-align: center;">
                                <div class="widgetcontent">
                                    <img onerror='if (this.src != "images/products/a.jpg") this.src = "images/products/a.jpg";' src="<%out.println(p.getImage());%>" class="cardimg" alt="product Image"/>
                                    <div><h2 class="general"><span><%out.println(p.getName());%></span></h2></div>
                                    <div><h4 class="general"><span><%out.println(p.getCategory().getName());%></span></h4></div>
                                    <span><h1>Rs.<%out.println(p.getPrice());%></h1></span>
                                    <a href='product_stock.jsp?pid=<%out.println(p.getProductID());%>' 
                                       target="_blank" style="width: 60%;" class="stdbtn btn_black anchorbutton">Buy</a>
                                </div><!--widgetcontent-->
                            </div><!--widgetbox-->
                        </div><!--one_half-->


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

