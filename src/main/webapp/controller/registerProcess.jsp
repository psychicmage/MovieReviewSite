<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, model.util.DBUtil" %>

<%
    // 요청 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 입력값 추출
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");

    Connection conn = DBUtil.getConnection();

    boolean success = false;
    int userId = -1;

    try {
        // 1. 아이디 중복 여부 확인
        String checkSql = "SELECT COUNT(*) FROM users WHERE username = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setString(1, username);
        ResultSet rs = checkStmt.executeQuery();
        rs.next();
        int count = rs.getInt(1);
        rs.close();
        checkStmt.close();

        if (count == 0) {
            // 2. 신규 사용자 등록
            String insertSql = "INSERT INTO users (username, email, password, created_at) VALUES (?, ?, ?, datetime('now'))";
            PreparedStatement insertStmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            insertStmt.setString(1, username);
            insertStmt.setString(2, email);
            insertStmt.setString(3, password);
            insertStmt.executeUpdate();

            // 3. 생성된 user_id 가져오기
            ResultSet generatedKeys = insertStmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                userId = generatedKeys.getInt(1);
            }
            insertStmt.close();

            // 4. 세션 설정 (자동 로그인 처리)
            session.setAttribute("userId", userId);
            session.setAttribute("username", username);
            session.setAttribute("email", email);

            success = true;
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (success) {
        // 성공 시 메인 페이지로 이동
        response.sendRedirect("movieList.jsp");
    } else {
%>
    <!-- 중복 아이디 또는 오류 발생 시 경고 후 이전 페이지로 이동 -->
    <script>
        alert("이미 존재하는 아이디입니다.");
        history.back();
    </script>
<%
    }
%>
