<%@ page import="model.dao.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
request.setCharacterEncoding("UTF-8");
String userIdParam = request.getParameter("userId");
int userId = 0;

try {
    userId = Integer.parseInt(userIdParam);
} catch (NumberFormatException e) {
    out.println("<script>alert('❌ 잘못된 요청입니다.'); location.href='../controller/manageUsers.jsp';</script>");
    return;
}

boolean success = UserDAO.deleteUser(userId);
%>
<script>
    alert("<%= success ? "✅ 사용자 삭제 완료!" : "❌ 삭제 실패!" %>");
    location.href = "../controller/manageUsers.jsp";
</script>
