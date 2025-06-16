<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.sql.*, model.dao.UserDAO, model.dto.UserDTO, model.util.DBUtil" %>

<%
    // 사용자 목록을 저장할 리스트
    List<UserDTO> users = new ArrayList<>();

    // DB에서 사용자 목록 조회
    try (Connection conn = DBUtil.getConnection()) {
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

    // 사용자 리스트를 request scope에 저장
    request.setAttribute("users", users);

    // 사용자 관리 화면으로 포워딩
    RequestDispatcher rd = request.getRequestDispatcher("../view/manageUsers.jsp");
    rd.forward(request, response);
%>
