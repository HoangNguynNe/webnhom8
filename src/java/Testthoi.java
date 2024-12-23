/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import webbandochoi.utils.DBContext;
import webbandochoi.dal.OrderDAO;
import webbandochoi.model.Order;
/**
 *
 * @author kirit
 */
import java.util.List;

public class Testthoi {
    public static void main(String[] args) {
        DBContext dbContext = new DBContext();
        if (dbContext.connection != null) {
            System.out.println("Database connection established successfully!");

            // Tạo một đối tượng OrderDAO
            OrderDAO orderDAO = new OrderDAO();

            // Gọi hàm getByName với một tên người dùng cụ thể
            String userName = "john_doe";  // Bạn có thể thay đổi tên người dùng này
            List<Order> orders = orderDAO.getByName(userName);

            // Kiểm tra và in danh sách đơn hàng
            if (orders != null && !orders.isEmpty()) {
                for (Order order : orders) {
                    System.out.println(order);
                }
            } else {
                System.out.println("No orders found for user: " + userName);
            }
        } else {
            System.err.println("Failed to establish database connection.");
        }
    }
}