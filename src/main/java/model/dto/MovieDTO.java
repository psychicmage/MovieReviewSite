package model.dto;

/**
 * 영화 정보를 저장하는 DTO 클래스
 * - DB 조회 결과를 전달하거나, 화면에 출력할 데이터를 담을 때 사용
 */
public class MovieDTO {
    private int movieId;               // 영화 ID
    private String title;             // 영화 제목
    private String releaseDate;       // 개봉일
    private double averageRating;     // 평균 평점
    private int reviewCount;          // 리뷰 수

    private String overview;          // 줄거리
    private String director;          // 감독
    private String mainCast;          // 주연 배우
    private String keywordList;       // 키워드 목록
    private String genres;            // 장르 목록

    public MovieDTO() {}

    /**
     * 기본 정보만 사용하는 생성자
     */
    public MovieDTO(int movieId, String title, String releaseDate, double averageRating) {
        this.movieId = movieId;
        this.title = title;
        this.releaseDate = releaseDate;
        this.averageRating = averageRating;
    }

    // Getter & Setter
    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getReleaseDate() { return releaseDate; }
    public void setReleaseDate(String releaseDate) { this.releaseDate = releaseDate; }

    public double getAverageRating() { return averageRating; }
    public void setAverageRating(double averageRating) { this.averageRating = averageRating; }

    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }

    public String getOverview() { return overview; }
    public void setOverview(String overview) { this.overview = overview; }

    public String getDirector() { return director; }
    public void setDirector(String director) { this.director = director; }

    public String getMainCast() { return mainCast; }
    public void setMainCast(String mainCast) { this.mainCast = mainCast; }

    public String getKeywordList() { return keywordList; }
    public void setKeywordList(String keywordList) { this.keywordList = keywordList; }

    public String getGenres() { return genres; }
    public void setGenres(String genres) { this.genres = genres; }
}
