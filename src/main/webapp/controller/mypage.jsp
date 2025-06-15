<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.dao.UserDAO, model.dto.UserDTO" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 세션에서 로그인된 사용자 ID 가져오기
    Object userIdObj = session.getAttribute("userId");

    // 로그인되지 않은 경우 로그인 페이지로 이동
    if (userIdObj == null) {
        response.sendRedirect("../view/login.jsp");
        return;
    }

    // 사용자 정보 조회
    int userId = Integer.parseInt(userIdObj.toString());
    UserDTO user = UserDAO.findById(userId);

    // 사용자 정보를 request에 저장 후 마이페이지로 포워딩
    request.setAttribute("user", user);
    RequestDispatcher rd = request.getRequestDispatcher("../view/mypage.jsp");
    rd.forward(request, response);
%>
