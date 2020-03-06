/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.presentationtier;

import com.mycompany.bussinesstier2.BussinessService;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admins
 */
@WebServlet(name = "ImageUpload", urlPatterns = {"/ImageUpload"})
public class ImageUpload extends HttpServlet {

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
            String pid = request.getParameter("pid");
            try {
                BussinessService proxy = BussinessServiceProxy.getProxy();
                String saveafile = new String();
                String contentType = request.getContentType();
                if ((contentType != null) && (contentType.contains("multipart/form-data"))) {

                    //getting the file
                    DataInputStream in = new DataInputStream(request.getInputStream());
                    int dataLength = request.getContentLength();
                    //

                    //convert into a byte array
                    byte dataB[] = new byte[dataLength];
                    int readBy = 0;
                    int totByRead = 0;

                    while (totByRead < dataLength) {
                        readBy = in.read(dataB, totByRead, dataLength);
                        totByRead += readBy;
                    }
                    //

                    //convert to string
                    String file = new String(dataB);
                    //

                    //getting the file name
                    saveafile = file.substring(file.indexOf("filename=\"") + 10);
                    saveafile = saveafile.substring(0, saveafile.indexOf("\n"));
                    saveafile = saveafile.substring(saveafile.lastIndexOf("\\") + 1, saveafile.indexOf("\""));
                    //---getting the file extinction----
                    saveafile = saveafile.substring(saveafile.lastIndexOf("."));
                    //

                    //getting the body of the file
                    int lastIndex = contentType.lastIndexOf("=");
                    String boundary = contentType.substring(lastIndex + 1, contentType.length());
                    int pos;
                    pos = file.indexOf("filename=\"");
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;
                    pos = file.indexOf("\n", pos) + 1;

                    int boudaryLocation = file.indexOf(boundary, pos) - 4;
                    int StartPos = (file.substring(0, pos).getBytes()).length;
                    int EndPos = (file.substring(0, boudaryLocation).getBytes()).length;
                    //

                    //save file
                    //String path = application.getRealPath("/");
                    saveafile = request.getRealPath("/") + "images\\products\\" + UUID.randomUUID() + saveafile;
                    //out.print(saveafile);
                    File ff = new File(saveafile);
                    try {
                        FileOutputStream fileout = new FileOutputStream(ff);
                        fileout.write(dataB, StartPos, (EndPos - StartPos));
                        fileout.flush();
                        fileout.close();
                    } catch (Exception e) {
                        System.out.print(e.getMessage());
                    }
                    String imagename = saveafile.substring(saveafile.lastIndexOf("images\\"));
                    String res = proxy.updateProductImage(Integer.parseInt(pid), imagename);
                    response.sendRedirect("manage_products.jsp?task=update&pid=" + pid + "&perror=" + res);
                }
            } catch (StringIndexOutOfBoundsException e) {
                response.sendRedirect("manage_products.jsp?task=update&pid=" + pid + "&perror=noImage");
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
