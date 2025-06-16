<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

    <div class="form-container">
        <div class="form-title">회원가입</div>

        <!-- 회원가입 폼 -->
        <form action="../controller/registerProcess.jsp" method="post">
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" name="username" id="username" required>
            </div>

            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" name="email" id="email" required>
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" name="password" id="password" required>
            </div>

            <!-- 가입 및 로그인 이동 버튼 -->
            <div class="button-row">
                <button type="submit" class="ButtonAreaButton1">가입</button>
                <a href="login.jsp" class="ButtonAreaButton2">로그인</a>
            </div>
        </form>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>
