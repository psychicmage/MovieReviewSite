<%@ page import="java.util.*, java.sql.*, model.dao.MovieDAO, model.dto.MovieDTO, model.util.DBUtil" %>
<%
    Connection conn = DBUtil.getConnection();
    List<MovieDTO> movies = MovieDAO.findAll(conn);
    if (conn != null) conn.close();

    request.setAttribute("movies", movies);
    RequestDispatcher rd = request.getRequestDispatcher("../view/deleteMovie.jsp");
    rd.forward(request, response);
%>
