<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil" %>
<%
    request.setCharacterEncoding("UTF-8");

    int userId = (int) session.getAttribute("userId");
    String newEmail = request.getParameter("newEmail");
    String currentPassword = request.getParameter("currentPassword");

    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);
    boolean success = false;

    try {
        // 비밀번호 확인
        String checkSql = "SELECT * FROM users WHERE user_id = ? AND password = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setInt(1, userId);
        checkStmt.setString(2, currentPassword);
        ResultSet rs = checkStmt.executeQuery();

        if (rs.next()) {
            // 비밀번호 일치 시 이메일 업데이트
            String updateSql = "UPDATE users SET email = ? WHERE user_id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateSql);
            updateStmt.setString(1, newEmail);
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
        session.setAttribute("email", newEmail);  // 세션도 업데이트
        response.sendRedirect("mypage.jsp");
    } else {
%>
    <script>
        alert("❌ 이메일 변경 실패: 비밀번호가 틀렸거나 오류 발생");
        history.back();
    </script>
<%
    }
%>
