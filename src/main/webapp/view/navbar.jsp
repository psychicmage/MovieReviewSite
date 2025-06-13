<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<div class="header-wrapper">
  <div class="header">
    <div class="left-section">
      <div class="logo" onclick="location.href='main.jsp'" style="cursor: pointer;">
        <img src="<%= request.getContextPath() %>/posters/team6_logo.png" alt="Team 6 로고" style="height: 40px;">
      </div>
    </div>

    <div class="right-section">
      <!-- 🔍 검색 아이콘 -->
      <div class="search-icon" style="display: inline-block; margin-right: 1rem;">
        <a href="searchMovie.jsp" title="검색 페이지로 이동">
          <img src="img/search-icon.png" alt="검색" style="width: 24px; height: 24px; vertical-align: middle;">
        </a>
      </div>

      <%
        Object uidObj = session.getAttribute("userId");
        int uid = (uidObj != null) ? Integer.parseInt(uidObj.toString()) : -1;
        boolean isAdmin = (uid == 1);
      %>

      <% if (uidObj == null) { %>
        <a href="login.jsp"><button class="ButtonAreaButton1">로그인</button></a>
        <a href="register.jsp"><button class="ButtonAreaButton2">회원가입</button></a>
      <% } else { %>
        <div class="dropdown">
          <button class="dropdown-btn">
            <%= session.getAttribute("username") != null ? session.getAttribute("username") : "사용자" %> ▼
          </button>
          <div class="dropdown-content">
            <% if (isAdmin) { %>
              <a href="admin.jsp">관리자 페이지</a>
            <% } else { %>
              <a href="mypage.jsp">마이페이지</a>
            <% } %>
            <a href="controller/logoutAction.jsp">로그아웃</a>
          </div>
        </div>
      <% } %>
    </div>
  </div>
</div>
