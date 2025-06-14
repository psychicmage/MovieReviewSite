<%@ page import="java.util.*, java.sql.*, model.util.DBUtil, model.dao.MovieDAO, model.dto.MovieDTO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);
    List<MovieDTO> movies = new ArrayList<>();

    String keyword = request.getParameter("keyword");
    String field = request.getParameter("field");
    String sortOption = request.getParameter("sort");

    if (keyword == null) keyword = "";
    if (field == null) field = "title";
    if (sortOption == null || sortOption.isBlank()) sortOption = "TITLE_ASC";

    if (keyword.isBlank()) {
        movies = MovieDAO.findAllSorted(conn, sortOption);
    } else {
        switch (field) {
            case "genre":
                movies = MovieDAO.searchByGenreSorted(conn, keyword, sortOption);
                break;
            case "keyword":
                movies = MovieDAO.searchByKeywordSorted(conn, keyword, sortOption);
                break;
            default:
                movies = MovieDAO.searchByTitleSorted(conn, keyword, sortOption);
                break;
        }
    }

    if (conn != null) conn.close();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>영화 검색</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="main">
    <!-- 🔍 검색/정렬 조건 영역 -->
    <div class="sort-bar" style="text-align: right; margin: 1rem 1rem 2rem;">
        <form method="get" action="searchMovie.jsp" style="display: inline-block;">
            <select name="field" style="padding: 5px 10px; font-size: 0.9rem;">
                <option value="title" <%= "title".equals(field) ? "selected" : "" %>>제목</option>
                <option value="genre" <%= "genre".equals(field) ? "selected" : "" %>>장르</option>
                <option value="keyword" <%= "keyword".equals(field) ? "selected" : "" %>>키워드</option>
            </select>

            <input type="text" name="keyword" value="<%= keyword %>" placeholder="검색어를 입력해주세요" style="padding: 5px; width: 200px;">

            <select name="sort" onchange="this.form.submit()" style="padding: 5px 10px; font-size: 0.9rem;">
                <option value="TITLE_ASC" <%= "TITLE_ASC".equals(sortOption) ? "selected" : "" %>>제목 오름차순</option>
                <option value="TITLE_DESC" <%= "TITLE_DESC".equals(sortOption) ? "selected" : "" %>>제목 내림차순</option>
                <option value="RATING_HIGH" <%= "RATING_HIGH".equals(sortOption) ? "selected" : "" %>>평점 높은순</option>
                <option value="RATING_LOW" <%= "RATING_LOW".equals(sortOption) ? "selected" : "" %>>평점 낮은순</option>
                <option value="REVIEW_COUNT_HIGH" <%= "REVIEW_COUNT_HIGH".equals(sortOption) ? "selected" : "" %>>리뷰 많은순</option>
                <option value="REVIEW_COUNT_LOW" <%= "REVIEW_COUNT_LOW".equals(sortOption) ? "selected" : "" %>>리뷰 적은순</option>
                <option value="RELEASE_DATE" <%= "RELEASE_DATE".equals(sortOption) ? "selected" : "" %>>최신 개봉일순</option>
            </select>

            <button type="submit" style="padding: 5px 10px;">검색</button>
        </form>
    </div>

    <!-- ✅ 검색 결과 -->
    <h1 style="text-align: center;">
        <%= keyword.isBlank() ? "전체 영화" : "검색 결과: '" + keyword + "'" %>
    </h1>

    <div class="row">
        <%
            if (movies.isEmpty()) {
        %>
            <p style="margin: 2rem auto;">❌ 검색 결과가 없습니다.</p>
        <%
            } else {
                for (MovieDTO m : movies) {
        %>
            <div class="card" onclick="location.href='movieDetail.jsp?movieId=<%= m.getMovieId() %>'">
                <div class="review-badge">
                    ⭐ <%= String.format("%.1f", m.getAverageRating()) %> (<%= m.getReviewCount() %>)
                </div>
                <img src="posters/<%= m.getMovieId() %>.jpg" alt="<%= m.getTitle() %>">
                <div class="card-content">
                    <h3><%= m.getTitle() %></h3>
                    <p>개봉일: <%= m.getReleaseDate() %></p>

                    <%-- 🔹 키워드 해시태그 표시 --%>
                    <%
                        if (m.getKeywordList() != null && !m.getKeywordList().isBlank()) {
                            String[] tags = m.getKeywordList().split(",");
                    %>
                        <div class="hashtags">
                            <%
                                for (String tag : tags) {
                            %>
                                <span class="hashtag">#<%= tag.trim().replace(" ", "_") %></span>
                            <%
                                }
                            %>
                        </div>
                    <%
                        }
                    %>
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
