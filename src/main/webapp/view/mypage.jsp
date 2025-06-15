<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.dto.UserDTO" %>

<%
    // 컨트롤러에서 전달된 사용자 정보
    UserDTO user = (UserDTO) request.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<div class="form-container">
    <div class="form-title">내 정보</div>

    <% if (user != null) { %>
        <!-- 사용자 정보 출력 -->
        <p><strong>회원번호:</strong> <%= user.getUserId() %></p>
        <p><strong>아이디:</strong> <%= user.getUsername() %></p>
        <p><strong>이메일:</strong> <%= user.getEmail() %></p>

        <!-- 수정 및 탈퇴 버튼 -->
        <div class="button-row" style="margin-top: 30px;">
            <a href="../view/editEmail.jsp">
                <button class="ButtonAreaButton1">이메일 변경</button>
            </a>
            <a href="../view/editPassword.jsp">
                <button class="ButtonAreaButton1">비밀번호 변경</button>
            </a>
            <a href="../view/deleteAccount.jsp">
                <button class="ButtonAreaButton2">회원 탈퇴</button>
            </a>
        </div>

    <% } else { %>
        <!-- 사용자 정보가 없을 경우 -->
        <p>❌ 로그인 정보가 없습니다.</p>
    <% } %>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
