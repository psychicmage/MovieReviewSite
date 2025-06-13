<%@ page import="java.sql.*, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");

    String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
    Connection conn = DBUtil.getConnection(dbPath);

    boolean success = false;
    int userId = -1;

    try {
        // 중복 확인
        String checkSql = "SELECT COUNT(*) FROM users WHERE username = ?";
        PreparedStatement checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setString(1, username);
        ResultSet rs = checkStmt.executeQuery();
        rs.next();
        int count = rs.getInt(1);
        rs.close();
        checkStmt.close();

        if (count == 0) {
            // INSERT (user_id는 자동 증가)
            String insertSql = "INSERT INTO users (username, email, password, created_at) VALUES (?, ?, ?, datetime('now'))";
            PreparedStatement insertStmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            insertStmt.setString(1, username);
            insertStmt.setString(2, email);
            insertStmt.setString(3, password);
            insertStmt.executeUpdate();

            // 생성된 user_id 가져오기
            ResultSet generatedKeys = insertStmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                userId = generatedKeys.getInt(1);
            }
            insertStmt.close();

            // 세션 설정
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
        response.sendRedirect("main.jsp");
    } else {
%>
    <script>
        alert("이미 존재하는 아이디입니다.");
        history.back();
    </script>
<%
    }
%>
