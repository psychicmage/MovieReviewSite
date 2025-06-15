<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!-- 전체 상단 네비게이션 바 -->
<div class="header-wrapper">
  <div class="header">

    <!-- 왼쪽: 로고 (클릭 시 메인 페이지로 이동) -->
    <div class="left-section">
      <div class="logo" onclick="location.href='../controller/movieList.jsp'" style="cursor: pointer;">
        <img src="../img/logo-icon.png" alt="logo" style="height: 120px;">
      </div>
    </div>

    <!-- 오른쪽: 검색 아이콘 + 로그인/회원정보 -->
    <div class="right-section">

      <!-- 검색 버튼 -->
      <div class="search-icon" style="display: inline-block; margin-right: 1rem;">
        <a href="../controller/searchMovie.jsp" title="검색 페이지로 이동">
          <img src="../img/search-icon.png" alt="검색" style="width: 24px; height: 24px; vertical-align: middle;">
        </a>
      </div>

      <%
        // 로그인 사용자 ID와 관리자 여부 확인
        Object uidObj = session.getAttribute("userId");
        int uid = (uidObj != null) ? Integer.parseInt(uidObj.toString()) : -1;
        boolean isAdmin = (uid == 1);
      %>

      <% if (uidObj == null) { %>
        <!-- 비로그인 상태 -->
        <a href="../view/login.jsp"><button class="ButtonAreaButton1">로그인</button></a>
        <a href="../view/register.jsp"><button class="ButtonAreaButton2">회원가입</button></a>
      <% } else { %>
        <!-- 로그인 상태: 드롭다운 메뉴 -->
        <div class="dropdown">
          <button class="dropdown-btn">
            <%= session.getAttribute("username") != null ? session.getAttribute("username") : "사용자" %> ▼
          </button>
          <div class="dropdown-content">
            <% if (isAdmin) { %>
              <a href="../view/admin.jsp">관리자 페이지</a>
            <% } else { %>
              <a href="mypage.jsp">마이페이지</a>
            <% } %>
            <a href="../controller/logoutProcess.jsp">로그아웃</a>
          </div>
        </div>
      <% } %>

    </div>
  </div>
</div>
