package com.devsecops;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/app")
public class App extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<h2>Welcome to Secure Web App</h2>");

        try {
            Connection conn = DriverManager.getConnection(
                "jdbc:postgresql://devsecops-db:5432/webapp", "adminuser", "SuperSecret123!"
            );

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT 'Hello from PostgreSQL!' as message");

            while (rs.next()) {
                out.println("<p>" + rs.getString("message") + "</p>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<p>Error connecting to the database: " + e.getMessage() + "</p>");
        }
    }
}
