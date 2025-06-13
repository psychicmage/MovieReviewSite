<%@ page import="java.util.*, java.sql.*, model.dao.ReviewDAO, model.dto.ReviewDTO, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
Connection conn = DBUtil.getConnection(dbPath);

List<ReviewDTO> reviews = ReviewDAO.findAllWithMovieTitle(conn);

request.setAttribute("reviews", reviews);
RequestDispatcher rd = request.getRequestDispatcher("../view/manageReviews.jsp");
rd.forward(request, response);
%>