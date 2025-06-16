<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil, model.dao.MovieDAO" %>

<%
	request.setCharacterEncoding("UTF-8");
	
 	//영화 ID 파라미터 추출
	String movieIdParam = request.getParameter("movieId");
	int movieId = 0;

	try {
   	 movieId = Integer.parseInt(movieIdParam);
	} catch (NumberFormatException e) {
%>
    <script>
        alert("❌ 잘못된 요청입니다.");
        location.href = "../controller/deleteMovie.jsp";
    </script>
<%
    	return;
	}

	Connection conn = null;
	boolean success = false;

	try {
    	conn = DBUtil.getConnection();
    	conn.setAutoCommit(false);

    //  DAO를 통해 영화 및 관련 정보 삭제
   		MovieDAO.deleteMovie(conn, movieId);

    	conn.commit();
    	success = true;

	} catch (Exception e) {
    	if (conn != null) conn.rollback();//예외 발생 시 롤백 처리
    	e.printStackTrace();
	} finally {
    	if (conn != null) conn.close();
	}
%>

<script>
    alert("<%= success ? "✅ 영화가 삭제되었습니다." : "❌ 삭제 중 오류가 발생했습니다." %>");
    location.href = "../controller/movieList.jsp"; //성공시 영화 목록 페이지로 이동
</script>
