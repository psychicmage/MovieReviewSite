<%@ page import="model.dao.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // 요청 및 응답 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 현재 로그인된 사용자 ID와 입력한 비밀번호 가져오기
    int userId = (int) session.getAttribute("userId");
    String password = request.getParameter("password");

    // 비밀번호 검증
    boolean isValid = UserDAO.checkPassword(userId, password);

    if (!isValid) {
        // 비밀번호 불일치 시 알림 후 이전 페이지로 이동
        out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
        return;
    }

    // 사용자 탈퇴 시도
    boolean success = UserDAO.deleteUser(userId);

    if (success) {
        // 성공 시 세션 종료 후 메인 페이지로 이동
        session.invalidate();
        response.sendRedirect("movieList.jsp");
    } else {
        // 실패 시 알림 후 이전 페이지로 이동
        out.println("<script>alert('회원 탈퇴에 실패했습니다.'); history.back();</script>");
    }
%>
