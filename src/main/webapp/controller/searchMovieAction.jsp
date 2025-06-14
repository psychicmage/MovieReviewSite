<%@ page import="java.util.*, java.sql.*, model.util.DBUtil, model.dao.MovieDAO, model.dto.MovieDTO" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);
    List<MovieDTO> movies = new ArrayList<>();

    String keyword = request.getParameter("keyword");
    String field = request.getParameter("field");
    String sortOption = request.getParameter("sort");

    if (keyword == null) keyword = "";
    if (field == null) field = "title";
    if (sortOption == null || sortOption.isBlank()) sortOption = "TITLE_ASC";

    if (keyword.isBlank()) {
        movies = MovieDAO.findAllSorted(conn, sortOption);
    } else {
        switch (field) {
            case "genre":
                movies = MovieDAO.searchByGenreSorted(conn, keyword, sortOption);
                break;
            case "keyword":
                movies = MovieDAO.searchByKeywordSorted(conn, keyword, sortOption);
                break;
            default:
                movies = MovieDAO.searchByTitleSorted(conn, keyword, sortOption);
                break;
        }
    }

    if (conn != null) conn.close();

    request.setAttribute("movies", movies);
    request.setAttribute("keyword", keyword);
    request.setAttribute("field", field);
    request.setAttribute("sortOption", sortOption);

    RequestDispatcher rd = request.getRequestDispatcher("../view/searchMovie.jsp");
    rd.forward(request, response);
%>
