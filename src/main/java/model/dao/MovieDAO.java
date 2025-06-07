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
                   IFNULL(AVG(r.rating), 0) AS avg_rating
            FROM movies m
            LEFT JOIN reviews r ON m.movie_id = r.movie_id
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
                list.add(movie);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static MovieDTO findById(int movieId, Connection conn) {
        String sql = """
            SELECT m.movie_id, m.title, m.release_date,
                   IFNULL(AVG(r.rating), 0) AS avg_rating,
                   c.director, c.main_cast, k.keyword_list, m.overview
            FROM movies m
            LEFT JOIN reviews r ON m.movie_id = r.movie_id
            LEFT JOIN credits c ON m.movie_id = c.movie_id
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
                movie.setDirector(rs.getString("director"));
                movie.setMainCast(rs.getString("main_cast"));
                movie.setKeywordList(rs.getString("keyword_list"));
                movie.setOverview(rs.getString("overview"));
                return movie;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
