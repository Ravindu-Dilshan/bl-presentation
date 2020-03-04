/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import classes.User;
import classes.Vendor;
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
@WebServlet(name = "ManageProfile", urlPatterns = {"/ManageProfile"})
public class ManageProfile extends HttpServlet {

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
            String userid = request.getParameter("userid");
            String fname = request.getParameter("firstname");
            String lname = request.getParameter("lastname");
            String email = request.getParameter("email");
            String company = request.getParameter("company");
            String address = request.getParameter("address");
            String telephone = request.getParameter("telephone");
            String password = request.getParameter("password");
            String type = request.getParameter("type");
            if (request.getParameter("btnPasswordChange") != null) {
                if (request.getParameter("uid") != null || password == null) {
                    int uid = Integer.parseInt(request.getParameter("uid"));
                    String newPassword = request.getParameter("Npassword");
                    String ConPassword = request.getParameter("Cmpassword");
                    if (newPassword.equals(ConPassword)) {
                        String res = proxy.updatePassword(uid, password, newPassword);
                        response.sendRedirect("manage_profile.jsp?uerror=" + res);
                    } else {
                        response.sendRedirect("manage_profile.jsp?uerror=noMatch");
                    }
                } else {
                    response.sendRedirect("manage_profile.jsp");
                }
            } else if (request.getParameter("btnUpdate") != null) {
                if (type.equals("vendor")) {
                    if (userid == null || fname == null || lname == null || email == null || company == null || address == null || telephone == null) {
                        response.sendRedirect("manage_profile.jsp");
                    } else {
                        Vendor v = new Vendor();
                        v.setUserID(userid);
                        v.setFName(fname);
                        v.setLName(lname);
                        v.setEmail(email);
                        v.setCompany(company);
                        v.setAddress(address);
                        v.setTelephone(telephone);
                        v.setType("vendor");
                        String res = proxy.update(v, "vendor");
                        response.sendRedirect("manage_profile.jsp?&uerror=" + res);
                    }
                }else{
                    if (userid == null ||fname == null || lname == null || email == null || type == null) {
                    response.sendRedirect("manage_profile.jsp");
                } else {
                    User u = new User();
                    u.setUserID(userid);
                    u.setFName(fname);
                    u.setLName(lname);
                    u.setEmail(email);
                    u.setType(type);
                    u.setPassword("");
                    String res = proxy.update(u,"user");
                    response.sendRedirect("manage_profile.jsp?&uerror=" + res);
                }
                }
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
