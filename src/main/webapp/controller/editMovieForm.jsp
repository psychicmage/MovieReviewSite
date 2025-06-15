<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil, model.dao.MovieDAO, model.dto.MovieDTO" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // URL 파라미터에서 movieId 추출
    int movieId = Integer.parseInt(request.getParameter("movieId"));

    // DB 연결 후 영화 정보 조회
    Connection conn = DBUtil.getConnection();
    MovieDTO movie = MovieDAO.findById(movieId, conn);
    if (conn != null) conn.close();

    // 영화 정보를 request에 저장 후 수정 폼 JSP로 포워딩
    request.setAttribute("movie", movie);
    RequestDispatcher rd = request.getRequestDispatcher("../view/editMovieForm.jsp");
    rd.forward(request, response);
%>
