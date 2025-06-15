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
    <title>비밀번호 수정</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

    <%@ include file="navbar.jsp" %>

    <div class="form-container">
        <div class="form-title">비밀번호 변경</div>

        <!-- 비밀번호 변경 폼 -->
        <form action="../controller/editPasswordProcess.jsp" method="post">
            <div class="form-group">
                <label for="currentPassword">현재 비밀번호</label>
                <input type="password" name="currentPassword" id="currentPassword" required>
            </div>

            <div class="form-group">
                <label for="newPassword">새 비밀번호</label>
                <input type="password" name="newPassword" id="newPassword" required>
            </div>

            <div class="button-row">
                <!-- 변경 버튼 -->
                <button type="submit" class="ButtonAreaButton1">변경</button>

                <!-- 취소 버튼 (마이페이지로 이동) -->
                <a href="../controller/mypage.jsp" class="ButtonAreaButton2" style="text-align: center; padding: 6px 12px;">
                    취소
                </a>
            </div>
        </form>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>
