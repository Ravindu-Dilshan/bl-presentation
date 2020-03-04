<%-- 
    Document   : manage_category
    Created on : Jan 24, 2020, 10:22:22 AM
    Author     : Admins
--%>

<%@page import="java.util.List"%>
<%@page import="classes.Category"%>
<%@page import="com.mycompany.presentationtier.BussinessServiceProxy"%>
<%@page import="com.mycompany.bussinesstier.BussinessService"%>
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
            <%if (request.getParameter("cerrord") != null) {
                    String error = request.getParameter("cerrord");
                    if (error.equals("Successful")) {
                        out.println("jQuery.jGrowl('Deleted Successfully');");
                    } else if (error.equals("CannotInuse")) {
                        out.println("jQuery.jGrowl('Cannot Delete Category In Use');");
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

                            <div class="">
                                <div class="widgetbox uncollapsible">
                                    <div class="title"><h2 class="general"><span>Categories</span></h2></div>
                                    <div class="widgetcontent">
                                        <table cellpadding="0" cellspacing="0" border="0" class="stdtable mediatable" id="dyntable">
                                            <colgroup>
                                                <col class="con0" />
                                                <col class="con1" />
                                                <col class="con0" />
                                                <col class="con1" />
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th class="head0" rowspan="1" colspan="1" style="width:10%;">ID</th>
                                                    <th class="head0" rowspan="1" colspan="1" style="width:10%;">Name</th>
                                                    <th class="head0" rowspan="1" colspan="1" style="width:10%;"></th>
                                                    <th class="head0" rowspan="1" colspan="1" style="width:10%;"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <%
                                                BussinessService proxy = BussinessServiceProxy.getProxy();
                                                List<Category> cc = proxy.getAllCategory();
                                                if (cc.isEmpty()) {
                                                    out.println("No records");
                                                } else {
                                                    for (Category c : cc) {
                                                        out.print("<tr>"
                                                                + "<td class='center'>#" + c.getCategoryID() + "</td>"
                                                                + "<td class='center'>" + c.getName() + "</td>"
                                                                + "<td align='center'> "
                                                                + "<span><a href='manage_category.jsp?task=update&cid=" + c.getCategoryID() + "' "
                                                                + "class='btn btn2 btn_book'>"
                                                                + "<span>Update</span></a></span></td>"
                                                                + "<td align='center'> "
                                                                + "<span><a href='ManageCategory?btnDelete&categoryid=" + c.getCategoryID() + "'"
                                                                + "class='btn btn2 btn_book'>"
                                                                + "<span>Delete</span></a></span></td>"
                                                                + "</tr>");
                                                    }
                                                }

                                            %> 
                                        </tbody>
                                    </table>
                                </div><!--widgetcontent-->
                            </div><!--widgetbox-->
                        </div><!--one_half-->
                        <%String cid = "auto increment";
                            String cname = "";
                            if (request.getParameter("task") != null && request.getParameter("cid") != null) {
                                if (request.getParameter("task").equals("update") && !request.getParameter("cid").equals("")) {
                                    cid = request.getParameter("cid");
                                    Category c = (Category) proxy.getOne(Integer.parseInt(cid), "category");
                                    cname = c.getName();
                                }
                            }%>
                        <div class=" last">
                            <div class="widgetbox uncollapsible">
                                <div class="title"><h2 class="general"><span>&nbsp;</span></h2></div>
                                <div class="widgetcontent">
                                    <form id="form2" class="stdform stdform2" method="post" action="ManageCategory">
                                        <p>
                                            <label>Category Name</label>
                                            <input type="text" name="categoryid" id="categoryid" class="shortinput" readonly="true" value="<%=cid%>" hidden/>
                                            <span class="field"><input type="text" name="cname" id="cname" class="shortinput" required value="<%=cname%>"/></span>
                                        </p>

                                        <p class="stdformbutton">
                                            <button type="submit" name="btnAdd" class="submit radius2">Add new</button>
                                            <button type="submit" name="btnUpdate" class="submit radius2">Update</button>
                                        </p>
                                    </form>
                                </div><!--widgetcontent-->
                            </div><!--widgetbox-->
                        </div><!--one_half last-->
                        <%if (request.getParameter("cerror") != null) {
                                String error = request.getParameter("cerror");
                                if (error.equals("Successful")) {
                                    out.println("<div class='notification msgsuccess'>"
                                            + "<a class='close'></a><p>Task Successfully Finished"
                                            + "</p></div>");
                                }
                            }%>
                    </div><!--maincontentinner-->

                    <!--footer-->
                    <div class="footer">
                        <p>Black Lotus Cakes © 2020. All Rights Reserved.</p>
                    </div>
                </div><!--maincontent-->

            </div><!--mainwrapperinner-->
        </div><!--mainwrapper-->
        <!-- END OF MAIN CONTENT -->

    </body>
</html>
