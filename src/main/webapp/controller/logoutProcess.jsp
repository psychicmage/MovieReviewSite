<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // 세션 무효화 (로그아웃)
    session.invalidate();

    // 메인 페이지로 이동
    response.sendRedirect("movieList.jsp");
%>
