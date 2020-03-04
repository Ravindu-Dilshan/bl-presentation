/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import classes.Item;
import classes.Order;
import classes.Vendor;
import com.mycompany.bussinesstier.BussinessService;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admins
 */
@WebServlet(name = "ManageOrders", urlPatterns = {"/ManageOrders"})
public class ManageOrders extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            BussinessService proxy = BussinessServiceProxy.getProxy();
            String orderid = request.getParameter("orderid");
            String status = request.getParameter("status");
            String date = request.getParameter("date");
            String amount = request.getParameter("amount");
            if (request.getParameter("btnAdd") != null) {
                if (date == null || amount == null) {
                    response.sendRedirect("view_stocks.jsp");
                } else {
                    Order o = new Order();
                    o.setOrderID("auto");
                    o.setStatus("pending");
                    o.setAmount(amount);
                    UserSession us = GetUserSession.getSession(request, request.getSession());
                    if (us == null) {
                        response.sendRedirect("index.jsp");
                    } else {
                        String vid = us.getUser().getUserID();
                        Vendor v = (Vendor) proxy.getOne(Integer.parseInt(vid), "vendor");
                        o.setVendor(v);
                        o.setDate(date);
                        ShoppingCartSession scs = GetUserSession.getCartSession(request, request.getSession());
                        List<Item> items = scs.getItemList();
                        if (items.isEmpty()) {
                            response.sendRedirect("shopping_cart.jsp?oerror=empty");
                        } else {
                            String res = proxy.addOrder(o, items);
                            if (res.equals("Successful")) {
                                response.sendRedirect("invoice.jsp?oid=" + proxy.getLastInsertedId("order"));
                                items.clear();
                            } else {
                                response.sendRedirect("shopping_cart.jsp?oerror=" + res);
                            }
                        }
                    }
                }
            } else if (request.getParameter("btnUpdate") != null) {
                if (orderid == null || status == null) {
                    response.sendRedirect("view_orders.jsp");
                } else {
                    Order o = (Order) proxy.getOne(Integer.parseInt(orderid), "order");
                    o.setStatus(status);
                    String res = proxy.update(o, "order");
                    response.sendRedirect("manage_orders.jsp?oid=" + orderid + "&oerror=" + res);
                }
            } else if (request.getParameter("btnDelete") != null) {
                if (orderid != null) {
                    int oid = Integer.parseInt(orderid);
                    String res = proxy.delete(oid, "order");
                    response.sendRedirect("view_orders.jsp?oerror=" + res);
                } else {
                    response.sendRedirect("view_orders.jsp");
                }
            } else if (request.getParameter("DeletebyVendor") != null) {
                //if vendor deletes the oreder changes the status of the order
                //insted of deleting
                if (orderid != null) {
                    Order o = (Order) proxy.getOne(Integer.parseInt(orderid), "order");
                    o.setStatus("Deleted By Vendor");
                    String res = proxy.update(o, "order");
                    response.sendRedirect("vendor_orders.jsp?oerror=" + res);
                } else {
                    response.sendRedirect("vendor_orders.jsp");
                }
            } else {
                response.sendRedirect("shopping_cart.jsp");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
