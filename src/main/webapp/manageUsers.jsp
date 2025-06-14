<%@ page import="java.util.*, java.sql.*, model.dao.UserDAO, model.dto.UserDTO, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
List<UserDTO> users = new ArrayList<>();

try (Connection conn = DBUtil.getConnection(dbPath)) {
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
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 관리</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <h2>👥 사용자 관리</h2>
    <table border="1" width="100%">
        <tr>
            <th>ID</th>
            <th>아이디</th>
            <th>이메일</th>
            <th>삭제</th>
        </tr>
        <% for (UserDTO u : users) { %>
        <tr>
            <td><%= u.getUserId() %></td>
            <td><%= u.getUsername() %></td>
            <td><%= u.getEmail() %></td>
            <td>
                <a href="deleteUserProcess.jsp?userId=<%= u.getUserId() %>" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
            </td>
        </tr>
        <% } %>
    </tabl>e
</div>
<div style="position: absolute; top: 10px; right: 10px;">
    <a href="main.jsp">
        <button style="
            background-color: black;
            color: deeppink;
            border: 2px solid deeppink;
            padding: 8px 12px;
            margin-right: 10px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        ">IPP-6조</button>
    </a>

    <a href="admin.jsp">
        <button style="
            background-color: black;
            color: deeppink;
            border: 2px solid deeppink;
            padding: 8px 12px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        ">관리자 홈</button>
    </a>
</div>

</body>
</html>
