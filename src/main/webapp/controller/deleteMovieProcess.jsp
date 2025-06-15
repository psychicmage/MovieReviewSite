<%@ page import="java.sql.*, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // 요청 파라미터로 전달된 movieId 추출 및 검증
    String movieIdParam = request.getParameter("movieId");
    int movieId = 0;

    try {
        movieId = Integer.parseInt(movieIdParam);
    } catch (NumberFormatException e) {
        // movieId가 숫자가 아닌 경우 경고 후 이전 페이지로 이동
        out.println("<script>alert('❌ 잘못된 요청입니다.'); location.href='../controller/deleteMovie.jsp';</script>");
        return;
    }

    boolean success = false;

    // DB 연결 및 삭제 처리
    try (Connection conn = DBUtil.getConnection()) {

        // 연관된 테이블부터 삭제 (순서 중요: 자식 → 부모)
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

<!-- 삭제 결과에 따라 알림 후 영화 목록으로 이동 -->
<script>
    alert("<%= success ? "✅ 영화가 삭제되었습니다." : "❌ 삭제 중 오류가 발생했습니다." %>");
    location.href = "../controller/movieList.jsp";
</script>
