<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // 이 JSP는 웹 애플리케이션의 진입점(index.jsp) 역할을 함
    // 사용자가 루트(/)로 접속했을 때 controller의 movieList.jsp로 리디렉션하여
    // 실제 메인 페이지(영화 목록 화면)를 보여줌
    response.sendRedirect("controller/movieList.jsp");
%>
