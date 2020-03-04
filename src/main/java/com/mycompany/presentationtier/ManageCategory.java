/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import classes.Category;
import com.mycompany.bussinesstier.BussinessService;
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
@WebServlet(name = "ManageCategory", urlPatterns = {"/ManageCategory"})
public class ManageCategory extends HttpServlet {

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
            String categoryid = request.getParameter("categoryid");
            String cname = request.getParameter("cname");
            if (request.getParameter("btnUpdate") != null) {
                if (categoryid == null || cname == null) {
                    response.sendRedirect("view_products.jsp");
                } else {
                    Category c = new Category();
                    c.setCategoryID(categoryid);
                    c.setName(cname);
                    String res = proxy.update(c,"category");
                    response.sendRedirect("manage_category.jsp?task=update&cid=" + categoryid + "&cerror=" + res);
                }
            } else if (request.getParameter("btnAdd") != null) {
                if (cname == null) {
                    response.sendRedirect("manage_category.jsp");
                } else {
                    Category c = new Category();
                    c.setCategoryID(categoryid);
                    c.setName(cname);
                    String res = proxy.addCategory(c);
                    response.sendRedirect("manage_category.jsp?cerror=" + res);
                }
            } else if (request.getParameter("btnDelete") != null) {
                if (categoryid != null) {
                    int cid = Integer.parseInt(categoryid);
                    String res = proxy.delete(cid,"category");
                    response.sendRedirect("manage_category.jsp?cerrord=" + res);
                }else{
                    response.sendRedirect("manage_category.jsp");
                }
            }
            else {
                response.sendRedirect("manage_category.jsp");
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
