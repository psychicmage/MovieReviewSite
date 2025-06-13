<%@ page import="java.util.*, java.sql.*, model.dao.ReviewDAO, model.dto.ReviewDTO, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
String dbPath = application.getRealPath("/WEB-INF/db/movies.db");
Connection conn = DBUtil.getConnection(dbPath);

List<ReviewDTO> reviews = new ArrayList<>();
try {
    String sql = "SELECT r.review_id, r.user_id, u.username, r.rating, r.review, r.review_date, m.title " +
                 "FROM reviews r JOIN users u ON r.user_id = u.user_id JOIN movies m ON r.movie_id = m.movie_id " +
                 "ORDER BY r.review_date DESC";
    PreparedStatement pstmt = conn.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    while (rs.next()) {
        ReviewDTO r = new ReviewDTO();
        r.setReviewId(rs.getInt("review_id"));
        r.setUserId(rs.getInt("user_id"));
        r.setUsername(rs.getString("username"));
        r.setRating(rs.getDouble("rating"));
        r.setReview(rs.getString("review"));
        r.setReviewDate(rs.getString("review_date"));
        r.setTitle(rs.getString("title")); // → 필요하면 ReviewDTO에 title 필드 추가
        reviews.add(r);
    }

    rs.close();
    pstmt.close();
    conn.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 관리</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h2>📝 리뷰 관리</h2>
        <table border="1" width="100%">
            <tr>
                <th>영화</th>
                <th>작성자</th>
                <th>평점</th>
                <th>내용</th>
                <th>작성일</th>
                <th>삭제</th>
            </tr>
            <% for (ReviewDTO r : reviews) { %>
            <tr>
                <td><%= r.getTitle() %></td>
                <td><%= r.getUsername() %></td>
                <td><%= r.getRating() %></td>
                <td><%= r.getReview() %></td>
                <td><%= r.getReviewDate() %></td>
                <td><a href="deleteReviewProcess.jsp?reviewId=<%= r.getReviewId() %>">삭제</a></td>
            </tr>
            <% } %>
        </table>
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
