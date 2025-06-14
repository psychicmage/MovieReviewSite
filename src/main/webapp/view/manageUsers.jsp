<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.dto.UserDTO, java.util.List" %>
<%
List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>사용자 관리</title>
  <link rel="stylesheet" href="../css/style.css">
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
        <a href="../controller/deleteUserAction.jsp?userId=<%= u.getUserId() %>" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
      </td>
    </tr>
    <% } %>
  </table>
</div>
<div style="position: absolute; top: 10px; right: 10px;">
  <a href="../view/main.jsp"><button class="ButtonAreaButton1">IPP-6조</button></a>
  <a href="../view/admin.jsp"><button class="ButtonAreaButton2">관리자 홈</button></a>
</div>
</body>
</html>