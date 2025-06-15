<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.sql.*, model.util.DBUtil, model.dao.MovieDAO, model.dao.ReviewDAO, model.dto.MovieDTO, model.dto.ReviewDTO" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // URL 파라미터로 전달된 영화 ID 추출
    int movieId = Integer.parseInt(request.getParameter("movieId"));

    // DB 연결
    Connection conn = DBUtil.getConnection();

    // 영화 정보와 해당 영화에 대한 리뷰 목록 조회
    MovieDTO movie = MovieDAO.findById(movieId, conn);
    List<ReviewDTO> reviews = ReviewDAO.findByMovieId(movieId, conn);

    if (conn != null) conn.close();

    // 조회 결과를 request 영역에 저장
    request.setAttribute("movie", movie);
    request.setAttribute("reviews", reviews);

    // 영화 상세 페이지로 포워딩
    RequestDispatcher rd = request.getRequestDispatcher("../view/movieDetail.jsp");
    rd.forward(request, response);
%>
