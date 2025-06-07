package model.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    // JSP에서 전달된 실제 경로를 사용하는 버전
    public static Connection getConnection(String fullPath) {
        try {
            Class.forName("org.sqlite.JDBC");
            String url = "jdbc:sqlite:" + fullPath;
            return DriverManager.getConnection(url);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // 콘솔 등에서 사용되는 기본 경로
    public static Connection getConnection() {
        try {
            Class.forName("org.sqlite.JDBC");
            String path = System.getProperty("user.dir") + "/src/main/webapp/WEB-INF/db/movies.db";
            String url = "jdbc:sqlite:" + path;
            return DriverManager.getConnection(url);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
