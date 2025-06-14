<%@ page import="model.dao.UserDAO, model.dto.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    int userId = (int) session.getAttribute("userId");
    UserDTO user = UserDAO.findById(userId, dbPath);

    request.setAttribute("user", user);
    RequestDispatcher rd = request.getRequestDispatcher("../view/mypage.jsp");
    rd.forward(request, response);
%>
