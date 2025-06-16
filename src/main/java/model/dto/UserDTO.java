package model.dto;

/**
 * 사용자 정보를 저장하는 DTO 클래스
 * - 로그인, 회원가입, 마이페이지 등에서 사용
 */
public class UserDTO {
    private int userId;         // 사용자 ID (Primary Key)
    private String username;    // 사용자 이름 (ID)
    private String email;       // 이메일 주소
    private String password;    // 비밀번호

    public UserDTO() {}

    /**
     * 전체 필드를 초기화하는 생성자
     */
    public UserDTO(int userId, String username, String email, String password) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.password = password;
    }

    // Getter & Setter
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
