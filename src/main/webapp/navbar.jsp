<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<div class="header-wrapper">
  <div class="header">
    <div class="left-section">
      <div class="logo" onclick="location.href='main.jsp'" style="cursor: pointer;">IPP-6조</div>
      <div class="search">
        <form action="main.jsp" method="get">
          <input type="text" name="keyword" class="SearchBar" placeholder="영화 제목을 검색해주세요.">
        </form>
      </div>
    </div>
    <div class="right-section">
      <% if (session.getAttribute("userId") == null) { %>
        <a href="login.jsp"><button class="ButtonAreaButton1">로그인</button></a>
        <a href="register.jsp"><button class="ButtonAreaButton2">회원가입</button></a>
      <% } else { %>
        <div class="dropdown">
          <button class="dropdown-btn">
            <%= session.getAttribute("username") %> ▼
          </button>
          <div class="dropdown-content">
            <a href="mypage.jsp">마이페이지</a>
            <a href="logout.jsp">로그아웃</a>
          </div>
        </div>
      <% } %>
    </div>
  </div>
</div>
