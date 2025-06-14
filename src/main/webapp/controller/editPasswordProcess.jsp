<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.dao.UserDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    int userId = (int) session.getAttribute("userId");
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");

    boolean success = UserDAO.updatePassword(userId, currentPassword, newPassword);

    if (success) {
        response.sendRedirect("../controller/mypage.jsp");
    } else {
%>
    <script>
        alert("❌ 비밀번호 변경 실패: 현재 비밀번호가 일치하지 않거나 오류 발생");
        history.back();
    </script>
<%
    }
%>
