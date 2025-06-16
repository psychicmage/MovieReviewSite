<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil, model.dao.MovieDAO" %>

<%
	request.setCharacterEncoding("UTF-8");
	// 폼에서 전달받은 영화 정보 파라미터 수집
	String title = request.getParameter("title");
	String releaseDate = request.getParameter("releaseDate");
	String overview = request.getParameter("overview");
	String director = request.getParameter("director");
	String mainCast = request.getParameter("mainCast");
	String genres = request.getParameter("genres");
	String keywordList = request.getParameter("keywordList");

	Connection conn = null;
	try {
    	conn = DBUtil.getConnection();
    	conn.setAutoCommit(false);
    	// 영화 정보 등록 (movies 테이블)
   		int movieId = MovieDAO.insertMovie(conn, title, releaseDate, overview);
    	if (movieId <= 0) throw new Exception("영화 등록 실패");
    	//감독 및 주연 등록 (credits 테이블)
    	MovieDAO.insertCredits(conn, movieId, director, mainCast);
    	//키워드 등록 (keywords 테이블)
    	MovieDAO.insertKeywords(conn, movieId, keywordList);
    	//장르 처리 (genres + movie_genres 테이블)
    	String[] genreArray = genres.split(",");
    	for (String g : genreArray) {
        	int genreId = MovieDAO.getOrInsertGenre(conn, g.trim()); // 기존 장르 ID 찾거나 새로 삽입
        	if (genreId > 0) {
            	MovieDAO.insertMovieGenre(conn, movieId, genreId); //테이블에 삽입
        	}
    	}

    	conn.commit();
	%>
    <script>
        alert("✅ 영화 등록 완료!");
        location.href = "../view/admin.jsp";//성공시 관리자 페이지로 이동
    </script>
<%
	} catch (Exception e) {
    	if (conn != null) conn.rollback();
    	e.printStackTrace();
%>
    <script>
        alert("❌ 등록 실패. 오류가 발생했습니다.");
        history.back();
    </script>
<%
	} finally {
   		if (conn != null) conn.close();
	}
%>
