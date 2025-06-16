<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.dto.MovieDTO" %>

<%
    MovieDTO movie = (MovieDTO) request.getAttribute("movie");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>영화 정보 수정</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<div class="form-container">
    <div class="form-title">영화 정보 수정</div>

    <!-- 영화 정보 수정 폼 -->
    <form action="../controller/editMovieProcess.jsp" method="post">
        <!-- movieId는 hidden 필드로 전달 -->
        <input type="hidden" name="movieId" value="<%= movie.getMovieId() %>">

        <!-- 제목 -->
        <div class="form-group">
            <label>제목</label>
            <input type="text" name="title" value="<%= movie.getTitle() %>" required>
        </div>

        <!-- 개봉일 -->
        <div class="form-group">
            <label>개봉일</label>
            <input type="date" name="releaseDate" value="<%= movie.getReleaseDate() %>" required>
        </div>

        <!-- 줄거리 -->
        <div class="form-group">
            <label>줄거리</label>
            <textarea name="overview" rows="3" required><%= movie.getOverview() != null ? movie.getOverview() : "" %></textarea>
        </div>

        <!-- 감독 -->
        <div class="form-group">
            <label>감독</label>
            <input type="text" name="director" value="<%= movie.getDirector() %>">
        </div>

        <!-- 주연 배우 -->
        <div class="form-group">
            <label>주연 배우</label>
            <input type="text" name="mainCast" value="<%= movie.getMainCast() %>">
        </div>

        <!-- 장르 -->
        <div class="form-group">
            <label>장르 (쉼표 구분)</label>
            <input type="text" name="genres" value="<%= movie.getGenres() %>">
        </div>

        <!-- 키워드 -->
        <div class="form-group">
            <label>키워드 (쉼표 구분)</label>
            <input type="text" name="keywordList" value="<%= movie.getKeywordList() %>">
        </div>

        <!-- 버튼 영역 -->
        <div class="button-row">
            <button type="submit" class="ButtonAreaButton1">저장</button>
            <a href="../view/admin.jsp" class="ButtonAreaButton2">취소</a>
        </div>
    </form>
</div>

</body>
</html>
