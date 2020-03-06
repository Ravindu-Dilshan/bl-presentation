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
@WebServlet(name = "VendorRegister", urlPatterns = {"/VendorRegister"})
public class VendorRegister extends HttpServlet {

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
            String fname = request.getParameter("txtFname");
            String lname = request.getParameter("txtLname");
            String email = request.getParameter("txtEmail");
            String company = request.getParameter("txtCompany");
            String address = request.getParameter("txtAddress");
            String telephone = request.getParameter("txtTelephone");
            String password = request.getParameter("txtPassword");
            String Cpassword = request.getParameter("txtCpassword");
            if (fname == null || lname == null || email == null || company == null
                    || address == null || telephone == null || password == null || Cpassword == null) {
                response.sendRedirect("register_vendor.jsp");
            } else if (!password.equals(Cpassword)) {
                response.sendRedirect("register_vendor.jsp?regerror=1");
            } else {
                Vendor v = new Vendor();
                v.setFName(fname);v.setLName(lname);v.setEmail(email);
                v.setCompany(company);v.setAddress(address);v.setTelephone(telephone);
                v.setPassword(Cpassword);v.setType("vendor");
                String res = proxy.addVendor(v);
                response.sendRedirect("register_vendor.jsp?regerror="+res);
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
