/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import classes.Vendor;
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
@WebServlet(name = "ManageVendors", urlPatterns = {"/ManageVendors"})
public class ManageVendors extends HttpServlet {

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
            String vendorid = request.getParameter("userid");
            String fname = request.getParameter("firstname");
            String lname = request.getParameter("lastname");
            String email = request.getParameter("email");
            String company = request.getParameter("company");
            String address = request.getParameter("address");
            String telephone = request.getParameter("telephone");
            if (request.getParameter("btnUpdate") != null) {
                if (vendorid == null || fname == null || lname == null || email == null || company == null || address == null || telephone == null) {
                    response.sendRedirect("view_vendors.jsp");
                } else {
                    Vendor v = new Vendor();
                    v.setUserID(vendorid);
                    v.setFName(fname);
                    v.setLName(lname);
                    v.setEmail(email);
                    v.setCompany(company);
                    v.setAddress(address);
                    v.setTelephone(telephone);
                    v.setType("vendor");
                    String res = proxy.update(v,"vendor");
                    response.sendRedirect("manage_vendors.jsp?task=update&vid=" + vendorid + "&verror=" + res);
                }
            } else if (request.getParameter("btnDelete") != null) {
                if (request.getParameter("vid") != null) {
                    int vid = Integer.parseInt(request.getParameter("vid"));
                    String res = proxy.delete(vid,"vendor");
                    response.sendRedirect("view_vendors.jsp?verror=" + res);
                }
            } else {
                response.sendRedirect("view_vendors.jsp");
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
