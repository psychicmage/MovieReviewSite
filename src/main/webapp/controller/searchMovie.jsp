<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.sql.*, model.util.DBUtil, model.dao.MovieDAO, model.dto.MovieDTO" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // DB 연결
    Connection conn = DBUtil.getConnection();
    List<MovieDTO> movies = new ArrayList<>();

    // 검색 및 정렬 파라미터 처리
    String keyword = request.getParameter("keyword");
    String field = request.getParameter("field");
    String sortOption = request.getParameter("sort");

    if (keyword == null) keyword = "";
    if (field == null) field = "title";
    if (sortOption == null || sortOption.isBlank()) sortOption = "TITLE_ASC";

    // 검색어가 없으면 전체 목록 정렬, 있으면 조건에 따라 검색
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

    // 조회 결과 및 검색 조건을 request에 저장
    request.setAttribute("movies", movies);
    request.setAttribute("keyword", keyword);
    request.setAttribute("field", field);
    request.setAttribute("sort", sortOption);

    // 결과 페이지로 포워딩
    RequestDispatcher rd = request.getRequestDispatcher("../view/searchMovie.jsp");
    rd.forward(request, response);
%>
