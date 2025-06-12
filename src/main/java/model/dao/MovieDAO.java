package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.dto.MovieDTO;

public class MovieDAO {

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

    public static MovieDTO findById(int movieId, Connection conn) {
        String sql = """
            SELECT m.movie_id, m.title, m.overview, m.release_date,
                   c.director, c.main_cast,
                   IFNULL(AVG(r.rating), 0) AS avg_rating,
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
                movie.setOverview(rs.getString("overview"));
                movie.setDirector(rs.getString("director"));
                movie.setMainCast(rs.getString("main_cast"));
                movie.setKeywordList(rs.getString("keyword_list"));
                movie.setGenres(rs.getString("genres")); // ✅ 장르도 설정
                return movie;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
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
    
    public static List<MovieDTO> findAllSorted(Connection conn, String sortOption) {
        List<MovieDTO> list = new ArrayList<>();

        // 기본 정렬은 제목 오름차순
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
    
 // MovieDAO.java
    public static List<MovieDTO> searchByTitleSorted(Connection conn, String keyword, String sortOption) {
        return searchWithSort(conn, keyword, sortOption, "title");
    }

    public static List<MovieDTO> searchByGenreSorted(Connection conn, String keyword, String sortOption) {
        return searchWithSort(conn, keyword, sortOption, "genre");
    }

    public static List<MovieDTO> searchByKeywordSorted(Connection conn, String keyword, String sortOption) {
        return searchWithSort(conn, keyword, sortOption, "keyword");
    }

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
            sql.append("""
                WHERE k.keyword_list LIKE ?
            """);
        } else {
            sql.append("WHERE m.title LIKE ? ");
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