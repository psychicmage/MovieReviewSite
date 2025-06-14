<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, model.dto.MovieDTO" %>
<%
List<MovieDTO> movies = (List<MovieDTO>) request.getAttribute("movies");
String selectedSort = request.getParameter("sort") == null ? "" : request.getParameter("sort");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화 삭제</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="container">
    <h2>🎬 영화 삭제</h2>

    <form method="get" action="deleteMovie.jsp">
        <label for="sort">정렬 기준:</label>
        <select name="sort" id="sort" onchange="this.form.submit()">
            <option value="">-- 선택 --</option>
            <option value="TITLE_DESC" <%= "TITLE_DESC".equals(selectedSort) ? "selected" : "" %>>제목 ↓</option>
            <option value="RATING_HIGH" <%= "RATING_HIGH".equals(selectedSort) ? "selected" : "" %>>평점 높은 순</option>
            <option value="RATING_LOW" <%= "RATING_LOW".equals(selectedSort) ? "selected" : "" %>>평점 낮은 순</option>
            <option value="REVIEW_COUNT_HIGH" <%= "REVIEW_COUNT_HIGH".equals(selectedSort) ? "selected" : "" %>>리뷰 많은 순</option>
            <option value="REVIEW_COUNT_LOW" <%= "REVIEW_COUNT_LOW".equals(selectedSort) ? "selected" : "" %>>리뷰 적은 순</option>
            <option value="RELEASE_DATE" <%= "RELEASE_DATE".equals(selectedSort) ? "selected" : "" %>>최신 개봉일 순</option>
        </select>
    </form>

    <table border="1" width="100%" style="margin-top: 10px;">
        <tr>
            <th>ID</th>
            <th>제목</th>
            <th>개봉일</th>
            <th>평균 평점</th>
            <th>삭제</th>
        </tr>
        <% for (MovieDTO m : movies) { %>
        <tr>
            <td><%= m.getMovieId() %></td>
            <td><%= m.getTitle() %></td>
            <td><%= m.getReleaseDate() %></td>
            <td><%= String.format("%.1f", m.getAverageRating()) %></td>
            <td>
                <a href="../controller/deleteMovieDeleteAction.jsp?movieId=<%= m.getMovieId() %>"
                   onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
            </td>
        </tr>
        <% } %>
    </table>
</div>

<div style="position: absolute; top: 10px; right: 10px;">
    <a href="../view/main.jsp">
        <button class="ButtonAreaButton1">IPP-6조</button>
    </a>
    <a href="../view/admin.jsp">
        <button class="ButtonAreaButton2">관리자 홈</button>
    </a>
</div>
</body>
</html>
