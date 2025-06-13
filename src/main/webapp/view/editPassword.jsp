<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 수정</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="form-container">
        <div class="form-title">비밀번호 변경</div>

        <form action="controller/editPasswordAction.jsp" method="post">
            <div class="form-group">
                <label for="currentPassword">현재 비밀번호</label>
                <input type="password" name="currentPassword" id="currentPassword" required>
            </div>

            <div class="form-group">
                <label for="newPassword">새 비밀번호</label>
                <input type="password" name="newPassword" id="newPassword" required>
            </div>

            <div class="button-row">
                <button type="submit" class="ButtonAreaButton1">변경</button>
                <a href="mypage.jsp" class="ButtonAreaButton2" style="text-align: center; padding: 6px 12px;">취소</a>
            </div>
        </form>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
