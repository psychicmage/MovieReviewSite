<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.dto.MovieDTO" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화 수정</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <h2>수정할 영화를 선택하세요</h2>
    <table border="1">
        <tr>
            <th>제목</th>
            <th>개봉일</th>
            <th>수정</th>
        </tr>
        <%
            List<MovieDTO> movies = (List<MovieDTO>) request.getAttribute("movies");
            for (MovieDTO m : movies) {
        %>
        <tr>
            <td><%= m.getTitle() %></td>
            <td><%= m.getReleaseDate() %></td>
            <td><a href="../controller/editMovieForm.jsp?movieId=<%= m.getMovieId() %>">수정</a></td>
        </tr>
        <% } %>
    </table>
</body>
</html>
