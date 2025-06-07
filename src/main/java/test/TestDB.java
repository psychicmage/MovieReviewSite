package test;

import java.sql.Connection;
import model.util.DBUtil;

public class TestDB {
    public static void main(String[] args) {
        Connection conn = DBUtil.getConnection();
        if (conn != null) {
            System.out.println("✅ DB 연결 성공!");
        } else {
            System.out.println("❌ DB 연결 실패!");
        }
    }
}
