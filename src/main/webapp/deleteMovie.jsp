<%@ page import="java.util.*, java.sql.*, model.dao.MovieDAO, model.dto.MovieDTO, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
Connection conn = DBUtil.getConnection(dbPath);
List<MovieDTO> movies = MovieDAO.findAll(conn);
conn.close();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화 삭제</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h2>🎬 영화 삭제</h2>
    <table border="1" width="100%">
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
                <a href="deleteMovieProcess.jsp?movieId=<%= m.getMovieId() %>" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
            </td>
        </tr>
        <% } %>
    </table>
</div>
<div style="position: absolute; top: 10px; right: 10px;">
    <a href="main.jsp">
        <button style="
            background-color: black;
            color: deeppink;
            border: 2px solid deeppink;
            padding: 8px 12px;
            margin-right: 10px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        ">IPP-6조</button>
    </a>

    <a href="admin.jsp">
        <button style="
            background-color: black;
            color: deeppink;
            border: 2px solid deeppink;
            padding: 8px 12px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        ">관리자 홈</button>
    </a>
</div>

</body>
</html>
