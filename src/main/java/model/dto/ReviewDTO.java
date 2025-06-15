package model.dto;

/**
 * 리뷰 정보를 저장하는 DTO 클래스
 * - 리뷰 목록 조회, 마이페이지, 상세 페이지에서 사용
 */
public class ReviewDTO {
    private int reviewId;        // 리뷰 ID
    private int userId;          // 작성자 ID
    private String username;     // 작성자 이름
    private double rating;       // 평점
    private String review;       // 리뷰 내용
    private String reviewDate;   // 작성일 (yyyy-MM-dd HH:mm:ss)
    private String title;        // 영화 제목 (필요 시 표시용)

    // Getter & Setter
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    public String getReview() { return review; }
    public void setReview(String review) { this.review = review; }

    public String getReviewDate() { return reviewDate; }
    public void setReviewDate(String reviewDate) { this.reviewDate = reviewDate; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
}
