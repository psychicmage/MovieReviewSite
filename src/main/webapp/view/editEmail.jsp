<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // 로그인 여부 확인 (비로그인 시 로그인 페이지로 이동)
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이메일 수정</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

    <%@ include file="navbar.jsp" %>

    <div class="form-container">
        <div class="form-title">이메일 수정</div>

        <!-- 이메일 수정 폼 -->
        <form action="../controller/editEmailProcess.jsp" method="post">
            <div class="form-group">
                <label for="newEmail">새 이메일</label>
                <input type="email" name="newEmail" id="newEmail" required>
            </div>

            <div class="form-group">
                <label for="currentPassword">현재 비밀번호</label>
                <input type="password" name="currentPassword" id="currentPassword" required>
            </div>

            <div class="button-row">
                <!-- 변경 버튼 -->
                <button type="submit" class="ButtonAreaButton1">이메일 변경</button>

                <!-- 취소 버튼 (마이페이지로 이동) -->
                <a href="../controller/mypage.jsp" class="ButtonAreaButton2" 
                   style="text-align: center; padding: 6px 12px; display: inline-block; line-height: 30px;">
                    취소
                </a>
            </div>
        </form>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>
