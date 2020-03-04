<%-- 
    Document   : index.jsp
    Created on : Dec 27, 2019, 10:57:43 AM
    Author     : Admins
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>BlackLotus | Login Page</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <script type="text/javascript" src="js/plugins/jquery-1.7.min.js"></script>
        <script type="text/javascript" src="js/plugins/jquery-ui-1.8.16.custom.min.js"></script>

        <script type="text/javascript" src="js/custom/general.js"></script>

    </head>

    <body class="login">

        <div class="loginbox radius3">
            <div class="loginboxinner radius3">
                <div class="loginheader">
                    <h1 class="bebas">Sign In</h1>
                    <div class="logo"><img src="images/logoWhite.png" alt="" width="120" height="60" /></div>
                </div><!--loginheader-->

                <div class="loginform">
                    <form id="login" action="UserLogin" method="post">
                        <p>
                            <label for="username" class="bebas">Email</label>
                            <input type="email" id="username" name="txtUsername" class="radius2" required/>
                        </p>
                        <p>
                            <label for="password" class="bebas">Password</label>
                            <input type="password" id="password" name="txtPassword" class="radius2" required/>
                        </p>
                        <p>
                            <button type="submit" class="radius3 bebas">Sign in</button>
                        </p>
                    </form>
                    <p><a href="register_vendor.jsp" class="whitelink small"> Want to Buy Supplies?..Register Here</a></p>
                    <%if (request.getParameter("loginerror") != null) {
                            out.println("<div class='notification msgerror'>"
                                    + "<a class='close'></a><p>Incorrect Email or Password"
                                    + "</p></div>");
                }%>
                </div><!--loginform-->
            </div><!--loginboxinner-->
            <div class="footer">
                <p>Black Lotus Cakes © 2020. All Rights Reserved.</p>
            </div>
        </div><!--loginbox-->

    </body>

</html>

