<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 페이지</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h2>👑 관리자 페이지</h2>

        <div class="admin-section">
            <h3>🎬 영화 관리</h3>
            <div class="button-group">
                <a href="registerMovie.jsp"><button class="ButtonAreaButton1">영화 등록</button></a>
                <a href="../controller/deleteMovie.jsp"><button class="ButtonAreaButton2">영화 삭제</button></a>
                <a href="../controller/editMovie.jsp"><button class="ButtonAreaButton1">영화 수정</button></a> <!-- ✅ 영화 수정 버튼 추가 -->
            </div>
        </div>

        <div class="admin-section">
            <h3>📝 리뷰 관리</h3>
            <a href="../controller/manageReviews.jsp"><button class="ButtonAreaButton1">리뷰 관리</button></a>
        </div>

        <div class="admin-section">
            <h3>👥 사용자 관리</h3>
            <a href="../controller/manageUsers.jsp"><button class="ButtonAreaButton1">사용자 목록 및 삭제</button></a>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
