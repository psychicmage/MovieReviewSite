<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil" %>
<%
    request.setCharacterEncoding("UTF-8");

    int userId = (int) session.getAttribute("userId");
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");

    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);
    boolean success = false;

    try {
        // 현재 비밀번호 확인
        String checkSql = "SELECT * FROM users WHERE user_id = ? AND password = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setInt(1, userId);
        checkStmt.setString(2, currentPassword);
        ResultSet rs = checkStmt.executeQuery();

        if (rs.next()) {
            // 비밀번호 일치 시 새 비밀번호로 업데이트
            String updateSql = "UPDATE users SET password = ? WHERE user_id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, newPassword);
            updateStmt.setInt(2, userId);
            int rows = updateStmt.executeUpdate();
            success = (rows > 0);
            updateStmt.close();
        }

        rs.close();
        checkStmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (success) {
        response.sendRedirect("mypage.jsp");
    } else {
%>
    <script>
        alert("❌ 비밀번호 변경 실패: 현재 비밀번호가 일치하지 않거나 오류 발생");
        history.back();
    </script>
<%
    }
%>
