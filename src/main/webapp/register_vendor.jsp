<%-- 
    Document   : register_vendor
    Created on : Dec 27, 2019, 2:35:19 PM
    Author     : Admins
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>BlackLotus | Register Page</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <script type="text/javascript" src="js/plugins/jquery-1.7.min.js"></script>
        <script type="text/javascript" src="js/plugins/jquery-ui-1.8.16.custom.min.js"></script>
        <script type="text/javascript" src="js/custom/general.js"></script>
    </head>

    <body class="login">

        <div class="loginbox radius3">
            <div class="loginboxinner radius3">
                <div class="loginheader">
                    <h1 class="bebas">Register</h1>
                    <div class="logo"><img src="images/logoWhite.png" alt="" width="120" height="60" /></div>
                </div><!--loginheader-->

                <div class="loginform">
                    <form id="register_vendor" action="VendorRegister" method="POST">
                        <p>
                            <label for="firstname" class="bebas">First Name</label>
                            <input type="text" id="firstname" name="txtFname" class="radius2" required/>
                        </p>
                        <p>
                            <label for="lastname" class="bebas">Last Name</label>
                            <input type="text" id="lastname" name="txtLname" class="radius2 longinput" required/>
                        </p>
                        <p>
                            <label for="email" class="bebas">Email</label>
                            <input type="email" id="email" name="txtEmail" class="radius2" required/>
                        </p>
                        <p>
                            <label for="company" class="bebas">Company</label>
                            <input type="text" id="company" name="txtCompany" class="radius2" required/>
                        </p>
                        <p>
                            <label for="address" class="bebas">Address</label>
                            <textarea rows="2" cols="50" id="address" name="txtAddress" class="radius2" required></textarea> 
                        </p>
                        <p>
                            <label for="telephone" class="bebas">Telephone</label>
                            <input type="text" id="telephone" name="txtTelephone" class="radius2" required/>
                        </p>
                        <p>
                            <label for="username" class="bebas">Password</label>
                            <input type="password" id="username" name="txtPassword" class="radius2" required/>
                        </p>
                        <p>
                            <label for="Cpassword" class="bebas">Confirm Password</label>
                            <input type="password" id="Cpassword" name="txtCpassword" class="radius2" required/>
                        </p>
                        <p>
                            <button type="submit" class="radius3 bebas">Register</button>
                        </p>
                    </form>
                    <p><a href="index.jsp" class="whitelink small">Already Have an Account?.. Login Here</a></p>
                    <!--<div id="result"></div>-->
                    <%if (request.getParameter("regerror") != null) {
                            String error = request.getParameter("regerror");
                            if (error.equals("1")) {
                                out.println("<div class='notification msgerror'>"
                                        + "<a class='close'></a><p>Passwords Don't Match"
                                        + "</p></div>");
                            } else if (error.equals("EmailInUse")) {
                                out.println("<div class='notification msgerror'>"
                                        + "<a class='close'></a><p>Email Already In Use"
                                        + "</p></div>");
                            } else if (error.equals("Successful")) {
                                out.println("<div class='notification msgsuccess'>"
                                        + "<a class='close'></a><p>Registered Successfully"
                                        + "</p></div>");
                            }
                        }%>
                </div><!--loginform-->

            </div><!--loginboxinner-->
            <div class="footer">
                <p>Black Lotus Cakes © 2020. All Rights Reserved.</p>
            </div>
        </div><!--loginbox-->

    </body>

</html>
