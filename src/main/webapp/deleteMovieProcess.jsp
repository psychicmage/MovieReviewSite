<%@ page import="java.sql.*, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
int movieId = Integer.parseInt(request.getParameter("movieId"));
String dbPath = application.getRealPath("/WEB-INF/db/movies.db");

boolean success = false;

try (Connection conn = DBUtil.getConnection(dbPath)) {

    // 연관된 리뷰, credits, keywords, movie_genres부터 삭제
    String[] sqls = {
        "DELETE FROM reviews WHERE movie_id = ?",
        "DELETE FROM credits WHERE movie_id = ?",
        "DELETE FROM keywords WHERE movie_id = ?",
        "DELETE FROM movie_genres WHERE movie_id = ?",
        "DELETE FROM movies WHERE movie_id = ?"
    };

    for (String sql : sqls) {
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, movieId);
            pstmt.executeUpdate();
        }
    }

    success = true;

} catch (Exception e) {
    e.printStackTrace();
}
%>

<script>
    alert("<%= success ? "✅ 영화가 삭제되었습니다." : "❌ 삭제 중 오류가 발생했습니다." %>");
    location.href = "deleteMovie.jsp";
</script>
