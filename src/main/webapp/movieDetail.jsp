<%@ page import="java.util.*, java.sql.*, model.util.DBUtil, model.dao.MovieDAO, model.dao.ReviewDAO, model.dto.MovieDTO, model.dto.ReviewDTO" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    int movieId = Integer.parseInt(request.getParameter("movieId"));
    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);

    MovieDTO movie = MovieDAO.findById(movieId, conn);
    List<ReviewDTO> reviews = ReviewDAO.findByMovieId(movieId, conn);

    if (conn != null) conn.close();

    Object userObj = session.getAttribute("userId");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title><%= movie.getTitle() %> - 상세 정보</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>
  <div class="main">
    <h1 style="text-align: center;"><%= movie.getTitle() %></h1>

    <div class="movie-info-container">
      <div class="poster-box">
        <img src="posters/<%= movie.getMovieId() %>.jpg" alt="<%= movie.getTitle() %>">
      </div>
      <div class="info-box">
        <p><strong>개봉일:</strong> <%= movie.getReleaseDate() %></p>
        <p><strong>장르:</strong> <%= movie.getGenres() %></p>
        <p><strong>감독:</strong> <%= movie.getDirector() %></p>
        <p><strong>주연:</strong> <%= movie.getMainCast() %></p>
        <p><strong>줄거리:</strong><br><%= movie.getOverview() %></p>
        <p><strong>키워드:</strong> <%= movie.getKeywordList() %></p>
        <p><strong>평균 평점:</strong> ⭐ <%= String.format("%.1f", movie.getAverageRating()) %></p>
      </div>
    </div>

    <div class="review-section">
      <h2 style="text-align:center;">📝 리뷰</h2>
      <%
        for (ReviewDTO r : reviews) {
      %>
      <div class="review-simple">
        <p><strong>작성자:</strong> <%= r.getUserId() %>번 사용자</p>
        <p><strong>평점:</strong> ⭐ <%= r.getRating() %></p>
        <p><%= r.getReview() %></p>
      </div>
      <%
        }
      %>
    </div>
  </div>
  <%@ include file="footer.jsp" %>
</body>
</html>
