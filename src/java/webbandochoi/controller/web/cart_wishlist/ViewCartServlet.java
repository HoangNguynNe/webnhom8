/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package webbandochoi.controller.web.cart_wishlist;

import webbandochoi.dal.OrderDAO;
import webbandochoi.dal.ProductDAO;
import webbandochoi.dal.WalletDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import webbandochoi.model.Cart;
import webbandochoi.model.Email;
import webbandochoi.model.Item;
import webbandochoi.model.Order;
import webbandochoi.model.User;
import webbandochoi.model.Wallet;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ViewCartServlet", urlPatterns = {"/viewcart"})
public class ViewCartServlet extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewCartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewCartServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        HttpSession session = request.getSession();
        // Phan cart
        Cart cart = null;
        Object o = session.getAttribute("cart");
        // Check
        if (o != null) {
            cart = (Cart) o;
        } else {
            cart = new Cart();
        }
        String tRid = request.getParameter("rid");
        int rid;
        try {

            rid = Integer.parseInt(tRid);
            cart.removeItem(rid);
        } catch (Exception e) {
        }
        List<Item> list = cart.getListItems();
        session.setAttribute("cart", cart);
        session.setAttribute("listItemsInCart", list);
        session.setAttribute("cartSize", list.size());

        //
        request.getRequestDispatcher("viewcart.jsp").forward(request, response);
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
    HttpSession session = request.getSession();
    Cart cart = (Cart) session.getAttribute("cart");
    User user = (User) session.getAttribute("account");
    Wallet wallet = (Wallet) session.getAttribute("wallet");

    // Check if wallet is null and initialize it if needed
    if (wallet == null && user != null) {
        WalletDAO wd = new WalletDAO();
        wallet = wd.getWalletByUserName(user.getUserName());
        session.setAttribute("wallet", wallet);
    }

    // Ensure wallet is not null before proceeding
    if (wallet == null) {
        request.setAttribute("message1", "Order Fail");
        request.setAttribute("message2", "Failed to retrieve wallet information");
        request.getRequestDispatcher("viewcart.jsp").forward(request, response);
        return;
    }

    OrderDAO od = new OrderDAO();
    ProductDAO pd = new ProductDAO();
    WalletDAO wd = new WalletDAO();
    double amount = wallet.getBalance();
    double totalCart = cart.getTotalMoney();
    String msg1 = "";
    String msg2 = "";

    // Check if there are no previous orders
    int numberOfOrders = od.getNumberOrders();
    if (numberOfOrders == 0) {
        msg1 = "Order Fail";
        msg2 = "There are no previous orders.";
        request.setAttribute("message1", msg1);
        request.setAttribute("message2", msg2);
        request.getRequestDispatcher("viewcart.jsp").forward(request, response);
        return;
    }

    if (amount < totalCart) {
        msg1 = "Order Fail";
        msg2 = "The balance in the account is not enough to make this transaction";
        request.setAttribute("message1", msg1);
        request.setAttribute("message2", msg2);
        request.getRequestDispatcher("viewcart.jsp").forward(request, response);
    } else {
        // So luong orders ban dau
        int pre = od.getNumberOrders();

        // add Order
        od.addOrder(user, cart);
        LocalDateTime currentDateTime = LocalDateTime.now();
        // So luong orders tiep theo
        int after = od.getNumberOrders();

        if (pre < after) {
            msg1 = "Order Success";
            Email handleEmail = new Email();
            String sub = handleEmail.subjectOrder(user.getFullName());
            String msg = handleEmail.messageOrder(currentDateTime, totalCart, user.getAddress());
            handleEmail.sendEmail(sub, msg, user.getEmail());

            wd.decuctionMoney(user.getUserName(), totalCart);
            wallet = wd.getWalletByUserName(user.getUserName());
            session.removeAttribute("cart");
        } else {
            msg1 = "Order Fail";
            msg2 = "Check your network status again";
        }
        session.setAttribute("wallet", wallet);
        request.setAttribute("message1", msg1);
        request.setAttribute("message2", msg2);
        request.getRequestDispatcher("viewcart.jsp").forward(request, response);
    }
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
