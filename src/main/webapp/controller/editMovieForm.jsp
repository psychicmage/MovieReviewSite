<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil, model.dao.MovieDAO, model.dto.MovieDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    int movieId = Integer.parseInt(request.getParameter("movieId"));

    Connection conn = DBUtil.getConnection();
    MovieDTO movie = MovieDAO.findById(movieId, conn);
    if (conn != null) conn.close();

    request.setAttribute("movie", movie);
    RequestDispatcher rd = request.getRequestDispatcher("../view/editMovieForm.jsp");
    rd.forward(request, response);
%>
