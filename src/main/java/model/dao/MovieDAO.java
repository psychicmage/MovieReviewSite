package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.dto.MovieDTO;

/**
 * 영화 관련 DB 작업을 처리하는 DAO 클래스
 */
public class MovieDAO {

    /**
     * 전체 영화 목록을 제목 오름차순으로 조회
     */
    public static List<MovieDTO> findAll(Connection conn) {
        List<MovieDTO> list = new ArrayList<>();
        String sql = """
            SELECT m.movie_id, m.title, m.release_date,
                   IFNULL(AVG(r.rating), 0) AS avg_rating,
                   COUNT(r.review_id) AS review_count,
                   k.keyword_list
            FROM movies m
            LEFT JOIN reviews r ON m.movie_id = r.movie_id
            LEFT JOIN keywords k ON m.movie_id = k.movie_id
            GROUP BY m.movie_id
            ORDER BY m.title
        """;

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                MovieDTO movie = new MovieDTO();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setReleaseDate(rs.getString("release_date"));
                movie.setAverageRating(rs.getDouble("avg_rating"));
                movie.setReviewCount(rs.getInt("review_count"));
                movie.setKeywordList(rs.getString("keyword_list"));
                list.add(movie);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 특정 영화 ID로 영화 상세 정보 조회
     */
    public static MovieDTO findById(int movieId, Connection conn) {
        String sql = """
            SELECT m.movie_id, m.title, m.overview, m.release_date,
                   c.director, c.main_cast,
                   IFNULL(AVG(r.rating), 0) AS avg_rating,
                   COUNT(DISTINCT r.review_id) AS review_count,
                   GROUP_CONCAT(DISTINCT g.name) AS genres,
                   k.keyword_list
            FROM movies m
            LEFT JOIN credits c ON m.movie_id = c.movie_id
            LEFT JOIN reviews r ON m.movie_id = r.movie_id
            LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
            LEFT JOIN genres g ON mg.genre_id = g.genre_id
            LEFT JOIN keywords k ON m.movie_id = k.movie_id
            WHERE m.movie_id = ?
            GROUP BY m.movie_id
        """;

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, movieId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                MovieDTO movie = new MovieDTO();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setReleaseDate(rs.getString("release_date"));
                movie.setAverageRating(rs.getDouble("avg_rating"));
                movie.setReviewCount(rs.getInt("review_count"));
                movie.setOverview(rs.getString("overview"));
                movie.setDirector(rs.getString("director"));
                movie.setMainCast(rs.getString("main_cast"));
                movie.setKeywordList(rs.getString("keyword_list"));
                movie.setGenres(rs.getString("genres"));
                return movie;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 제목에 특정 키워드가 포함된 영화 검색
     */
    public static List<MovieDTO> searchByTitle(Connection conn, String keyword) {
        List<MovieDTO> list = new ArrayList<>();
        String sql = """
            SELECT m.movie_id, m.title, m.release_date,
                   IFNULL(AVG(r.rating), 0) AS avg_rating,
                   COUNT(r.review_id) AS review_count,
                   k.keyword_list
            FROM movies m
            LEFT JOIN reviews r ON m.movie_id = r.movie_id
            LEFT JOIN keywords k ON m.movie_id = k.movie_id
            WHERE m.title LIKE ?
            GROUP BY m.movie_id
            ORDER BY m.release_date DESC
        """;

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + keyword + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                MovieDTO movie = new MovieDTO();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setReleaseDate(rs.getString("release_date"));
                movie.setAverageRating(rs.getDouble("avg_rating"));
                movie.setReviewCount(rs.getInt("review_count"));
                movie.setKeywordList(rs.getString("keyword_list"));
                list.add(movie);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 장르에 특정 키워드가 포함된 영화 검색
     */
    public static List<MovieDTO> searchByGenre(Connection conn, String keyword) {
        List<MovieDTO> list = new ArrayList<>();
        String sql = """
            SELECT m.movie_id, m.title, m.release_date,
                   IFNULL(AVG(r.rating), 0) AS avg_rating,
                   COUNT(r.review_id) AS review_count,
                   k.keyword_list
            FROM movies m
            LEFT JOIN reviews r ON m.movie_id = r.movie_id
            LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
            LEFT JOIN genres g ON mg.genre_id = g.genre_id
            LEFT JOIN keywords k ON m.movie_id = k.movie_id
            WHERE g.name LIKE ?
            GROUP BY m.movie_id
            ORDER BY m.release_date DESC
        """;

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + keyword + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                MovieDTO movie = new MovieDTO();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setReleaseDate(rs.getString("release_date"));
                movie.setAverageRating(rs.getDouble("avg_rating"));
                movie.setReviewCount(rs.getInt("review_count"));
                movie.setKeywordList(rs.getString("keyword_list"));
                list.add(movie);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 키워드에 특정 단어가 포함된 영화 검색
     */
    public static List<MovieDTO> searchByKeyword(Connection conn, String keyword) {
        List<MovieDTO> list = new ArrayList<>();
        String sql = """
            SELECT m.movie_id, m.title, m.release_date,
                   IFNULL(AVG(r.rating), 0) AS avg_rating,
                   COUNT(r.review_id) AS review_count,
                   k.keyword_list
            FROM movies m
            LEFT JOIN reviews r ON m.movie_id = r.movie_id
            LEFT JOIN keywords k ON m.movie_id = k.movie_id
            WHERE k.keyword_list LIKE ?
            GROUP BY m.movie_id
            ORDER BY m.release_date DESC
        """;

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + keyword + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                MovieDTO movie = new MovieDTO();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setReleaseDate(rs.getString("release_date"));
                movie.setAverageRating(rs.getDouble("avg_rating"));
                movie.setReviewCount(rs.getInt("review_count"));
                movie.setKeywordList(rs.getString("keyword_list"));
                list.add(movie);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 정렬 기준에 따라 전체 영화 목록 조회
     * sortOption: TITLE_DESC, RATING_HIGH, RATING_LOW, REVIEW_COUNT_HIGH, ...
     */
    public static List<MovieDTO> findAllSorted(Connection conn, String sortOption) {
        List<MovieDTO> list = new ArrayList<>();

        String orderByClause = switch (sortOption) {
            case "TITLE_DESC" -> "m.title DESC";
            case "RATING_HIGH" -> "avg_rating DESC";
            case "RATING_LOW" -> "avg_rating ASC";
            case "REVIEW_COUNT_HIGH" -> "review_count DESC";
            case "REVIEW_COUNT_LOW" -> "review_count ASC";
            case "RELEASE_DATE" -> "m.release_date DESC";
            default -> "m.title ASC";
        };

        String sql = """
            SELECT m.movie_id, m.title, m.release_date,
                   IFNULL(AVG(r.rating), 0) AS avg_rating,
                   COUNT(r.review_id) AS review_count
            FROM movies m
            LEFT JOIN reviews r ON m.movie_id = r.movie_id
            GROUP BY m.movie_id
            ORDER BY """ + orderByClause;

        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                MovieDTO movie = new MovieDTO();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setReleaseDate(rs.getString("release_date"));
                movie.setAverageRating(rs.getDouble("avg_rating"));
                movie.setReviewCount(rs.getInt("review_count"));
                list.add(movie);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 정렬 기준이 포함된 제목 검색
     */
    public static List<MovieDTO> searchByTitleSorted(Connection conn, String keyword, String sortOption) {
        return searchWithSort(conn, keyword, sortOption, "title");
    }

    /**
     * 정렬 기준이 포함된 장르 검색
     */
    public static List<MovieDTO> searchByGenreSorted(Connection conn, String keyword, String sortOption) {
        return searchWithSort(conn, keyword, sortOption, "genre");
    }

    /**
     * 정렬 기준이 포함된 키워드 검색
     */
    public static List<MovieDTO> searchByKeywordSorted(Connection conn, String keyword, String sortOption) {
        return searchWithSort(conn, keyword, sortOption, "keyword");
    }

    /**
     * 공통 정렬 검색 처리 함수 (제목, 장르, 키워드 검색에 사용)
     */
    private static List<MovieDTO> searchWithSort(Connection conn, String keyword, String sortOption, String field) {
        List<MovieDTO> list = new ArrayList<>();

        String orderByClause = switch (sortOption) {
            case "TITLE_DESC" -> "m.title DESC";
            case "RATING_HIGH" -> "avg_rating DESC";
            case "RATING_LOW" -> "avg_rating ASC";
            case "REVIEW_COUNT_HIGH" -> "review_count DESC";
            case "REVIEW_COUNT_LOW" -> "review_count ASC";
            case "RELEASE_DATE" -> "m.release_date DESC";
            default -> "m.title ASC";
        };

        StringBuilder sql = new StringBuilder("""
            SELECT m.movie_id, m.title, m.release_date,
                   IFNULL(AVG(r.rating), 0) AS avg_rating,
                   COUNT(r.review_id) AS review_count,
                   k.keyword_list
            FROM movies m
            LEFT JOIN reviews r ON m.movie_id = r.movie_id
            LEFT JOIN keywords k ON m.movie_id = k.movie_id
        """);

        if ("genre".equals(field)) {
            sql.append("""
                LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
                LEFT JOIN genres g ON mg.genre_id = g.genre_id
                WHERE g.name LIKE ?
            """);
        } else if ("keyword".equals(field)) {
            sql.append("WHERE k.keyword_list LIKE ?\n");
        } else {
            sql.append("WHERE m.title LIKE ?\n");
        }

        sql.append("GROUP BY m.movie_id ORDER BY ").append(orderByClause);

        try (PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            pstmt.setString(1, "%" + keyword + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                MovieDTO movie = new MovieDTO();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setReleaseDate(rs.getString("release_date"));
                movie.setAverageRating(rs.getDouble("avg_rating"));
                movie.setReviewCount(rs.getInt("review_count"));
                movie.setKeywordList(rs.getString("keyword_list"));
                list.add(movie);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
