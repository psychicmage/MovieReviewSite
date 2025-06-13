<%@ page import="java.util.*, java.sql.*, model.dao.MovieDAO, model.dto.MovieDTO, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
String sort = request.getParameter("sort");
String dbPath = application.getRealPath("/WEB-INF/db/movies.db");

List<MovieDTO> movies = new ArrayList<>();
try (Connection conn = DBUtil.getConnection(dbPath)) {
    if (sort != null && !sort.isEmpty()) {
        movies = MovieDAO.findDeletedMoviesSorted(conn, sort);
    } else {
        movies = MovieDAO.findDeletedMoviesSorted(conn, "");  // 기본 정렬
    }
}

request.setAttribute("movies", movies);
RequestDispatcher rd = request.getRequestDispatcher("../view/deleteMovie.jsp");
rd.forward(request, response);
%>

