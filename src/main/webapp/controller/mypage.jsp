<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.dao.UserDAO, model.dto.UserDTO" %>
<%
    request.setCharacterEncoding("UTF-8");
    Object userIdObj = session.getAttribute("userId");

    if (userIdObj == null) {
        response.sendRedirect("../view/login.jsp");
        return;
    }

    int userId = Integer.parseInt(userIdObj.toString());
    
    UserDTO user = UserDAO.findById(userId);

    request.setAttribute("user", user);
    RequestDispatcher rd = request.getRequestDispatcher("../view/mypage.jsp");
    rd.forward(request, response);
%>
