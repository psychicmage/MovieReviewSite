package model.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    // JSP에서 application.getRealPath(...)로 넘겨받은 경로가 필요한 경우
    // (현재는 사용 안 하지만 유지해도 무방)
    public static Connection getConnection(String fullPath) {
        try {
            Class.forName("org.sqlite.JDBC");
            return DriverManager.getConnection("jdbc:sqlite:" + fullPath);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // ✅ 웹 & 콘솔 공통 사용: 절대 경로 고정 (실제 DB만 직접 접근)
    public static Connection getConnection() {
        try {
            Class.forName("org.sqlite.JDBC");

            // ❗ 본인 환경에 맞게 경로 수정
            String dbPath = "E:/MovieReview/MovieReviewSite/db/movies.db";

            return DriverManager.getConnection("jdbc:sqlite:" + dbPath);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
