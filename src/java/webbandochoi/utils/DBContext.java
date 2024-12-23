package webbandochoi.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    public Connection connection;
    
    public DBContext() {
        try {
            // Edit URL, username, password to authenticate with your MS SQL Server
            String url = "jdbc:sqlserver://localhost:1433;databaseName=BanDoChoi;encrypt=false";
            String username = "sa";
            String password = "10102004";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException ex) {
            System.err.println("Database Driver Class Not Found: " + ex.getMessage());
        } catch (SQLException ex) {
            System.err.println("Failed to Establish Database Connection: " + ex.getMessage());
        }
    }
    public Connection getConnection() {
        return connection;
    }
}

