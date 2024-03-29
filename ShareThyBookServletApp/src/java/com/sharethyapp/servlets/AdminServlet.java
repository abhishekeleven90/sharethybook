/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sharethyapp.servlets;

import com.sharethyapp.dbclasses.TransactionDB;
import com.sharethyapp.dbclasses.WishListDB;
import com.sharethyapp.helper.TransactionHistory;
import com.sharethyapp.helper.UtilitiesHelper;
import com.sharethyapp.helper.WishList;
import com.sharethyapp.helper.WishListAggregated;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.Utilities;

/**
 *
 * @author reshma
 */
public class AdminServlet extends HttpServlet {

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

        String type = UtilitiesHelper.returnNullOrString(request, "type");
        if (type != null) {

            if (type.equals("W")) {
                List<WishListAggregated> wishlist = new WishListDB().getAllWishesAggregated();
                List<WishList> wishlistall = new WishListDB().getAllWishes();
                request.setAttribute("wish", wishlist);
                request.setAttribute("wishall", wishlistall);
            } else if (type.equals("C")) {
                List<TransactionHistory> canceled = new TransactionDB().getTxnsWithStatus("C");
                request.setAttribute("canceled", canceled);
            } else if (type.equals("P")) {
                List<TransactionHistory> pending = new TransactionDB().getPendingTxns();
                request.setAttribute("pending", pending);
            } else if (type.equals("E")) {
                List<TransactionHistory> ended = new TransactionDB().getTxnsWithStatus("E");
                request.setAttribute("ended", ended);
            }

        }
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/adminDash.jsp");
        dispatcher.forward(request, response);
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
