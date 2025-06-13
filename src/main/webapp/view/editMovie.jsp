<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.dto.MovieDTO, model.util.DBUtil, model.dao.MovieDAO" %>
<%
request.setCharacterEncoding("UTF-8");
int movieId = Integer.parseInt(request.getParameter("movieId"));

String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
MovieDTO movie = null;

try (Connection conn = DBUtil.getConnection(dbPath)) {
    movie = MovieDAO.findById(movieId, conn);
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화 수정</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="container">
    <h2>🎬 영화 정보 수정</h2>

    <form action="../controller/editMovieAction.jsp" method="post">
        <input type="hidden" name="movieId" value="<%= movie.getMovieId() %>">

        <label>제목:</label><br>
        <input type="text" name="title" value="<%= movie.getTitle() %>" required><br><br>

        <label>개봉일:</label><br>
        <input type="text" name="releaseDate" value="<%= movie.getReleaseDate() %>" required><br><br>

        <label>줄거리:</label><br>
        <textarea name="overview" rows="4" cols="50"><%= movie.getOverview() %></textarea><br><br>

        <label>감독:</label><br>
        <input type="text" name="director" value="<%= movie.getDirector() %>" required><br><br>

        <label>주연 배우:</label><br>
        <input type="text" name="mainCast" value="<%= movie.getMainCast() %>" required><br><br>

        <label>장르 (쉼표로 구분):</label><br>
        <input type="text" name="genres" value="<%= movie.getGenres() %>" required><br><br>

        <label>키워드:</label><br>
        <input type="text" name="keywordList" value="<%= movie.getKeywordList() %>" required><br><br>

        <button type="submit">수정 완료</button>
        <a href="admin.jsp"><button type="button">취소</button></a>
    </form>
</div>
</body>
</html>
