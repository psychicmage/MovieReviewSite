<%@ page import="java.util.*, java.sql.*, model.util.DBUtil, model.dao.MovieDAO, model.dto.MovieDTO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);
    List<MovieDTO> movies = MovieDAO.findAll(conn);
    if (conn != null) conn.close();

    Object userObj = session.getAttribute("userId");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>영화 리뷰 사이트</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

  <!-- ✅ 상단 헤더 -->
  <div class="header-wrapper">
    <div class="header">
      <div class="left-section">
        <div class="logo">IPP-6조</div>
        <div class="search">
          <input type="text" class="SearchBar" placeholder="영화 제목을 검색해주세요.">
        </div>
      </div>

      <div class="right-section">
        <% if (userObj == null) { %>
          <a href="login.jsp"><button class="ButtonAreaButton1">로그인</button></a>
          <a href="register.jsp"><button class="ButtonAreaButton2">회원가입</button></a>
        <% } else { %>
          <div class="dropdown">
            <button class="dropdown-btn">
              <%= session.getAttribute("username") %> ▼
            </button>
            <div class="dropdown-content">
              <a href="mypage.jsp">마이페이지</a>
              <a href="logout.jsp">로그아웃</a>
            </div>
          </div>
        <% } %>
      </div>
    </div>
  </div>

  <!-- ✅ 메인 영화 목록 영역 -->
  <div class="main">
    <h1 style="text-align: center;">Movie List</h1>
    <div class="row">
      <%
        for (MovieDTO m : movies) {
            int movieId = m.getMovieId();
      %>
      <div class="card" onclick="location.href='movieDetail.jsp?movieId=<%= movieId %>'">
        <img src="posters/<%= movieId %>.jpg" alt="<%= m.getTitle() %>">
        <div class="card-content">
          <h3><%= m.getTitle() %></h3>
          <p>개봉일: <%= m.getReleaseDate() %></p>
          <p>평점: <%= String.format("%.1f", m.getAverageRating()) %></p>
        </div>
      </div>
      <%
        }
      %>
    </div>
  </div>

</body>
</html>
