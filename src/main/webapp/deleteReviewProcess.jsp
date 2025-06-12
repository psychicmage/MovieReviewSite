<%@ page import="java.sql.*, model.util.DBUtil" %>
<%
int reviewId = Integer.parseInt(request.getParameter("reviewId"));
String dbPath = application.getRealPath("/WEB-INF/db/movies.db");

try (Connection conn = DBUtil.getConnection(dbPath)) {
    String sql = "DELETE FROM reviews WHERE review_id = ?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, reviewId);
    pstmt.executeUpdate();
    pstmt.close();
}
%>
<script>
    alert("✅ 리뷰가 삭제되었습니다.");
    location.href = "manageReviews.jsp";
</script>
