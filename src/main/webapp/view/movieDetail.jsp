<%@ page import="java.util.*, java.sql.*, model.util.DBUtil, model.dao.MovieDAO, model.dao.ReviewDAO, model.dto.MovieDTO, model.dto.ReviewDTO" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // 컨트롤러에서 전달된 영화 및 리뷰 정보, 세션 정보 추출
    MovieDTO movie = (MovieDTO) request.getAttribute("movie");
    List<ReviewDTO> reviews = (List<ReviewDTO>) request.getAttribute("reviews");
    Object userIdObj = session.getAttribute("userId");
    Object usernameObj = session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title><%= movie.getTitle() %> - 상세 정보</title>

  <!-- 공통 스타일시트 -->
  <link rel="stylesheet" href="../css/style.css">

  <!-- 로컬 Font Awesome 아이콘 스타일 -->
  <link rel="stylesheet" href="../css/all.min.css">
</head>

<body>

<%@ include file="navbar.jsp" %> 

<div class="main">

  <!-- 🎬 영화 상세 정보 영역 -->
  <div class="movie-info-container">
    <!-- 🎞️ 포스터 영역 -->
    <div class="poster-box">
      <img src="../posters/<%= movie.getMovieId() %>.jpg" alt="<%= movie.getTitle() %>">
    </div>

    <!-- 📋 영화 기본 정보 영역 -->
    <div class="info-box">
      <!-- 제목 + 관리자만 보이는 수정/삭제 버튼 -->
      <div style="display: flex; justify-content: space-between; align-items: center;">
        <h2 style="margin-bottom: 5px;"><%= movie.getTitle() %></h2>

        <%-- 로그인된 사용자가 관리자일 경우 수정/삭제 버튼 표시 --%>
        <% if (userIdObj != null && (int) userIdObj == 1) { %>
          <div style="display: flex; gap: 10px;">
            <!-- 수정 버튼 -->
            <form action="editMovieForm.jsp" method="get" style="display:inline;">
              <input type="hidden" name="movieId" value="<%= movie.getMovieId() %>">
              <button type="submit" class="ButtonAreaButton1">수정</button>
            </form>
            <!-- 삭제 버튼 -->
            <form action="deleteMovieProcess.jsp" method="get" style="display:inline;" onsubmit="return confirm('정말 이 영화를 삭제하시겠습니까?')">
              <input type="hidden" name="movieId" value="<%= movie.getMovieId() %>">
              <button type="submit" class="ButtonAreaButton2">삭제</button>
            </form>
          </div>
        <% } %>
      </div>

      <!-- ⏱️ 개봉일 · ⭐ 평점 평균 표시 -->
      <div class="sub-meta">
        <span><%= movie.getReleaseDate() %></span> ·
        <span>⭐ <%= String.format("%.1f", movie.getAverageRating()) %> (<%= movie.getReviewCount() %>개)</span>
      </div>

      <!-- 영화 세부 정보 출력 -->
      <hr class="info-divider">
      <p><strong>줄거리:</strong><br><%= movie.getOverview() %></p>

      <hr class="info-divider">
      <p><strong>감독:</strong> <%= movie.getDirector() %></p>

      <hr class="info-divider">
      <p><strong>주연:</strong> <%= movie.getMainCast() %></p>

      <hr class="info-divider">
      <p><strong>장르:</strong> <%= movie.getGenres() %></p>

      <hr class="info-divider">

      <!-- 🔖 키워드 해시태그 -->
      <div class="hashtags">
        <%
          String[] keywords = movie.getKeywordList().split(",");
          for (String k : keywords) {
            k = k.trim();
            if (!k.isEmpty()) {
        %>
          <span class="hashtag">#<%= k %></span>
        <%
            }
          }
        %>
      </div>
    </div>
  </div>

  <!-- ✍ 리뷰 목록 + 작성 폼 영역 -->
  <div class="review-section">
    <h2 style="text-align: center;">사용자 리뷰</h2>

    <div class="review-list">
      <!-- 각 리뷰 반복 출력 -->
      <% for (ReviewDTO r : reviews) { %>
        <div class="review-item">
          <div class="review-profile">👤</div>
          <div class="review-body">
            <div class="review-username">
              <%= r.getUsername() %>

              <!-- 별점 출력 (0.5 단위) -->
              <span class="stars">
                <%
                  double rating = r.getRating();
                  for (int i = 1; i <= 5; i++) {
                    if (rating >= i) {
                      out.print("<i class='fas fa-star'></i>");
                    } else if (rating >= i - 0.5) {
                      out.print("<i class='fas fa-star-half-alt'></i>");
                    } else {
                      out.print("<i class='far fa-star'></i>");
                    }
                  }
                %>
              </span>

              <%-- 관리자만 리뷰 삭제 가능 --%>
              <% if (userIdObj != null && (int) userIdObj == 1) { %>
                <form action="deleteReviewProcess.jsp" method="post" style="display:inline; float:right;" onsubmit="return confirm('정말 이 리뷰를 삭제하시겠습니까?')">
                  <input type="hidden" name="reviewId" value="<%= r.getReviewId() %>">
                  <input type="hidden" name="movieId" value="<%= movie.getMovieId() %>">
                  <button type="submit" class="ButtonAreaButton2">삭제</button>
                </form>
              <% } %>
            </div>
            <div class="review-text"><%= r.getReview() %></div>
          </div>
        </div>
      <% } %>

      <!-- ✍ 로그인한 사용자만 리뷰 작성 가능 -->
      <% if (userIdObj != null && usernameObj != null) { %>
        <div class="review-item">
          <div class="review-profile">✍</div>
          <div class="review-body">
            <form action="writeReviewProcess.jsp" method="post">
              <input type="hidden" name="movieId" value="<%= movie.getMovieId() %>">

              <!-- 평점 입력 -->
              <div class="review-username">
                <%= usernameObj %> 님의 리뷰 작성
                <select name="rating" class="rating-select">
                  <% for (double i = 0.5; i <= 5.0; i += 0.5) { %>
                    <option value="<%= i %>"><%= i %>점</option>
                  <% } %>
                </select>
              </div>

              <!-- 리뷰 텍스트 입력 -->
              <textarea name="reviewText" rows="3" class="review-textarea" placeholder="리뷰를 입력해주세요." required></textarea>

              <!-- 제출 버튼 -->
              <div class="submit-btn-container">
                <button type="submit" class="submit-review-button">등록</button>
              </div>
            </form>
          </div>
        </div>
      <% } else { %>
        <!-- 비로그인 사용자에게 안내 메시지 -->
        <p style="margin-top: 20px;">✋ 리뷰 작성은 <a href="../view/login.jsp">로그인</a> 후 가능합니다.</p>
      <% } %>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
