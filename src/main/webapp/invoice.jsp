<%-- 
    Document   : invoice
    Created on : Jan 17, 2020, 11:35:29 AM
    Author     : Admins
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.Order"%>
<%@page import="classes.Item"%>
<%@page import="com.mycompany.presentationtier.BussinessServiceProxy"%>
<%@page import="java.util.List"%>
<%@page import="classes.Product"%>
<%@page import="com.mycompany.bussinesstier2.BussinessService"%>
<%@page import="com.mycompany.bussinesstier2.BussinessService_Service"%>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="utf-8">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Invoice</title>
        <style>
            /* reset */

            *
            {
                border: 0;
                box-sizing: content-box;
                color: inherit;
                font-family: inherit;
                font-size: inherit;
                font-style: inherit;
                font-weight: inherit;
                line-height: inherit;
                list-style: none;
                margin: 0;
                padding: 0;
                text-decoration: none;
                vertical-align: top;
            }

            /* heading */

            h1 { font: bold 100% sans-serif; letter-spacing: 0.5em; text-align: center; text-transform: uppercase; }

            /* table */

            table { font-size: 75%; table-layout: fixed; width: 100%; }
            table { border-collapse: separate; border-spacing: 2px; }
            th, td { border-width: 1px; padding: 0.5em; position: relative; text-align: left; }
            th, td { border-radius: 0.25em; border-style: solid; }
            th { background: #EEE; border-color: #BBB; }
            td { border-color: #DDD; }

            /* page */

            html { font: 16px/1 'Open Sans', sans-serif; overflow: auto; padding: 0.5in; }
            html { background: #999; cursor: default; }

            body { box-sizing: border-box;margin: 0 auto; overflow: hidden; padding: 0.5in; width: 8.5in; }
            body { background: #FFF; border-radius: 1px; box-shadow: 0 0 1in -0.25in rgba(0, 0, 0, 0.5); }

            /* header */

            header { margin: 0 0 3em; }
            header:after { clear: both; content: ""; display: table; }

            header h1 { background: #000; border-radius: 0.25em; color: #FFF; margin: 0 0 1em; padding: 0.5em 0; }
            header address { float: left; font-size: 75%; font-style: normal; line-height: 1.25; margin: 0 1em 1em 0; }
            header address p { margin: 0 0 0.25em; }
            header span, header img { display: block; float: right; }
            header span { margin: 0 0 1em 1em; max-height: 25%; max-width: 60%; position: relative; }
            header img { max-height: 100%; max-width: 100%; }
            header input { cursor: pointer;
                           -ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
                           height: 100%; left: 0; opacity: 0; position: absolute; 
                           top: 0; width: 100%; }

            /* article */

            article, article address, table.meta, table.inventory { margin: 0 0 3em; }
            article:after { clear: both; content: ""; display: table; }
            article h1 { clip: rect(0 0 0 0); position: absolute; }

            article address { float: left; font-weight: bold; }

            /* table meta & balance */

            table.meta, table.balance { float: right; width: 36%; }
            table.meta:after, table.balance:after { clear: both; content: ""; display: table; }

            /* table meta */

            table.meta th { width: 40%; }
            table.meta td { width: 60%; }

            /* table items */

            table.inventory { clear: both; width: 100%; }
            table.inventory th { font-weight: bold; text-align: center; }

            table.inventory td:nth-child(1) { width: 26%; }
            table.inventory td:nth-child(2) { width: 38%; }
            table.inventory td:nth-child(3) { text-align: right; width: 12%; }
            table.inventory td:nth-child(4) { text-align: right; width: 12%; }
            table.inventory td:nth-child(5) { text-align: right; width: 12%; }

            /* table balance */

            table.balance th, table.balance td { width: 50%; }
            table.balance td { text-align: right; }

            /* aside */

            aside h1 { border: none; border-width: 0 0 1px; margin: 0 0 1em; }
            aside h1 { border-color: #999; border-bottom-style: solid; }

            @media print {
                * { -webkit-print-color-adjust: exact; }
                html { background: none; padding: 0; }
                body { box-shadow: none; margin: 0; }
                span:empty { display: none; }
            }

            @page { margin: 0; }
        </style>
    </head>
    <body>
        <%
            BussinessService proxy = BussinessServiceProxy.getProxy();
            Order o = null;
            String oid = null;
            if (request.getParameter("oid") != null) {
                oid = request.getParameter("oid");
                o = (Order) proxy.getOne(Integer.parseInt(oid), "order");
            } else {
                response.sendRedirect("view_orders.jsp");
            }%>
        <%String address = "", telephone = "", company = "", date = "";
            List<Item> itemList = null;
            if (o != null) {
                address = o.getVendor().getAddress();
                telephone = o.getVendor().getTelephone();
                company = o.getVendor().getCompany();
                date = o.getDate();
                itemList = proxy.getAllItems(Integer.parseInt(oid), "order");
            } else {
                response.sendRedirect("view_orders.jsp");
            }
        %>
        <header>
            <h1>Invoice</h1>
            <address>
                <p><%=address%></p>
                <p><%=telephone%></p>
            </address>
            <span><img alt="" width="30%" src="images/logo.png"></span>
        </header>
        <article>
            <address>
                <p><%=company%></p>
            </address>
            <table class="meta">
                <tr>
                    <th><span contenteditable>Order ID</span></th>
                    <td><span contenteditable><%=oid%></span></td>
                </tr>
            </table>
            <table class="inventory">
                <thead>
                    <tr>
                        <th><span>Stock ID</span></th>
                        <th><span>Product Name</span></th>
                        <th><span>Price</span></th>
                        <th><span>Quantity</span></th>
                        <th><span>Total</span></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (itemList.isEmpty() || itemList == null) {
                            out.println("No records");
                        } else {
                            for (Item i : itemList) {
                                out.print("<tr>"
                                        + "<td><span>" + i.getStock().getStockID() + "</span></td>"
                                        + "<td><span>" + i.getStock().getProduct().getName() + "</span></td>"
                                        + "<td><span>Rs.</span><span>" + i.getStock().getProduct().getPrice() + ".00</span></td>"
                                        + "<td><span>" + i.getQuantity() + "</span></td>"
                                        + "<td><span>Rs.</span><span></span></td>"
                                        + "</tr>");
                            }
                        }
                    %> 
                </tbody>
            </table>
            <table class="balance">
                <tr>
                    <th><span>Net Total</span></th>
                    <td><span>Rs.</span><span>600.00</span></td>
                </tr>
                <tr>
                    <th><span>Delivary Date</span></th>
                    <td><span><%=date%></span></td>
                </tr>
            </table>
        </article>
        <aside>
            <h1><span>Thank you !!</span></h1>
            <div>
                <button onclick="printDoc()">Print this page</button>
            </div>
        </aside>
        <script>
            function printDoc() {
                window.print();
            }
            function parseFloatHTML(element) {
                return parseFloat(element.innerHTML.replace(/[^\d\.\-]+/g, '')) || 0;
            }

            function parsePrice(number) {
                return number.toFixed(2).replace(/(\d)(?=(\d\d\d)+([^\d]|$))/g, '$1,');
            }
            function calculateTotal() {
                var total = 0;
                var cells, price, total, a, i;
                for (var a = document.querySelectorAll('table.inventory tbody tr'), i = 0; a[i]; ++i) {
                    cells = a[i].querySelectorAll('span:last-child');
                    price = parseFloatHTML(cells[2]) * parseFloatHTML(cells[3]);
                    total += price;
                    cells[4].innerHTML = price+".00";
                }
                cells = document.querySelectorAll('table.balance td:last-child span:last-child');
                cells[0].innerHTML = total+".00";
            }
            function onContentLoad() {
                calculateTotal();
            }
            window.addEventListener && document.addEventListener('DOMContentLoaded', onContentLoad);

        </script>
    </body>
</html>
