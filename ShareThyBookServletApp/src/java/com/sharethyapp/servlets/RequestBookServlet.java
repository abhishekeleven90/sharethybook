/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sharethyapp.servlets;

import com.sharethyapp.dbclasses.RateAndReviewDB;
import com.sharethyapp.dbclasses.TransactionDB;
import com.sharethyapp.helper.RateAndReview;
import com.sharethyapp.helper.UtilitiesHelper;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author reshma
 */
public class RequestBookServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
   try {
 
        String ownerId=request.getSession().getAttribute("entrynumber").toString();
        String holderId=request.getParameter("hid");
        long bookId=Long.parseLong(request.getParameter("bookID"));
        String isbn=request.getParameter("ISBN");
      
        String res = new TransactionDB().startTransaction(ownerId,holderId,bookId);

        if (res.equals("true")) {
            request.setAttribute("infoMsg", "Book requested successfully.");
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/viewbook.do?isbn="
                    + isbn);
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("error", "Error occurred while requesting book. <br> " + res);
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/viewbook.do?isbn="
                    + isbn);
            dispatcher.forward(request, response);
        }
        } finally {

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
