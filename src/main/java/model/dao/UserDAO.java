package model.dao;

import java.sql.*;
import model.dto.UserDTO;
import model.util.DBUtil;

public class UserDAO {

    // ✅ username 기반 로그인
	public static int login(String username, String password) {
	    String sql = "SELECT user_id FROM users WHERE username = ? AND password = ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, username);
	        pstmt.setString(2, password);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            return rs.getInt("user_id");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1;
	}


    // ✅ 회원가입 (user_id 자동 증가 가정)
    public static boolean register(UserDTO user) {
        String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
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
    public static UserDTO findById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
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

    public static boolean checkPassword(int userId, String inputPassword) {
        String sql = "SELECT 1 FROM users WHERE user_id = ? AND password = ?";
        try (Connection conn = DBUtil.getConnection();
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

    public static boolean deleteUser(int userId) {
        String sql1 = "DELETE FROM reviews WHERE user_id = ?";
        String sql2 = "DELETE FROM users WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
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
    
    public static boolean updateEmail(int userId, String newEmail, String currentPassword) {
        String checkSql = "SELECT 1 FROM users WHERE user_id = ? AND password = ?";
        String updateSql = "UPDATE users SET email = ? WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection()) {
            // 비밀번호 확인
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, userId);
                checkStmt.setString(2, currentPassword);
                ResultSet rs = checkStmt.executeQuery();
                if (!rs.next()) return false; // 비밀번호 틀림
            }

            // 업데이트 수행
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                updateStmt.setString(1, newEmail);
                updateStmt.setInt(2, userId);
                return updateStmt.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public static boolean updatePassword(int userId, String currentPassword, String newPassword) {
        String checkSql = "SELECT 1 FROM users WHERE user_id = ? AND password = ?";
        String updateSql = "UPDATE users SET password = ? WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection()) {
            // 현재 비밀번호 확인
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, userId);
                checkStmt.setString(2, currentPassword);
                ResultSet rs = checkStmt.executeQuery();
                if (!rs.next()) return false;
            }

            // 새 비밀번호로 업데이트
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                updateStmt.setString(1, newPassword);
                updateStmt.setInt(2, userId);
                return updateStmt.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
