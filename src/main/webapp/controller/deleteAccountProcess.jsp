<%@ page import="model.dao.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    int userId = (int) session.getAttribute("userId");
    String password = request.getParameter("password");

    boolean isValid = UserDAO.checkPassword(userId, password);

    if (!isValid) {
        out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
        return;
    }

    boolean success = UserDAO.deleteUser(userId);
    if (success) {
        session.invalidate();
        response.sendRedirect("movieList.jsp");
    } else {
        out.println("<script>alert('회원 탈퇴에 실패했습니다.'); history.back();</script>");
    }
%>
