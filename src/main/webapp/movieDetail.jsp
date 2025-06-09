<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.List" %>
<%@ page import="model.util.DBUtil" %>
<%@ page import="model.dao.MovieDAO, model.dao.ReviewDAO" %>
<%@ page import="model.dto.MovieDTO, model.dto.ReviewDTO" %>

<%
    request.setCharacterEncoding("UTF-8");

    int movieId = Integer.parseInt(request.getParameter("movieId"));
    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);

    MovieDTO movie = MovieDAO.findById(movieId, conn);
    List<ReviewDTO> reviews = ReviewDAO.findByMovie(movieId, conn);

    if (conn != null) conn.close();

    // 키워드 해시태그 처리
    String keywords = movie.getKeywordList();
    String hashtagString = "";
    if (keywords != null && !keywords.isEmpty()) {
        String[] keywordArr = keywords.split(",");
        for (String k : keywordArr) {
            hashtagString += "#" + k.trim() + " ";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= movie.getTitle() %> - 상세정보</title>
    <style>
        body { font-family: Arial, sans-serif; }
        pre {
            background-color: #f8f8f8;
            padding: 12px;
            border: 1px solid #ccc;
            width: 60%;
        }
        .review { margin-bottom: 1em; }
    </style>
</head>
<body>
    <h2>🎬 영화 상세 정보</h2>
	<div>
        <img src="posters/<%= movie.getMovieId() %>.jpg"
             alt="영화 포스터"
             width="200"
             onerror="this.onerror=null; this.src='posters/default.jpg';">
    </div>
    
    <pre>
제목       : <%= movie.getTitle() %>
개봉일     : <%= movie.getReleaseDate() %>
감독       : <%= movie.getDirector() != null ? movie.getDirector() : "정보 없음" %>
주연       : <%= movie.getMainCast() != null ? movie.getMainCast() : "정보 없음" %>
키워드     : <%= !hashtagString.isEmpty() ? hashtagString : "정보 없음" %>
줄거리     : <%= movie.getOverview() != null ? movie.getOverview() : "정보 없음" %>
평균 평점 : <%= String.format("%.1f", movie.getAverageRating()) %>
    </pre>

    <hr>
    <h3>📝 리뷰 목록</h3>
    <% if (reviews.isEmpty()) { %>
        <p>등록된 리뷰가 없습니다.</p>
    <% } else { %>
        <% for (ReviewDTO r : reviews) { %>
            <div class="review">
                👤 <strong><%= r.getUsername() %></strong><br>
                ⭐ <%= r.getRating() %>점<br>
                "<%= r.getReview() %>"<br>
                🕓 <%= r.getReviewDate() %>
            </div>
        <% } %>
    <% } %>

    <hr>
    <% if (session.getAttribute("userId") != null) { %>
        <a href="reviewForm.jsp?movieId=<%= movie.getMovieId() %>">✍ 리뷰 작성</a>
    <% } else { %>
        <p><a href="login.jsp">로그인</a> 후 리뷰를 작성할 수 있습니다.</p>
    <% } %>

    <br><br>
    <a href="main.jsp">← 메인으로 돌아가기</a>
</body>
</html>
