<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.dao.UserDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    int userId = (int) session.getAttribute("userId");
    String newEmail = request.getParameter("newEmail");
    String currentPassword = request.getParameter("currentPassword");

    boolean success = UserDAO.updateEmail(userId, newEmail, currentPassword);

    if (success) {
        session.setAttribute("email", newEmail);
        response.sendRedirect("../controller/mypage.jsp");
    } else {
%>
    <script>
        alert("❌ 이메일 변경 실패: 비밀번호가 틀렸거나 오류 발생");
        history.back();
    </script>
<%
    }
%>
