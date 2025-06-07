package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.dto.UserDTO;
import model.util.DBUtil;

public class UserDAO {

    public static boolean login(int userId, String password, String dbPath) {
        String sql = "SELECT * FROM users WHERE user_id = ? AND password = ?";
        try (Connection conn = DBUtil.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean register(UserDTO user, String dbPath) {
        String sql = "INSERT INTO users (user_id, username, email, password) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, user.getUserId());
            pstmt.setString(2, user.getUsername());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPassword());
            pstmt.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
