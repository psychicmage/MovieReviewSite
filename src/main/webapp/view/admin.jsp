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

  <div class="admin-container">
    <div class="admin-title">👑 관리자 페이지</div>

    <div class="admin-section">
      <h3>🎬 영화 관리</h3>
      <div class="button-group">
        <a href="registerMovie.jsp"><button class="ButtonAreaButton1">영화 등록</button></a>
        <a href="../controller/searchMovie.jsp"><button class="ButtonAreaButton1">영화 수정</button></a>
        <a href="../controller/searchMovie.jsp"><button class="ButtonAreaButton2">영화 삭제</button></a>
      </div>
    </div>

    <div class="admin-section">
      <h3>📝 리뷰 관리</h3>
      <div class="button-group">
        <a href="../controller/searchMovie.jsp"><button class="ButtonAreaButton1">리뷰 삭제</button></a>
      </div>
    </div>

    <div class="admin-section">
      <h3>👥 사용자 관리</h3>
      <div class="button-group">
        <a href="../controller/manageUsers.jsp"><button class="ButtonAreaButton1">사용자 목록 및 삭제</button></a>
      </div>
    </div>
  </div>

  <%@ include file="footer.jsp" %>
</body>
</html>
