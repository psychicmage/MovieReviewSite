<%@ page import="java.util.*, java.sql.*, model.dao.MovieDAO, model.dto.MovieDTO, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);

    List<MovieDTO> movies = MovieDAO.findAll(conn);
    if (conn != null) conn.close();

    request.setAttribute("movies", movies);
    RequestDispatcher rd = request.getRequestDispatcher("../view/main.jsp");
    rd.forward(request, response);
%>
