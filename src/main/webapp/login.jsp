<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="form-container">
        <div class="form-title">로그인</div>

        <form action="loginProcess.jsp" method="post">
            <div class="form-group">
                <label for="id">아이디 (숫자)</label>
                <input type="text" name="id" id="id" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" name="password" id="password" required>
            </div>

            <div class="button-row">
                <button type="submit" class="ButtonAreaButton1">로그인</button>
                <a href="register.jsp" class="ButtonAreaButton2" style="text-align: center; padding: 6px 12px; display: inline-block; line-height: 30px;">회원가입</a>
            </div>
        </form>
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>
