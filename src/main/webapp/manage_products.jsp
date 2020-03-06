<%-- 
    Document   : view_products
    Created on : Jan 7, 2020, 8:15:54 PM
    Author     : Admins
--%>

<%@page import="com.mycompany.presentationtier.BussinessServiceProxy"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.mycompany.presentationtier.ImageUpload"%>
<%@page import="java.util.List"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="classes.Category"%>
<%@page import="classes.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.User"%>
<%@page import="com.mycompany.bussinesstier2.BussinessService"%>
<%@page import="com.mycompany.bussinesstier2.BussinessService_Service"%>
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
                                <h2 class="form"><span>Manage Products</span></h2>
                            </div><!--contenttitle-->

                        <%
                            BussinessService proxy = BussinessServiceProxy.getProxy();
                            Product p = null;
                            String task = "", pid = "0000";
                            if (request.getParameter("task") != null) {
                                task = request.getParameter("task");
                                if (request.getParameter("pid") != null) {
                                    pid = request.getParameter("pid");
                                    p = (Product) proxy.getOne(Integer.parseInt(pid), "product");
                                }
                            } else {
                                response.sendRedirect("view_products.jsp");
                            }%>

                        <%String pname = "", price = "", discription = "", image = "", category = "";
                            if (p != null) {
                                pname = p.getName();
                                price = p.getPrice();
                                discription = p.getDiscription();
                                image = p.getImage();
                                category = p.getCategory().getCategoryID();
                            }
                        %>
                        <form id="form2" class="stdform stdform2" method="post" action="ManageProducts">
                            <p>
                                <label>Product ID</label>
                                <span class="field"><input type="text" name="productid" id="productid" class="longinput" 
                                                           readonly="true" value="<%=pid%>"/></span>
                            </p>

                            <p>
                                <label>Name</label>
                                <span class="field"><input type="text" name="pname" id="pname" class="longinput" 
                                                           required value="<%=pname%>"/></span>
                            </p>

                            <p>
                                <label>Description</label>
                                <span class="field"><textArea type="text" rows="5" name="description" id="description" 
                                                              class="longinput" required><%=discription%></textArea></span>
                            </p>
                            <p>
                                <label>Price</label>
                                <span class="field"><input type="number" name="price" id="price" class="longinput" 
                                                           required value="<%=price%>"/></span>
                            </p>
                            <p>
                                <label>Category</label>
                                <span class="field"><select name="category" id="selection2" required>
                                        <%for (Category c : proxy.getAllCategory()) {%>
                                        <option value="<%=c.getCategoryID()%>"
                                                <%if (category.equals(c.getCategoryID())) {
                                                        out.println("selected");
                                                    }%>>
                                            <%out.println(c.getName());%>
                                        </option>
                                        <%}%>
                                    </select></span>
                                <span class="field"><input type="text" name="Upimage" id="Upimage" class="longinput" 
                                                           value="<%=image%>" hidden/></span>
                            </p>

                            <%if (task.equals("update")) {%>
                            <p>
                                <label>Image</label>
                                <a href="<%=image%>" target='_blank'><img width='25%'
                                                                          src="<%=image%>"/></a>
                            </p>
                            <%}%>

                            <p class="stdformbutton">
                                <%if (task.equals("update")) {%>
                                <button type="submit" name="btnUpdate" class="submit radius2">Update Products</button>
                                <%} else if (task.equals("add")) {%>
                                <button type="submit" name="btnAdd" class="submit 
                                        radius2">Add Products</button>
                                <%}%>
                            </p>
                        </form>
                        <%if (task.equals("update")) {%>
                        <form id="form2" class="stdform stdform2" method="post" 
                              action="ImageUpload?btnUpload&pid=<%=pid%>"enctype="multipart/form-data">
                            <p>
                                <label><input type = "submit" value = "Upload Image" class="submit radius2"/></label>
                                <span class="field"><input type="file" name="image" id="image" class="longinput"/>                               
                            </p>
                        </form>
                        <%}%>
                        <%if (request.getParameter("perror") != null) {
                                String error = request.getParameter("perror");
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

