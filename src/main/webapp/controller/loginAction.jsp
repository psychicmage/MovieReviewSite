<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil" %>
<%
    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);
    boolean loginSuccess = false;
	int userId = -1;

    try {
        String sql = "SELECT user_id FROM users WHERE username = ? AND password = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            userId = rs.getInt("user_id");
            loginSuccess = true;
        }
        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (loginSuccess) {
        session.setAttribute("userId", userId);
        session.setAttribute("username", username);
        response.sendRedirect("main.jsp");
    } else {
%>
    <script>
        alert("로그인 실패! 아이디 또는 비밀번호를 확인하세요.");
        history.back();
    </script>
<%
    }
%>
