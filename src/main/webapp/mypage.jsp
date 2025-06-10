<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.dao.UserDAO, model.dto.UserDTO" %>
<%
    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    int userId = (int) session.getAttribute("userId");
    UserDTO user = UserDAO.findById(userId, dbPath);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="main">
        <h2 style="text-align: center;">👤 내 정보</h2>

        <% if (user != null) { %>
            <p><strong>이름:</strong> <%= user.getUsername() %></p>
            <p><strong>이메일:</strong> <%= user.getEmail() %></p>
            <p><strong>아이디:</strong> <%= user.getUserId() %></p>

            <div style="margin-top: 30px;">
                <a href="editProfile.jsp"><button class="ButtonAreaButton1">정보 수정</button></a>
                <a href="deleteAccount.jsp"><button class="ButtonAreaButton2">회원 탈퇴</button></a>
            </div>
        <% } else { %>
            <p>❌ 로그인 정보가 없습니다.</p>
        <% } %>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
