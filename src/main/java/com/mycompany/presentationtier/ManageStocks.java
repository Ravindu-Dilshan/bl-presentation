/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import classes.Product;
import classes.Stock;
import com.mycompany.bussinesstier2.BussinessService;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admins
 */
@WebServlet(name = "ManageStocks", urlPatterns = {"/ManageStocks"})
public class ManageStocks extends HttpServlet {

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
            String date = request.getParameter("date");
            String product = request.getParameter("product");
            if (request.getParameter("btnUpdate") != null) {
                if (stockid == null || quantity == null || date == null || product == null) {
                    response.sendRedirect("view_stocks.jsp");
                } else {
                    Stock s = new Stock();
                    s.setStockID(stockid);
                    s.setQuantity(quantity);
                    s.setLastUpdate(date);
                    Product p = (Product) proxy.getOne(Integer.parseInt(product),"product");
                    s.setProduct(p);
                    String res = proxy.update(s,"stock");
                    response.sendRedirect("manage_stocks.jsp?task=update&sid=" + stockid + "&serror=" + res);
                }
            } else if (request.getParameter("btnAdd") != null) {
                if (quantity == null || date == null || product == null) {
                    response.sendRedirect("view_stocks.jsp");
                } else {
                    Stock s = new Stock();
                    s.setStockID("auto");
                    s.setQuantity(quantity);
                    s.setLastUpdate(date);
                    Product p = (Product) proxy.getOne(Integer.parseInt(product),"product");
                    s.setProduct(p);
                    String res = proxy.addStock(s);
                    response.sendRedirect("manage_stocks.jsp?task=add&serror=" + res);
                }
            } else if (request.getParameter("btnDelete") != null) {
                if (request.getParameter("sid") != null) {
                    int sid = Integer.parseInt(request.getParameter("sid"));
                    String res = proxy.delete(sid, "stock");
                    response.sendRedirect("view_stocks.jsp?serror=" + res);
                }
            }
            else {
                response.sendRedirect("view_stocks.jsp");
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
