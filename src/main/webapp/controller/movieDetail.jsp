<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.sql.*, model.util.DBUtil, model.dao.MovieDAO, model.dao.ReviewDAO, model.dto.MovieDTO, model.dto.ReviewDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    int movieId = Integer.parseInt(request.getParameter("movieId"));
    Connection conn = DBUtil.getConnection();  // ✅ 실 경로 제거 (루트 기준 DBUtil)

    MovieDTO movie = MovieDAO.findById(movieId, conn);
    List<ReviewDTO> reviews = ReviewDAO.findByMovieId(movieId, conn);

    if (conn != null) conn.close();

    request.setAttribute("movie", movie);
    request.setAttribute("reviews", reviews);

    RequestDispatcher rd = request.getRequestDispatcher("../view/movieDetail.jsp");
    rd.forward(request, response);
%>
