/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import classes.Item;
import classes.Sale;
import classes.User;
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
@WebServlet(name = "ManageSales", urlPatterns = {"/ManageSales"})
public class ManageSales extends HttpServlet {

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
            String saleid = request.getParameter("saleid");
            //String quantity = request.getParameter("quantity");
            String payment = request.getParameter("payment");
            String amount = request.getParameter("amount");
            if (request.getParameter("btnAdd") != null) {
                if (payment == null) {
                    response.sendRedirect("sale_products.jsp");
                } else {
                    Sale s = new Sale();
                    s.setSaleID("auto");
                    s.setDate("auto");
                    s.setPaymentType(payment);
                    s.setAmount(amount);
                    UserSession us = GetUserSession.getSession(request, request.getSession());
                    if (us == null) {
                        response.sendRedirect("index.jsp");
                    } else {
                        User u = us.getUser();
                        s.setUser(u);
                        ShoppingCartSession scs = GetUserSession.getCartSession(request, request.getSession());
                        List<Item> items = scs.getItemList();
                        if (items.isEmpty()) {
                            response.sendRedirect("payment.jsp?serror=empty");
                        } else {
                            String res = proxy.addSale(s, items);
                            if (res.equals("Successful")) {
                                response.sendRedirect("bill.jsp?sid=" + proxy.getLastInsertedId("sale"));
                                items.clear();
                            } else {
                                response.sendRedirect("payment.jsp?serror=" + res); 
                            }
                        }
                    }
                }
            } else if (request.getParameter("btnDelete") != null) {
                if (saleid != null) {
                    int sid = Integer.parseInt(saleid);
                    String res = proxy.delete(sid, "sale");
                    response.sendRedirect("view_sales.jsp?serror=" + res);
                } else {
                    response.sendRedirect("view_sales.jsp");
                }
            } else {
                response.sendRedirect("payment.jsp");
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
