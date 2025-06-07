<%@ page import="java.util.*, java.sql.*, model.util.DBUtil, model.dao.MovieDAO, model.dto.MovieDTO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);
    List<MovieDTO> movies = MovieDAO.findAll(conn);
    if (conn != null) conn.close();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화 메인 페이지</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { border-collapse: collapse; width: 80%; }
        th, td { border: 1px solid #444; padding: 8px; text-align: left; }
        th { background-color: #f0f0f0; }
        a { text-decoration: none; color: #0066cc; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h1>🎬 영화 목록</h1>

    <table>
        <tr>
            <th>영화 제목</th>
            <th>개봉일</th>
            <th>평점</th>
        </tr>
        <%
            for (MovieDTO m : movies) {
        %>
        <tr>
            <td><a href="movieDetail.jsp?movieId=<%= m.getMovieId() %>"><%= m.getTitle() %></a></td>
            <td><%= m.getReleaseDate() %></td>
            <td><%= String.format("%.1f", m.getAverageRating()) %></td>
        </tr>
        <%
            }
        %>
    </table>

    <br>
    <a href="login.jsp">🔐 로그인</a> | <a href="register.jsp">📝 회원가입</a>
</body>
</html>
