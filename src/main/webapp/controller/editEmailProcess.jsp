<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.dao.UserDAO" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 세션에서 현재 로그인 사용자 ID 가져오기
    int userId = (int) session.getAttribute("userId");

    // 입력값 받기
    String newEmail = request.getParameter("newEmail");
    String currentPassword = request.getParameter("currentPassword");

    // 비밀번호 확인 후 이메일 변경
    boolean success = UserDAO.updateEmail(userId, newEmail, currentPassword);

    if (success) {
        // 세션 정보 갱신 후 마이페이지로 이동
        session.setAttribute("email", newEmail);
        response.sendRedirect("../controller/mypage.jsp");
    } else {
%>
    <!-- 실패 시 알림 후 이전 페이지로 -->
    <script>
        alert("❌ 이메일 변경 실패: 비밀번호가 틀렸거나 오류 발생");
        history.back();
    </script>
<%
    }
%>
