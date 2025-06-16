<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="model.util.DBUtil, model.dao.MovieDAO, model.dto.MovieDTO" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // DB 연결 후 전체 영화 목록 조회
    Connection conn = DBUtil.getConnection();
    List<MovieDTO> movies = MovieDAO.findAll(conn);
    if (conn != null) conn.close();

    // 조회한 영화 목록을 request scope에 저장
    request.setAttribute("movies", movies);

    // 뷰(JSP)로 포워딩
    RequestDispatcher rd = request.getRequestDispatcher("../view/movieList.jsp");
    rd.forward(request, response);
%>
