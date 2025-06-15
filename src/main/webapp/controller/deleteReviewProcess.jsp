<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil" %>
<%
    request.setCharacterEncoding("UTF-8");

    String reviewIdParam = request.getParameter("reviewId");
    String movieIdParam = request.getParameter("movieId");
    int reviewId = 0;
    int movieId = 0;

    try {
        reviewId = Integer.parseInt(reviewIdParam);
        movieId = Integer.parseInt(movieIdParam);
    } catch (NumberFormatException e) {
%>
    <script>
        alert('❌ 잘못된 요청입니다.');
        history.back();
    </script>
<%
        return;
    }

    try (Connection conn = DBUtil.getConnection()) {
        String sql = "DELETE FROM reviews WHERE review_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, reviewId);
            pstmt.executeUpdate();
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert('❌ 리뷰 삭제 중 오류가 발생했습니다.');
        history.back();
    </script>
<%
        return;
    }
%>
<script>
    alert("✅ 리뷰가 삭제되었습니다.");
    location.href = "../controller/movieDetail.jsp?movieId=<%= movieId %>";
</script>
