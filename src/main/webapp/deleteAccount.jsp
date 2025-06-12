<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Object userIdObj = session.getAttribute("userId");
    if (userIdObj == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 탈퇴</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="form-container">
    <div class="form-title">⚠ 회원 탈퇴</div>
    <p>정말로 탈퇴하시려면 비밀번호를 입력해주세요.</p>

    <form method="post" action="deleteAccountAction.jsp" style="margin-top: 30px;">
        <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="button-row">
            <button type="submit" class="ButtonAreaButton2">탈퇴</button>
            <a href="mypage.jsp"><button type="button" class="ButtonAreaButton1">취소</button></a>
        </div>
    </form>
</div>


<%@ include file="footer.jsp" %>
</body>
</html>
