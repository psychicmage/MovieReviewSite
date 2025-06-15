<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil" %>
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

    Connection conn = null;
    boolean success = false;

    try {
        conn = DBUtil.getConnection();

        // 1. movies 테이블 수정
        String updateMovie = "UPDATE movies SET title = ?, release_date = ?, overview = ? WHERE movie_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(updateMovie)) {
            pstmt.setString(1, title);
            pstmt.setString(2, releaseDate);
            pstmt.setString(3, overview);
            pstmt.setInt(4, movieId);
            pstmt.executeUpdate();
        }

        // 2. credits 테이블 수정
        String updateCredits = "UPDATE credits SET director = ?, main_cast = ? WHERE movie_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(updateCredits)) {
            pstmt.setString(1, director);
            pstmt.setString(2, mainCast);
            pstmt.setInt(3, movieId);
            pstmt.executeUpdate();
        }

        // 3. keywords 테이블 수정
        String updateKeywords = "UPDATE keywords SET keyword_list = ? WHERE movie_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(updateKeywords)) {
            pstmt.setString(1, keywordList);
            pstmt.setInt(2, movieId);
            pstmt.executeUpdate();
        }

        // 4. 기존 장르 삭제 후 다시 삽입
        String deleteGenres = "DELETE FROM movie_genres WHERE movie_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(deleteGenres)) {
            pstmt.setInt(1, movieId);
            pstmt.executeUpdate();
        }

        String[] genreArray = genres.split(",");
        for (String g : genreArray) {
            String genreName = g.trim();
            String selectGenre = "SELECT genre_id FROM genres WHERE name = ?";
            int genreId = -1;

            try (PreparedStatement checkStmt = conn.prepareStatement(selectGenre)) {
                checkStmt.setString(1, genreName);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    genreId = rs.getInt("genre_id");
                } else {
                    String insertGenre = "INSERT INTO genres (name) VALUES (?)";
                    try (PreparedStatement insertStmt = conn.prepareStatement(insertGenre, Statement.RETURN_GENERATED_KEYS)) {
                        insertStmt.setString(1, genreName);
                        insertStmt.executeUpdate();
                        ResultSet newRs = insertStmt.getGeneratedKeys();
                        if (newRs.next()) genreId = newRs.getInt(1);
                        newRs.close();
                    }
                }
                rs.close();
            }

            if (genreId > 0) {
                String insertRel = "INSERT INTO movie_genres (movie_id, genre_id) VALUES (?, ?)";
                try (PreparedStatement relStmt = conn.prepareStatement(insertRel)) {
                    relStmt.setInt(1, movieId);
                    relStmt.setInt(2, genreId);
                    relStmt.executeUpdate();
                }
            }
        }

        success = true;

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conn != null) conn.close();
    }

    if (success) {
%>
    <script>
        alert("✅ 영화 정보가 성공적으로 수정되었습니다.");
        location.href = "../controller/movieDetail.jsp?movieId=<%= movieId %>";
    </script>
<%
    } else {
%>
    <script>
        alert("❌ 수정 실패: 오류가 발생했습니다.");
        history.back();
    </script>
<%
    }
%>
