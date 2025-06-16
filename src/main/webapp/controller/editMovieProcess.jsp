<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil, model.dao.MovieDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	// 클라이언트로부터 전달받은 영화 정보 파라미터 추출
	int movieId = Integer.parseInt(request.getParameter("movieId"));
	String title = request.getParameter("title");
	String releaseDate = request.getParameter("releaseDate");
	String overview = request.getParameter("overview");
		String director = request.getParameter("director");
	String mainCast = request.getParameter("mainCast");
	String genres = request.getParameter("genres");
	String keywordList = request.getParameter("keywordList");

	Connection conn = null;
	boolean success = false;

	try {
    	conn = DBUtil.getConnection();
    	conn.setAutoCommit(false);
    	// DAO를 통해 각 테이블의 영화 정보 업데이트 실행
   		MovieDAO.updateMovieInfo(conn, movieId, title, releaseDate, overview);
   		MovieDAO.updateCredits(conn, movieId, director, mainCast);
    	MovieDAO.updateKeywords(conn, movieId, keywordList);
    	MovieDAO.updateGenres(conn, movieId, genres);

    	conn.commit();
    	success = true;

	} catch (Exception e) {
    	if (conn != null) conn.rollback();//예외 발생 시 롤백 처리
    	e.printStackTrace();
	} finally {
    	if (conn != null) conn.close();
	}

	if (success) {
%>
<script>
    	alert("✅ 영화 정보가 성공적으로 수정되었습니다.");
    	location.href = "../view/admin.jsp"; //성공시 관리자 페이지로 이동
</script>
<%
	} else {
%>
<script>
    	alert("❌ 수정 실패: 오류가 발생했습니다.");
    	history.back();
</script>
<%
	}
%>
