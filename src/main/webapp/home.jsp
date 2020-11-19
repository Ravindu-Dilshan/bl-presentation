<%-- 
    Document   : home
    Created on : Dec 27, 2019, 11:05:35 AM
    Author     : Admins
--%>

<%@page import="com.mycompany.presentationtier.UserSession"%>
<%@page import="java.util.List"%>
<%@page import="classes.User"%>
<%@page import="com.mycompany.bussinesstier2.BussinessService"%>
<%@page import="com.mycompany.bussinesstier2.BussinessService_Service"%>
<%@page import="com.mycompany.presentationtier.UserLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>BlackLotus</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" />
        <script type="text/javascript" src="js/plugins/jquery-1.7.min.js"></script>
        <script type="text/javascript" src="js/plugins/jquery-ui-1.8.16.custom.min.js"></script>
        <script type="text/javascript" src="js/custom/general.js"></script>

        <style>

            .background {
                background: url('images/home1.jpg');
                filter: blur(4px);
                -webkit-filter: blur(4px);
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                min-height: 85vh;
            }
            h1,h2,h3{
                color: white;
            }
            .container{
                background-color: rgb(0,0,0); /* Fallback color */
                background-color: rgba(0,0,0, 0.4); /* Black w/opacity/see-through */
                color: white;
                font-weight: bold;
                border: 3px solid #f1f1f1;
                position: absolute;
                top: 50%;
                left: 57%;
                transform: translate(-50%, -50%);
                z-index: 2;
                width: 50%;
                padding: 20px;
                text-align: center;
            }
            @media (min-width: 576px) {
                .background h1 {
                    font-size: 5.5rem;
                }
                .display-5 {
                    font-size: 2.5rem;
                }
                #greeting {
                    margin-top: 2rem;
                    font-size: 2.5rem;
                }
            }
            @media (min-width: 992px) {
                .background h1 {
                    font-size: 6rem;
                }
                #greeting {
                    font-size: 3rem;
                }
            }

            @media (min-width: 1200px) {
                .background h1 {
                    font-size: 7.5rem;
                }
                #greeting {
                    font-size: 3.6rem;
                }
            }

        </style>
    </head>
    <%@include file="header.jsp" %>
    <body class="loggedin">     
        <!-- START OF MAIN CONTENT -->
        <div class="mainwrapper">
            <div class="mainwrapperinner">
                <jsp:include page="dashboard.jsp"></jsp:include>
                    <div class="maincontent noright">
                        <div class="maincontentinner">
                            <div class="background"></div>
                            <div class="container">
                                <div class="row flex-column justify-content-center align-items-center text-center">
                                    <div class="col-sm-12 col-md-10 col-lg-8">
                                        <h1 id="time">12:00 AM</h1>
                                        <h3 id="day" class="display-5">Monday, January 01</h3>
                                        <h2 id="greeting">Good Morning</h2><h2><%=name%></h2>
                                    <h3>What would you like to do today?</h3>
                                    <p>This Webiste is not Commercial !!!! Developed for demo puposes only || Created on 2019</p>
                                </div><!-- /.col -->

                            </div><!-- /.row -->         
                        </div>

                        <!--footer-->

                    </div><!--maincontent-->
                    <div class="footer">
                        <p>Black Lotus Cakes © 2020. All Rights Reserved.</p>
                        <p>This Webiste is not Commercial !!!! Developed for demo puposes only || Created on 2019</p>
                    </div>
                </div><!--mainwrapperinner-->
            </div><!--mainwrapper-->
            <!-- END OF MAIN CONTENT -->

            <script>
                // Document ready function
                jQuery(document).ready(function () {

                    // Time function to get the date/time
                    function time() {

                        // Create new date var and init other vars
                        var date = new Date(),
                                hours = date.getHours(), // Get the hours
                                minutes = date.getMinutes().toString(), // Get minutes, convert to string
                                ante, // Will be used for AM and PM
                                greeting, // Set the appropriate greeting for the time of day
                                dd = date.getDate().toString();// Get the current day

                        /* Set the AM or PM according to the time, it is important to note that up
                         to this point in the code this is a 24 clock */
                        if (hours < 12) {
                            ante = "AM";
                            greeting = "Morning";
                        } else if (hours < 3) {
                            ante = "PM";
                            greeting = "Evening"
                        } else {
                            ante = "PM";
                            greeting = "Afternoon";
                        }

                        /* Since it is a 24 hour clock, 0 represents 12am, if that is the case
                         then convert that to 12 */
                        if (hours === 0) {
                            hours = 12;

                            /* For any other case where hours is not equal to twelve, let's use modulus
                             to get the corresponding time equivilant */
                        } else if (hours !== 12) {
                            hours = hours % 12;
                        }

                        // Minutes can be in single digits, hence let's add a 0 when the length is less than two
                        if (minutes.length < 2) {
                            minutes = "0" + minutes;
                        }

                        // Let's do the same thing above here for the day
                        if (dd.length < 2) {
                            dd = "0" + dd;
                        }

                        // Months
                        Date.prototype.monthNames = [
                            "January",
                            "February",
                            "March",
                            "April",
                            "May",
                            "June",
                            "July",
                            "August",
                            "September",
                            "October",
                            "November",
                            "December"
                        ];

                        // Days
                        Date.prototype.weekNames = [
                            "Sunday",
                            "Monday",
                            "Tuesday",
                            "Wednesday",
                            "Thursday",
                            "Friday",
                            "Saturday"
                        ];

                        // Return the month name according to its number value
                        Date.prototype.getMonthName = function () {
                            return this.monthNames[this.getMonth()];
                        };

                        // Return the day's name according to its number value
                        Date.prototype.getWeekName = function () {
                            return this.weekNames[this.getDay()];
                        };

                        // Display the following in html
                        jQuery("#time").html(hours + ":" + minutes + " " + ante);
                        jQuery("#day").html(date.getWeekName() + ", " + date.getMonthName() + " " + dd);
                        jQuery("#greeting").html("Good " + greeting);

                        // The interval is necessary for proper time syncing
                        setInterval(time, 1000);
                    }
                    time();
                });

            </script>
    </body>
</html>


