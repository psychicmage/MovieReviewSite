<%@ page import="java.sql.*, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%
request.setCharacterEncoding("UTF-8");

String title = request.getParameter("title");
String releaseDate = request.getParameter("releaseDate");
String overview = request.getParameter("overview");
String director = request.getParameter("director");
String mainCast = request.getParameter("mainCast");
String genres = request.getParameter("genres");
String keywordList = request.getParameter("keywordList");

String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
Connection conn = DBUtil.getConnection(dbPath);

try {
    // 1. movies 테이블
    String insertMovie = "INSERT INTO movies (title, release_date, overview) VALUES (?, ?, ?)";
    PreparedStatement pstmt1 = conn.prepareStatement(insertMovie, Statement.RETURN_GENERATED_KEYS);
    pstmt1.setString(1, title);
    pstmt1.setString(2, releaseDate);
    pstmt1.setString(3, overview);
    pstmt1.executeUpdate();

    ResultSet rs = pstmt1.getGeneratedKeys();
    int movieId = -1;
    if (rs.next()) movieId = rs.getInt(1);
    rs.close();
    pstmt1.close();

    if (movieId > 0) {
        // 2. credits 테이블
        String insertCredits = "INSERT INTO credits (movie_id, director, main_cast) VALUES (?, ?, ?)";
        PreparedStatement pstmt2 = conn.prepareStatement(insertCredits);
        pstmt2.setInt(1, movieId);
        pstmt2.setString(2, director);
        pstmt2.setString(3, mainCast);
        pstmt2.executeUpdate();
        pstmt2.close();

        // 3. keywords 테이블
        String insertKeywords = "INSERT INTO keywords (movie_id, keyword_list) VALUES (?, ?)";
        PreparedStatement pstmt3 = conn.prepareStatement(insertKeywords);
        pstmt3.setInt(1, movieId);
        pstmt3.setString(2, keywordList);
        pstmt3.executeUpdate();
        pstmt3.close();

        // 4. genres 테이블 + movie_genres
        String[] genreArray = genres.split(",");
        for (String g : genreArray) {
            String genreName = g.trim();

            // genres 테이블에서 id 찾거나 삽입
            String selectGenre = "SELECT genre_id FROM genres WHERE name = ?";
            PreparedStatement checkGenre = conn.prepareStatement(selectGenre);
            checkGenre.setString(1, genreName);
            ResultSet genreRs = checkGenre.executeQuery();

            int genreId = -1;
            if (genreRs.next()) {
                genreId = genreRs.getInt("genre_id");
            } else {
                String insertGenre = "INSERT INTO genres (name) VALUES (?)";
                PreparedStatement insertGenreStmt = conn.prepareStatement(insertGenre, Statement.RETURN_GENERATED_KEYS);
                insertGenreStmt.setString(1, genreName);
                insertGenreStmt.executeUpdate();
                ResultSet newGenreRs = insertGenreStmt.getGeneratedKeys();
                if (newGenreRs.next()) genreId = newGenreRs.getInt(1);
                newGenreRs.close();
                insertGenreStmt.close();
            }

            genreRs.close();
            checkGenre.close();

            // movie_genres 연결
            if (genreId > 0) {
                String insertRelation = "INSERT INTO movie_genres (movie_id, genre_id) VALUES (?, ?)";
                PreparedStatement insertRel = conn.prepareStatement(insertRelation);
                insertRel.setInt(1, movieId);
                insertRel.setInt(2, genreId);
                insertRel.executeUpdate();
                insertRel.close();
            }
        }
    }

    conn.close();
%>
    <script>
        alert("✅ 영화 등록 완료!");
        location.href = "admin.jsp";
    </script>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
    <script>
        alert("❌ 등록 실패. 오류가 발생했습니다.");
        history.back();
    </script>
<%
}
%>
