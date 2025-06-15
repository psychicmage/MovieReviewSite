<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil, model.dao.ReviewDAO" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 폼 데이터 추출
    int movieId = Integer.parseInt(request.getParameter("movieId"));
    String reviewText = request.getParameter("reviewText");
    double rating = Double.parseDouble(request.getParameter("rating"));
    int userId = (int) session.getAttribute("userId");

    // DB 연결
    Connection conn = DBUtil.getConnection();

    // 리뷰 등록
    boolean success = ReviewDAO.insertReview(conn, movieId, userId, rating, reviewText);

    if (conn != null) conn.close();

    if (success) {
        // 등록 성공 시 상세 페이지로 이동
        response.sendRedirect("movieDetail.jsp?movieId=" + movieId);
    } else {
%>
    <!-- 등록 실패 시 알림 후 이전 페이지로 이동 -->
    <script>
        alert("리뷰 등록에 실패했습니다.");
        history.back();
    </script>
<% } %>
