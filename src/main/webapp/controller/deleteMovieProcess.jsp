<%@ page import="java.sql.*, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
String movieIdParam = request.getParameter("movieId");
int movieId = 0;

try {
    movieId = Integer.parseInt(movieIdParam);
} catch (NumberFormatException e) {
    out.println("<script>alert('❌ 잘못된 요청입니다.'); location.href='../controller/deleteMovie.jsp';</script>");
    return;
}

boolean success = false;

try (Connection conn = DBUtil.getConnection()) {
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
    location.href = "../controller/deleteMovie.jsp";
</script>
