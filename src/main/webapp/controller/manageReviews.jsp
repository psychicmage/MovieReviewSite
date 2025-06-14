<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.sql.*, model.dao.ReviewDAO, model.dto.ReviewDTO, model.util.DBUtil" %>
<%
    Connection conn = DBUtil.getConnection(); // ✅ 루트 기준 DB 연결
    List<ReviewDTO> reviews = new ArrayList<>();

    try {
        String sql = """
            SELECT r.review_id, r.user_id, u.username, r.rating, r.review, r.review_date, m.title
            FROM reviews r
            JOIN users u ON r.user_id = u.user_id
            JOIN movies m ON r.movie_id = m.movie_id
            ORDER BY r.review_date DESC
        """;

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                ReviewDTO r = new ReviewDTO();
                r.setReviewId(rs.getInt("review_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setUsername(rs.getString("username"));
                r.setRating(rs.getDouble("rating"));
                r.setReview(rs.getString("review"));
                r.setReviewDate(rs.getString("review_date"));
                r.setTitle(rs.getString("title"));
                reviews.add(r);
            }
        }

        if (conn != null) conn.close();

        request.setAttribute("reviews", reviews);
        RequestDispatcher rd = request.getRequestDispatcher("../view/manageReviews.jsp");
        rd.forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
