<%-- 
    Document   : products
    Created on : Dec 31, 2019, 8:36:41 PM
    Author     : Admins
--%>

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
            };
        </script>
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
                        <div class="contenttitle radiusbottom0">
                            <h2 class="table"><span>Products</span></h2>
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
                                    <th class="head0" rowspan="1" colspan="1" style="width:10%;">Products name</th>
                                    <th class="head1" rowspan="1" colspan="1" style="width:30%;">Description</th>
                                    <th class="head0" rowspan="1" colspan="1" style="width:10%;">Price (Rs.)</th>
                                    <th class="head1" rowspan="1" colspan="1" style="width:10%;">Image</th>
                                    <th class="head0" rowspan="1" colspan="1" style="width:10%;">Category</th>
                                    <th class="head1" rowspan="1" colspan="1" style="width:10%;"></th>
                                    <th class="head0" rowspan="1" colspan="1" style="width:10%;"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    BussinessService proxy = BussinessServiceProxy.getProxy();
                                    List<Product> pp = proxy.getAllProducts();
                                    if (pp.isEmpty()) {
                                        out.println("No records");
                                    } else {
                                        if (request.getParameter("category") != null) {
                                            String cat = request.getParameter("category");
                                            for (Product p : pp) {
                                                if (cat.equals(p.getCategory().getName().trim())) {
                                                    out.print("<tr>"
                                                            + "<td class='center'>#" + p.getProductID() + "</td>"
                                                            + "<td class='center'>" + p.getName() + "</td>"
                                                            + "<td class='justify'>" + p.getDiscription() + "</td>"
                                                            + "<td class='center'>" + p.getPrice() + ".00</td>"
                                                            + "<td class='center'><a href='" + p.getImage() + "' target='_blank'>"
                                                            + "<img width='70' src='" + p.getImage() + "'/></a></td>"
                                                            + "<td class='center'>" + p.getCategory().getName() + "</td>"
                                                            + "<td align='center'> <span><a href='manage_products.jsp?task=update&pid=" + p.getProductID() + "' target='_blank' "
                                                            + "class='btn btn2 btn_book'><span>Update</span></a></span></td>"
                                                            + "<td align='center'><span><a href='ManageProducts?btnDelete&pid=" + p.getProductID() + "'"
                                                            + "class='btn btn2 btn_trash'><span>Delete</span></a></span></td>"
                                                            + "</tr>");
                                                }
                                            }
                                        } else {
                                            for (Product p : pp) {
                                                out.print("<tr>"
                                                        + "<td class='center'>#" + p.getProductID() + "</td>"
                                                        + "<td class='center'>" + p.getName() + "</td>"
                                                        + "<td class='justify'>" + p.getDiscription() + "</td>"
                                                        + "<td class='center'>" + p.getPrice() + ".00</td>"
                                                        + "<td class='center'><a href='" + p.getImage() + "' target='_blank'>"
                                                        + "<img width='70' src='" + p.getImage() + "'/></a></td>"
                                                        + "<td class='center'>" + p.getCategory().getName() + "</td>"
                                                        + "<td align='center'> <span><a href='manage_products.jsp?task=update&pid=" + p.getProductID() + "' target='_blank' "
                                                        + "class='btn btn2 btn_book'><span>Update</span></a></span></td>"
                                                        + "<td align='center'><span><a href='ManageProducts?btnDelete&pid=" + p.getProductID() + "'"
                                                        + "class='btn btn2 btn_trash'><span>Delete</span></a></span></td>"
                                                        + "</tr>");
                                            }
                                        }
                                    }
                                %> 
                            </tbody>
                        </table>

                        <br clear="all" />

                    </div>
                    <!--content-->

                    <a href='manage_products.jsp?task=add' target="_blank" class="stdbtn btn_black anchorbutton">Add new product</a>


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

