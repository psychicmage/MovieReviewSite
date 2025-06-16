<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.io.*, model.util.DBUtil" %>
<%
    out.println("<h3>🔥 절대 경로 기반 DB 테스트</h3>");

    try {
        Connection conn = DBUtil.getConnection();  // ✅ 절대 경로로 고정된 DB에 연결
        if (conn == null) {
            out.println("<span style='color:red;'>❌ DB 연결 실패 (Connection is null)</span>");
            return;
        }

        out.println("<span style='color:green;'>✅ DB 연결 성공</span><br><br>");

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT movie_id, title, release_date FROM movies LIMIT 5");

        out.println("🎬 영화 목록 (최대 5개):<br>");
        while (rs.next()) {
            out.println("ID: " + rs.getInt("movie_id") + ", 제목: " + rs.getString("title") + ", 개봉일: " + rs.getString("release_date") + "<br>");
        }

        rs.close();
        stmt.close();
        conn.close();

    } catch (Exception e) {
        StringWriter sw = new StringWriter();
        e.printStackTrace(new PrintWriter(sw));
        out.println("<pre style='color:red;'>❌ 오류 발생:\n" + sw.toString() + "</pre>");
    }
%>
