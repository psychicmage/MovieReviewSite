<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.dao.UserDAO, model.dto.UserDTO" %>
<%
    request.setCharacterEncoding("UTF-8");
    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            UserDTO user = new UserDTO(userId, username, email, password);
            String dbPath = application.getRealPath("/WEB-INF/db/movies.db");

            boolean success = UserDAO.register(user, dbPath);

            if (success) {
                response.sendRedirect("login.jsp");
                return;
            } else {
                message = "❌ 회원가입 실패! 중복된 아이디일 수 있습니다.";
            }
        } catch (Exception e) {
            message = "❌ 입력값이 올바르지 않습니다.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
</head>
<body>
    <h2>📝 회원가입</h2>
    <form method="post">
        <label>아이디 (숫자): <input type="number" name="userId" required></label><br><br>
        <label>이름: <input type="text" name="username" required></label><br><br>
        <label>이메일: <input type="email" name="email" required></label><br><br>
        <label>비밀번호: <input type="password" name="password" required></label><br><br>
        <button type="submit">가입하기</button>
    </form>

    <% if (!message.isEmpty()) { %>
        <p style="color:red;"><%= message %></p>
    <% } %>

    <br>
    <a href="main.jsp">← 메인으로</a>
</body>
</html>
