<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil, model.dao.ReviewDAO" %>
<%
  request.setCharacterEncoding("UTF-8");

  int movieId = Integer.parseInt(request.getParameter("movieId"));
  String reviewText = request.getParameter("reviewText");
  double rating = Double.parseDouble(request.getParameter("rating"));
  int userId = (int) session.getAttribute("userId");

  Connection conn = DBUtil.getConnection(); // ✅ 절대경로 제거

  boolean success = ReviewDAO.insertReview(conn, movieId, userId, rating, reviewText);

  if (conn != null) conn.close();

  if (success) {
    response.sendRedirect("movieDetail.jsp?movieId=" + movieId);
  } else {
%>
    <script>
      alert("리뷰 등록에 실패했습니다.");
      history.back();
    </script>
<% } %>
