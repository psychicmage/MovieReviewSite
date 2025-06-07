<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="model.util.DBUtil" %>

<%
    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DB 연결 테스트</title>
</head>
<body>
    <h2>🔌 DB 연결 테스트</h2>
    <p>
        <%
            if (conn != null) {
                out.println("✅ DB 연결 성공!");
                conn.close();
            } else {
                out.println("❌ DB 연결 실패!");
            }
        %>
    </p>
</body>
</html>
