<%@ page import="model.dao.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 사용자 ID 파라미터 추출 및 숫자 변환
    String userIdParam = request.getParameter("userId");
    int userId = 0;

    // 숫자가 아닌 경우 예외 처리
    try {
        userId = Integer.parseInt(userIdParam);
    } catch (NumberFormatException e) {
        out.println("<script>alert('❌ 잘못된 요청입니다.'); location.href='../controller/manageUsers.jsp';</script>");
        return;
    }

    // 사용자 삭제 실행
    boolean success = UserDAO.deleteUser(userId);
%>

<!-- 삭제 성공 여부에 따라 결과 알림 후 사용자 관리 페이지로 이동 -->
<script>
    alert("<%= success ? "✅ 사용자 삭제 완료!" : "❌ 삭제 실패!" %>");
    location.href = "../controller/manageUsers.jsp";
</script>
