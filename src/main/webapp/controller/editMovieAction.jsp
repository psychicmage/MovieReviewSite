<%@ page import="java.sql.*, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
request.setCharacterEncoding("UTF-8");

int movieId = Integer.parseInt(request.getParameter("movieId"));
String title = request.getParameter("title");
String releaseDate = request.getParameter("releaseDate");
String overview = request.getParameter("overview");
String director = request.getParameter("director");
String mainCast = request.getParameter("mainCast");
String genres = request.getParameter("genres");
String keywordList = request.getParameter("keywordList");

String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
boolean success = false;

try (Connection conn = DBUtil.getConnection(dbPath)) {
    // 1. movies
    String updateMovies = "UPDATE movies SET title = ?, release_date = ?, overview = ? WHERE movie_id = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(updateMovies)) {
        pstmt.setString(1, title);
        pstmt.setString(2, releaseDate);
        pstmt.setString(3, overview);
        pstmt.setInt(4, movieId);
        pstmt.executeUpdate();
    }

    // 2. credits
    String updateCredits = "UPDATE credits SET director = ?, main_cast = ? WHERE movie_id = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(updateCredits)) {
        pstmt.setString(1, director);
        pstmt.setString(2, mainCast);
        pstmt.setInt(3, movieId);
        pstmt.executeUpdate();
    }

    // 3. keywords
    String updateKeywords = "UPDATE keywords SET keyword_list = ? WHERE movie_id = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(updateKeywords)) {
        pstmt.setString(1, keywordList);
        pstmt.setInt(2, movieId);
        pstmt.executeUpdate();
    }

    // 4. genres 삭제 후 재삽입
    String deleteGenres = "DELETE FROM movie_genres WHERE movie_id = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(deleteGenres)) {
        pstmt.setInt(1, movieId);
        pstmt.executeUpdate();
    }

    String[] genreArray = (genres != null ? genres : "").split(",");
    for (String g : genreArray) {
        String genreName = g.trim();
        if (genreName.isEmpty()) continue;

        int genreId = -1;

        String checkSql = "SELECT genre_id FROM genres WHERE name = ?";
        try (PreparedStatement check = conn.prepareStatement(checkSql)) {
            check.setString(1, genreName);
            ResultSet rs = check.executeQuery();
            if (rs.next()) {
                genreId = rs.getInt(1);
            } else {
                String insertGenre = "INSERT INTO genres (name) VALUES (?)";
                try (PreparedStatement ins = conn.prepareStatement(insertGenre, Statement.RETURN_GENERATED_KEYS)) {
                    ins.setString(1, genreName);
                    ins.executeUpdate();
                    ResultSet genKey = ins.getGeneratedKeys();
                    if (genKey.next()) genreId = genKey.getInt(1);
                    genKey.close();
                }
            }
            rs.close();
        }

        if (genreId > 0) {
            String insertRel = "INSERT INTO movie_genres (movie_id, genre_id) VALUES (?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(insertRel)) {
                pstmt.setInt(1, movieId);
                pstmt.setInt(2, genreId);
                pstmt.executeUpdate();
            }
        }
    }

    success = true;

} catch (Exception e) {
    e.printStackTrace();
}
%>

<script>
    alert('<%= success ? "✅ 영화 정보가 수정되었습니다." : "❌ 수정 실패" %>');
    location.href = "../view/admin.jsp";
</script>
