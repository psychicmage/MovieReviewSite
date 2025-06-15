<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 리뷰 ID와 영화 ID 파라미터 추출
    String reviewIdParam = request.getParameter("reviewId");
    String movieIdParam = request.getParameter("movieId");
    int reviewId = 0;
    int movieId = 0;

    // 숫자가 아닌 값이 들어올 경우 예외 처리
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

    // DB 연결 및 리뷰 삭제
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

<!-- 삭제 성공 시 해당 영화 상세 페이지로 이동 -->
<script>
    alert("✅ 리뷰가 삭제되었습니다.");
    location.href = "../controller/movieDetail.jsp?movieId=<%= movieId %>";
</script>
