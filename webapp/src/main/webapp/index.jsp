<%@ page import="java.sql.*" %>
<html>
<head><title>DevSecOps WebApp</title></head>
<body>
    <h1>DevSecOps Web Application</h1>
    <p>Connecting to Database...</p>

    <%
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:postgresql://devsecops-db:5432/webapp", "adminuser", "SuperSecret123!"
            );

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT 'Hello, DevSecOps!' AS message");

            while (rs.next()) {
                out.println("<p>Database Message: " + rs.getString("message") + "</p>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>
