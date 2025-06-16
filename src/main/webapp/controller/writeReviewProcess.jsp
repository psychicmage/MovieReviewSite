<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil, model.dao.ReviewDAO" %>

<%
    // 요청 데이터의 문자 인코딩 설정 (한글 처리 등)
    request.setCharacterEncoding("UTF-8");

    // 세션에서 로그인된 사용자 ID 가져오기
    Integer userIdObj = (Integer) session.getAttribute("userId");

    // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
    if (userIdObj == null) {
        response.sendRedirect("../view/login.jsp");
        return;
    }

    int userId = userIdObj;

    // 사용자가 폼에서 보낸 데이터 추출
    String ratingParam = request.getParameter("rating");
    String reviewText = request.getParameter("reviewText");
    String movieIdParam = request.getParameter("movieId");

    // 필수 항목 누락 여부 확인
    if (ratingParam == null || reviewText == null || reviewText.trim().isEmpty() || movieIdParam == null) {
        out.println("<script>alert('모든 항목을 입력해주세요.'); history.back();</script>");
        return;
    }

    int movieId;
    double rating;

    // 문자열을 숫자로 변환 (예외 발생 시 알림 후 이전 페이지로)
    try {
        movieId = Integer.parseInt(movieIdParam);
        rating = Double.parseDouble(ratingParam);
    } catch (NumberFormatException e) {
        out.println("<script>alert('입력 형식이 올바르지 않습니다.'); history.back();</script>");
        return;
    }

    // DB 연결
    Connection conn = DBUtil.getConnection();

    // 리뷰를 DB에 저장
    boolean success = ReviewDAO.insertReview(conn, movieId, userId, rating, reviewText);

    // 연결 닫기
    if (conn != null) conn.close();

    // 등록 성공 시 해당 영화 상세 페이지로 이동
    if (success) {
        response.sendRedirect("movieDetail.jsp?movieId=" + movieId);
    } else {
%>
    <!-- 등록 실패 시 알림 후 이전 페이지로 이동 -->
    <script>
        alert("리뷰 등록에 실패했습니다.");
        history.back();
    </script>
<% } %>
