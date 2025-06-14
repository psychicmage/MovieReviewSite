<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.sql.*, model.dao.UserDAO, model.dto.UserDTO, model.util.DBUtil" %>
<%
List<UserDTO> users = new ArrayList<>();

try (Connection conn = DBUtil.getConnection()) { // ✅ 수정된 부분
    String sql = "SELECT user_id, username, email FROM users ORDER BY user_id";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();
    
    while (rs.next()) {
        UserDTO user = new UserDTO();
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        users.add(user);
    }

    rs.close();
    pstmt.close();
}

request.setAttribute("users", users);
RequestDispatcher rd = request.getRequestDispatcher("../view/manageUsers.jsp");
rd.forward(request, response);
%>
