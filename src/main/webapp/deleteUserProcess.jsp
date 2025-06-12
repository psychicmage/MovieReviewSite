<%@ page import="model.dao.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
request.setCharacterEncoding("UTF-8");
int userId = Integer.parseInt(request.getParameter("userId"));
String dbPath = application.getRealPath("/WEB-INF/db/movies.db");

boolean success = UserDAO.deleteUser(userId, dbPath);
%>
<script>
    alert("<%= success ? "✅ 사용자 삭제 완료!" : "❌ 삭제 실패!" %>");
    location.href = "manageUsers.jsp";
</script>
