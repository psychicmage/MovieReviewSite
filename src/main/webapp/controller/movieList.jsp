<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="model.util.DBUtil, model.dao.MovieDAO, model.dto.MovieDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    Connection conn = DBUtil.getConnection();  // ✅ 경로 전달 제거 (루트 기준)
    List<MovieDTO> movies = MovieDAO.findAll(conn);
    if (conn != null) conn.close();

    request.setAttribute("movies", movies);
    RequestDispatcher rd = request.getRequestDispatcher("../view/movieList.jsp");
    rd.forward(request, response);
%>
