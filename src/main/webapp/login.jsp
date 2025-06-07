<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.dao.UserDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String password = request.getParameter("password");

            String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
            boolean success = UserDAO.login(userId, password, dbPath);

            if (success) {
                session.setAttribute("userId", userId);
                response.sendRedirect("main.jsp");
                return;
            } else {
                message = "❌ 로그인 실패! 아이디 또는 비밀번호를 확인하세요.";
            }
        } catch (Exception e) {
            message = "❌ 잘못된 입력입니다.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
</head>
<body>
    <h2>🔐 로그인</h2>
    <form method="post">
        <label>아이디 (숫자): <input type="number" name="userId" required></label><br><br>
        <label>비밀번호: <input type="password" name="password" required></label><br><br>
        <button type="submit">로그인</button>
    </form>
    <% if (!message.isEmpty()) { %>
        <p style="color:red;"><%= message %></p>
    <% } %>
    <br>
    <a href="main.jsp">← 메인으로</a>
</body>
</html>
