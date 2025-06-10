<%@ page import="java.sql.*, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    int id = Integer.parseInt(request.getParameter("id"));
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String email = request.getParameter("email");

    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);

    boolean success = false;

    try {
        // 중복 아이디 확인
        String checkSql = "SELECT COUNT(*) FROM users WHERE user_id = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setInt(1, id);
        ResultSet rs = checkStmt.executeQuery();
        rs.next();
        int count = rs.getInt(1);
        rs.close();
        checkStmt.close();

        if (count == 0) {
            // INSERT (이메일 포함)
            String insertSql = "INSERT INTO users (user_id, password, username, email, created_at) VALUES (?, ?, ?, ?, datetime('now'))";
            PreparedStatement insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setInt(1, id);
            insertStmt.setString(2, password);
            insertStmt.setString(3, name);
            insertStmt.setString(4, email);
            insertStmt.executeUpdate();
            insertStmt.close();

            // 로그인 상태 유지
            session.setAttribute("userId", id);
            session.setAttribute("username", name);
            session.setAttribute("email", email);
            success = true;
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (success) {
        response.sendRedirect("main.jsp");
    } else {
%>
    <script>
        alert("이미 존재하는 아이디입니다.");
        history.back();
    </script>
<%
    }
%>
