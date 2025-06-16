<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

    <div class="form-container">
        <div class="form-title">로그인</div>

        <!-- 로그인 입력 폼 -->
        <form action="../controller/loginProcess.jsp" method="post">
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" name="username" id="username" required>
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" name="password" id="password" required>
            </div>

            <div class="button-row">
                <!-- 로그인 버튼 -->
                <button type="submit" class="ButtonAreaButton1">로그인</button>

                <!-- 회원가입 페이지로 이동 -->
                <a href="register.jsp" class="ButtonAreaButton2">회원가입</a>
            </div>
        </form>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>
