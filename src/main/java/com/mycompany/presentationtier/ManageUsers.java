/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import classes.User;
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
@WebServlet(name = "ManageUsers", urlPatterns = {"/ManageUsers"})
public class ManageUsers extends HttpServlet {

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
            String type = request.getParameter("type");
            String password = request.getParameter("password");
            if (request.getParameter("btnUpdate") != null) {
                if (userid == null ||fname == null || lname == null || email == null || type == null) {
                    response.sendRedirect("view_users.jsp");
                } else {
                    User u = new User();
                    u.setUserID(userid);
                    u.setFName(fname);
                    u.setLName(lname);
                    u.setEmail(email);
                    u.setType(type);
                    u.setPassword("");
                    String res = proxy.update(u,"user");
                    response.sendRedirect("manage_users.jsp?task=update&uid="+userid+"&uerror=" + res);
                }
            }
            else if (request.getParameter("btnAdd") != null) {
                if (password == null ||fname == null || lname == null || email == null || type == null) {
                    response.sendRedirect("view_users.jsp");
                } else {
                    User u = new User();
                    u.setUserID("auto");
                    u.setFName(fname);
                    u.setLName(lname);
                    u.setEmail(email);
                    u.setPassword(password);
                    u.setType(type);
                    String res = proxy.addUser(u);
                    response.sendRedirect("manage_users.jsp?task=add&uerror=" + res);
                }
            }
            else if (request.getParameter("btnDelete") != null) {
                if (request.getParameter("uid") != null) {
                    int uid = Integer.parseInt(request.getParameter("uid"));
                    String res = proxy.delete(uid,"user");
                    response.sendRedirect("view_users.jsp?uerror=" + res);
                }
            }
            else{
                response.sendRedirect("view_users.jsp");
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
