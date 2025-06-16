package model.dao;

import java.sql.*;
import java.util.*;
import model.dto.ReviewDTO;

/**
 * 리뷰 관련 DB 작업을 처리하는 DAO 클래스
 */
public class ReviewDAO {

    /**
     * 특정 영화에 등록된 리뷰 목록을 최신순으로 조회
     * @param movieId 조회할 영화 ID
     * @param conn DB 연결 객체
     * @return 리뷰 리스트 (List<ReviewDTO>)
     */
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

    /**
     * 새로운 리뷰를 등록
     * @param conn DB 연결 객체
     * @param movieId 리뷰 대상 영화 ID
     * @param userId 작성자 ID
     * @param rating 평점
     * @param reviewText 리뷰 본문
     * @return 등록 성공 여부
     */
    public static boolean insertReview(Connection conn, int movieId, int userId, double rating, String reviewText) {
        String sql = "INSERT INTO reviews (movie_id, user_id, rating, review, review_date) VALUES (?, ?, ?, ?, datetime('now'))";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, movieId);
            pstmt.setInt(2, userId);
            pstmt.setDouble(3, rating);
            pstmt.setString(4, reviewText);
            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
