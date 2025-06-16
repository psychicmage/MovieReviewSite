package test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import model.util.DBUtil;

public class TestDB {
    public static void main(String[] args) {
        Connection conn = DBUtil.getConnection();  // 루트/db/movies.db 를 기준으로 연결

        if (conn == null) {
            System.out.println("❌ DB 연결 실패");
            return;
        }

        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM users");

            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("✅ 사용자 수: " + count);
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
