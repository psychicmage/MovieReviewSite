package model.dao;

import java.sql.*;
import java.util.*;
import model.dto.ReviewDTO;

public class ReviewDAO {

    public static List<ReviewDTO> findByMovieId(int movieId, Connection conn) {
        List<ReviewDTO> list = new ArrayList<>();
        String sql = """
            SELECT r.review_id, r.user_id, u.username, r.rating, r.review, r.review_date
            FROM reviews r
            JOIN users u ON r.user_id = u.user_id
            WHERE r.movie_id = ?
            ORDER BY r.review_date DESC
        """;

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, movieId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                ReviewDTO r = new ReviewDTO();
                r.setReviewId(rs.getInt("review_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setUsername(rs.getString("username"));
                r.setRating(rs.getDouble("rating"));
                r.setReview(rs.getString("review"));
                r.setReviewDate(rs.getString("review_date"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
