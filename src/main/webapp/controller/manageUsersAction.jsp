<%@ page import="java.sql.*, java.util.*, model.dao.UserDAO, model.dto.UserDTO, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
List<UserDTO> users = UserDAO.findAll(dbPath);

request.setAttribute("users", users);
RequestDispatcher rd = request.getRequestDispatcher("../view/manageUsers.jsp");
rd.forward(request, response);
%>