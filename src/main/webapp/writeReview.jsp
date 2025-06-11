<%@ page import="java.sql.*, model.util.DBUtil, model.dao.ReviewDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
  request.setCharacterEncoding("UTF-8");

  int movieId = Integer.parseInt(request.getParameter("movieId"));
  String reviewText = request.getParameter("reviewText");
  double rating = Double.parseDouble(request.getParameter("rating"));
  int userId = (int) session.getAttribute("userId");

  String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
  Connection conn = DBUtil.getConnection(dbPath);

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
