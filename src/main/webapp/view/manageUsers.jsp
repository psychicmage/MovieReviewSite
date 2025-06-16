<%@ page import="java.util.*, java.sql.*, model.dao.UserDAO, model.dto.UserDTO, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // 컨트롤러에서 전달된 사용자 리스트 가져오기
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

<div class="admin-container">
  <div class="admin-title">👥 사용자 관리</div>

  <!-- 사용자 목록 테이블 -->
  <table class="user-table">
    <thead>
      <tr>
        <th>ID</th>
        <th>아이디</th>
        <th>이메일</th>
        <th>관리</th>
      </tr>
    </thead>
    <tbody>
      <% for (UserDTO u : users) { %>
        <tr>
          <td><%= u.getUserId() %></td>
          <td><%= u.getUsername() %></td>
          <td><%= u.getEmail() %></td>
          <td>
            <% if (u.getUserId() != 1) { %>
              <!-- 삭제 버튼 (관리자 제외) -->
              <form action="../controller/deleteUserProcess.jsp" method="post"
                    onsubmit="return confirm('정말 삭제하시겠습니까?')" style="display:inline;">
                <input type="hidden" name="userId" value="<%= u.getUserId() %>">
                <button type="submit" class="ButtonAreaButton2">삭제</button>
              </form>
            <% } else { %>
              <!-- 관리자 계정은 삭제 불가 -->
              <span style="color: gray;">(관리자)</span>
            <% } %>
          </td>
        </tr>
      <% } %>
    </tbody>
  </table>

  <!-- 돌아가기 버튼 -->
  <div style="margin-top: 30px;">
    <a href="../view/admin.jsp" class="ButtonAreaButton1">취소</a>
  </div>
</div>

</body>
</html>
