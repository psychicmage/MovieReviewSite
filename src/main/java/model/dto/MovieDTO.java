package model.dto;

public class MovieDTO {
    private int movieId;
    private String title;
    private String releaseDate;
    private double averageRating;

    private String overview;       // ✅ 줄거리 필드 추가
    private String director;
    private String mainCast;
    private String keywordList;

    public MovieDTO() {}

    public MovieDTO(int movieId, String title, String releaseDate, double averageRating) {
        this.movieId = movieId;
        this.title = title;
        this.releaseDate = releaseDate;
        this.averageRating = averageRating;
    }

    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getReleaseDate() { return releaseDate; }
    public void setReleaseDate(String releaseDate) { this.releaseDate = releaseDate; }

    public double getAverageRating() { return averageRating; }
    public void setAverageRating(double averageRating) { this.averageRating = averageRating; }

    public String getOverview() { return overview; }               // ✅ getter
    public void setOverview(String overview) { this.overview = overview; } // ✅ setter

    public String getDirector() { return director; }
    public void setDirector(String director) { this.director = director; }

    public String getMainCast() { return mainCast; }
    public void setMainCast(String mainCast) { this.mainCast = mainCast; }

    public String getKeywordList() { return keywordList; }
    public void setKeywordList(String keywordList) { this.keywordList = keywordList; }
}
