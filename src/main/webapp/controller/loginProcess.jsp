<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.dao.UserDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    int userId = UserDAO.login(username, password);

    if (userId > 0) {
        session.setAttribute("userId", userId);
        session.setAttribute("username", username);
        response.sendRedirect("movieList.jsp"); // ✅ 로그인 성공 시 이동
    } else {
%>
    <script>
        alert("로그인 실패! 아이디 또는 비밀번호를 확인하세요.");
        history.back();
    </script>
<%
    }
%>
