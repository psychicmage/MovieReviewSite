<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil" %>
<%
    request.setCharacterEncoding("UTF-8");
    int id = Integer.parseInt(request.getParameter("id"));
    String password = request.getParameter("password");

    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);
    boolean loginSuccess = false;

    String username = null;

    try {
        String sql = "SELECT username FROM users WHERE user_id = ? AND password = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        pstmt.setString(2, password);
        ResultSet rs = pstmt.executeQuery();
        if (rs.next()) {
            username = rs.getString("username");
            loginSuccess = true;
        }
        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (loginSuccess) {
        session.setAttribute("userId", id);
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
