/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import classes.Item;
import classes.Stock;
import com.mycompany.bussinesstier.BussinessService;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admins
 */
@WebServlet(name = "AddToCart", urlPatterns = {"/AddToCart"})
public class AddToCart extends HttpServlet {

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
            String stockid = request.getParameter("stockid");
            String quantity = request.getParameter("quantity");
            boolean sale = false;
            //if the cart is sale true 
            //if the cart is order false
            if (request.getParameter("btnAddSale") != null) {
                sale = true;
            }
            ShoppingCartSession shoppingCartSession = null;
            if (stockid != null || quantity != null) {
                shoppingCartSession = GetUserSession.getCartSession(request, request.getSession());
                if (shoppingCartSession == null) {
                    List<Item> itemList = new ArrayList<>();
                    Item i = new Item();
                    Stock s = (Stock) proxy.getOne(Integer.parseInt(stockid), "stock");
                    i.setQuantity(quantity);
                    i.setStock(s);
                    i.setRefID("0000");
                    itemList.add(i);
                    String uuid = UUID.randomUUID().toString().replace("-", "");
                    shoppingCartSession = new ShoppingCartSession(uuid);
                    shoppingCartSession.setItemList(itemList);
                    HttpSession session = request.getSession();
                    session.setAttribute(shoppingCartSession.getUuid(), shoppingCartSession);
                    Cookie cookie = new Cookie("cart-session-id", shoppingCartSession.getUuid());
                    response.addCookie(cookie);
                    if (sale) {
                        response.sendRedirect("sale_products.jsp?added");
                    } else {
                        response.sendRedirect("shopping_cart.jsp");
                    }
                } else {
                    List<Item> itemList = shoppingCartSession.getItemList();
                    for (int i = 0; i < itemList.size(); i++) {
                        //if item is already in the cart add the quantity value to it
                        if (itemList.get(i).getStock().getStockID().equals(stockid)) {
                            int q = Integer.parseInt(itemList.get(i).getQuantity()) + Integer.parseInt(quantity);
                            itemList.get(i).setQuantity(q + "");
                            if (sale) {
                                response.sendRedirect("sale_products.jsp?added");
                                return;
                            } else {
                                response.sendRedirect("shopping_cart.jsp");
                                return;
                            }    
                        }
                    }
                    Item i = new Item();
                    Stock s = (Stock) proxy.getOne(Integer.parseInt(stockid), "stock");
                    i.setQuantity(quantity);
                    i.setStock(s);
                    i.setRefID("0000");
                    itemList.add(i);
                    if (sale) {
                        response.sendRedirect("sale_products.jsp?added");
                    } else {
                        response.sendRedirect("shopping_cart.jsp");
                    }
                }
            } else if (request.getParameter("btnRemove") != null) {
                stockid = request.getParameter("sid");
                shoppingCartSession = GetUserSession.getCartSession(request, request.getSession());
                List<Item> itemList = shoppingCartSession.getItemList();
                //check and remove item from the cart
                for (int i = 0; i < itemList.size(); i++) {
                    if (itemList.get(i).getStock().getStockID().equals(stockid)) {
                        itemList.remove(i);
                    }
                }
                if (sale) {
                    response.sendRedirect("payment.jsp");
                } else {
                    response.sendRedirect("shopping_cart.jsp");
                }
            } else {
                response.sendRedirect("products.jsp");
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
