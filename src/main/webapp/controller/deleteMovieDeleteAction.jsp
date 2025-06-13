<%@ page import="java.sql.*, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
int movieId = Integer.parseInt(request.getParameter("movieId"));
String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
boolean success = false;

try (Connection conn = DBUtil.getConnection(dbPath)) {
    String sql = "UPDATE movies SET is_deleted = 1 WHERE movie_id = ?";
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setInt(1, movieId);
        int affected = pstmt.executeUpdate();
        success = (affected > 0);
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>
<script>
    alert("<%= success ? '✅ 영화가 삭제되었습니다.' : '❌ 삭제 중 오류가 발생했습니다.' %>");
    location.href = "../controller/deleteMovieAction.jsp";
</script>
