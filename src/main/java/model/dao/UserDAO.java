package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.dto.UserDTO;
import model.util.DBUtil;

public class UserDAO {

    // ✅ username 기반 로그인
    public static boolean login(String username, String password, String dbPath) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DBUtil.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ 회원가입 (user_id 자동 증가 가정)
    public static boolean register(UserDTO user, String dbPath) {
        String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ ID로 사용자 정보 조회
    public static UserDTO findById(int userId, String dbPath) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                // 비밀번호는 필요시만 set
                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static boolean checkPassword(int userId, String inputPassword, String dbPath) {
        String sql = "SELECT 1 FROM users WHERE user_id = ? AND password = ?";
        try (Connection conn = DBUtil.getConnection(dbPath);
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, userId);
            pstmt.setString(2, inputPassword);
            ResultSet rs = pstmt.executeQuery();
            return rs.next(); // 있으면 true
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static boolean deleteUser(int userId, String dbPath) {
        String sql1 = "DELETE FROM reviews WHERE user_id = ?";
        String sql2 = "DELETE FROM users WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection(dbPath);
             PreparedStatement pstmt1 = conn.prepareStatement(sql1);
             PreparedStatement pstmt2 = conn.prepareStatement(sql2)) {

            pstmt1.setInt(1, userId);
            pstmt1.executeUpdate();

            pstmt2.setInt(1, userId);
            int rows = pstmt2.executeUpdate();

            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
