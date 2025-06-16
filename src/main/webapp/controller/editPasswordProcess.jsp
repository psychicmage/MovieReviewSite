<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.dao.UserDAO" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 세션에서 로그인 사용자 ID 추출
    int userId = (int) session.getAttribute("userId");

    // 입력값: 현재 비밀번호와 새 비밀번호
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");

    // 비밀번호 변경 처리
    boolean success = UserDAO.updatePassword(userId, currentPassword, newPassword);

    if (success) {
        // 성공 시 마이페이지로 이동
        response.sendRedirect("../controller/mypage.jsp");
    } else {
%>
    <!-- 실패 시 경고창 후 이전 페이지로 이동 -->
    <script>
        alert("❌ 비밀번호 변경 실패: 현재 비밀번호가 일치하지 않거나 오류 발생");
        history.back();
    </script>
<%
    }
%>
