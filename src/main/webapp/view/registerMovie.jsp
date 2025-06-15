<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영화 등록</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

<div class="form-container">
    <div class="form-title">🎬 영화 등록</div>

    <!-- 영화 등록 입력 폼 -->
    <form action="../controller/registerMovieProcess.jsp" method="post">

        <!-- 제목 -->
        <div class="form-group">
            <label>제목</label>
            <input type="text" name="title" required>
        </div>

        <!-- 개봉일 -->
        <div class="form-group">
            <label>개봉일</label>
            <input type="date" name="releaseDate" required>
        </div>

        <!-- 줄거리 -->
        <div class="form-group">
            <label>줄거리</label>
            <textarea name="overview" rows="3" required></textarea>
        </div>

        <!-- 감독 -->
        <div class="form-group">
            <label>감독</label>
            <input type="text" name="director">
        </div>

        <!-- 주연 배우 -->
        <div class="form-group">
            <label>주연 배우</label>
            <input type="text" name="mainCast">
        </div>

        <!-- 장르 -->
        <div class="form-group">
            <label>장르 (쉼표 구분)</label>
            <input type="text" name="genres">
        </div>

        <!-- 키워드 -->
        <div class="form-group">
            <label>키워드 (쉼표 구분)</label>
            <input type="text" name="keywordList">
        </div>

        <!-- 버튼 영역 -->
        <div class="button-row">
            <button type="submit" class="ButtonAreaButton1">등록</button>
            <a href="admin.jsp" class="ButtonAreaButton2">취소</a>
        </div>

    </form>
</div>

</body>
</html>
