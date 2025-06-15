<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.dao.UserDAO" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 입력받은 아이디와 비밀번호 추출
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // 로그인 시도 (일치하면 userId 반환, 실패 시 -1)
    int userId = UserDAO.login(username, password);

    if (userId > 0) {
        // 로그인 성공: 세션에 사용자 정보 저장 후 메인 페이지로 이동
        session.setAttribute("userId", userId);
        session.setAttribute("username", username);
        response.sendRedirect("movieList.jsp");
    } else {
%>
    <!-- 로그인 실패 시 경고창 띄우고 이전 페이지로 이동 -->
    <script>
        alert("로그인 실패! 아이디 또는 비밀번호를 확인하세요.");
        history.back();
    </script>
<%
    }
%>
