<%@ page import="java.sql.*, model.util.DBUtil" %>
<%
String reviewIdParam = request.getParameter("reviewId");
int reviewId = 0;

try {
    reviewId = Integer.parseInt(reviewIdParam);
} catch (NumberFormatException e) {
    out.println("<script>alert('❌ 잘못된 요청입니다.'); location.href='../controller/manageReviews.jsp';</script>");
    return;
}

try (Connection conn = DBUtil.getConnection()) {
    String sql = "DELETE FROM reviews WHERE review_id = ?";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, reviewId);
    pstmt.executeUpdate();
    pstmt.close();
}
%>
<script>
    alert("✅ 리뷰가 삭제되었습니다.");
    location.href = "../controller/manageReviews.jsp";
</script>
