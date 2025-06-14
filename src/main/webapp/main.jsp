<%@ page import="model.util.DBUtil" %>
<%@ page import="model.dao.MovieDAO" %>
<%@ page import="model.dto.MovieDTO" %>
<%@ page import="java.util.*, java.sql.*" %>

<%@ page contentType="text/html;charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);
    List<MovieDTO> movies = MovieDAO.findAll(conn);
    if (conn != null) conn.close();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>영화 리뷰 사이트</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <%@ include file="navbar.jsp" %>

  <div class="main">
    <h1 style="text-align: center;">Movie List</h1>

    <div class="row">
      <%
        if (movies.isEmpty()) {
      %>
        <p style="margin: 2rem auto;">❌ 등록된 영화가 없습니다.</p>
      <%
        } else {
          for (MovieDTO m : movies) {
      %>
        <div class="card" onclick="location.href='movieDetail.jsp?movieId=<%= m.getMovieId() %>'">
          <div class="review-badge">⭐ <%= String.format("%.1f", m.getAverageRating()) %> (<%= m.getReviewCount() %>)</div>
          <img src="posters/<%= m.getMovieId() %>.jpg" alt="<%= m.getTitle() %>">
          <div class="card-content">
            <h3><%= m.getTitle() %></h3>
            <p>개봉일: <%= m.getReleaseDate() %></p>

            <% if (m.getKeywordList() != null && !m.getKeywordList().isBlank()) { 
                 String[] tags = m.getKeywordList().split(","); %>
              <div class="hashtags">
                <% for (String tag : tags) { %>
                  <span class="hashtag">#<%= tag.trim().replace(" ", "_") %></span>
                <% } %>
              </div>
            <% } %>
          </div>
        </div>
      <%
          }
        }
      %>
    </div>
  </div>

  <%@ include file="footer.jsp" %>
</body>
</html>
