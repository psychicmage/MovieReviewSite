package model.util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * SQLite 데이터베이스 연결을 처리하는 유틸 클래스
 * - 프로젝트 내에서 공통으로 DB 연결을 제공
 */
public class DBUtil {

    /**
     * JSP에서 DB 파일의 전체 경로를 넘겨받아 연결 (application.getRealPath(...) 사용 시)
     * - 현재는 사용하지 않지만 유지 가능
     * @param fullPath DB 파일의 절대 경로
     * @return DB 연결 객체 (Connection)
     */
    public static Connection getConnection(String fullPath) {
        try {
            Class.forName("org.sqlite.JDBC");
            return DriverManager.getConnection("jdbc:sqlite:" + fullPath);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 콘솔/웹 공통 사용용으로 경로를 직접 지정한 DB 연결
     * - 실제 배포 환경에 맞춰 경로 수정 필요
     * @return DB 연결 객체 (Connection)
     */
    public static Connection getConnection() {
        try {
            Class.forName("org.sqlite.JDBC");

            // 프로젝트 환경에 맞게 수정할 절대 경로
            String dbPath = "E:/MovieReview/MovieReviewSite/db/movies.db";

            return DriverManager.getConnection("jdbc:sqlite:" + dbPath);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
