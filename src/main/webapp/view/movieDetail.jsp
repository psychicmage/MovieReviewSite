<%@ page import="java.util.*, java.sql.*, model.util.DBUtil, model.dao.MovieDAO, model.dao.ReviewDAO, model.dto.MovieDTO, model.dto.ReviewDTO" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    MovieDTO movie = (MovieDTO) request.getAttribute("movie");
    List<ReviewDTO> reviews = (List<ReviewDTO>) request.getAttribute("reviews");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title><%= movie.getTitle() %> - 상세 정보</title>
  <link rel="stylesheet" href="../css/style.css">
</head>
<body>
  <%@ include file="navbar.jsp" %>

  <div class="main">
    <h1 style="text-align: center;"><%= movie.getTitle() %></h1>

    <!-- 🎬 영화 기본 정보 -->
    <div class="movie-info-container">
      <div class="poster-box">
        <img src="../posters/<%= movie.getMovieId() %>.jpg" alt="<%= movie.getTitle() %>">
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

    <!-- 📝 사용자 리뷰 -->
    <div class="review-section">
      <h2 style="text-align: center;">📝 사용자 리뷰</h2>
      <div class="review-list">
        <% for (ReviewDTO r : reviews) { %>
          <div class="review-item">
            <div class="review-profile">👤</div>
            <div class="review-body">
              <div class="review-username">
                <%= r.getUsername() %>
                <span class="stars">
                  <% for (int i = 1; i <= 5; i++) { %>
                    <%= i <= r.getRating() ? "⭐" : "☆" %>
                  <% } %>
                </span>
              </div>
              <div class="review-text"><%= r.getReview() %></div>
            </div>
          </div>
        <% } %>
      </div>
    </div>
  </div>
<%
  Object userIdObj = session.getAttribute("userId");
  if (userIdObj != null) {
%>
  <div class="review-form" style="margin-top: 50px;">
    <h3>🖊 리뷰 작성</h3>
    <form action="../controller/writeReviewProcess.jsp" method="post">
      <input type="hidden" name="movieId" value="<%= movie.getMovieId() %>">
      <textarea name="reviewText" rows="4" style="width: 100%;" placeholder="리뷰를 입력하세요." required></textarea>
      <br><br>
      <label for="rating">평점:</label>
      <select name="rating" required>
        <option value="5">5점</option>
        <option value="4">4점</option>
        <option value="3">3점</option>
        <option value="2">2점</option>
        <option value="1">1점</option>
      </select>
      <br><br>
      <button type="submit" class="ButtonAreaButton1">등록</button>
    </form>
  </div>
<% } else { %>
  <p>✋ 리뷰 작성은 <a href="login.jsp">로그인</a> 후 가능합니다.</p>
<% } %>

  <%@ include file="footer.jsp" %>
</body>
</html>
