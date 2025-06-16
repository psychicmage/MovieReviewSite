# 영화 리뷰 웹사이트 - 웹프로그래밍응용 6조

## 프로젝트 개요

이 프로젝트는 영화 정보를 검색하고 리뷰를 작성할 수 있는 **영화 리뷰 웹사이트**입니다.  
`Rotten Tomatoes`와 `Watcha`의 기능을 벤치마킹하여, 사용자는 영화에 대한 리뷰를 남기고, 별점을 매길 수 있습니다.  
관리자는 영화/리뷰/사용자 관리 기능을 통해 콘텐츠를 유지·관리할 수 있습니다.

---

## 팀원 (6조)

- 현재영  
- 김차민  
- 서성준  
- 황인수

---

## 디렉토리 구조
```
MovieReviewSite/
├── db/                            # SQLite DB 파일
│   └── movies.db
├── src/
│   └── main/
│       └── java/
│           ├── model/             # 모델 계층
│           │   ├── dao/           # DAO 클래스 (DB 접근 로직)
│           │   ├── dto/           # DTO 클래스 (데이터 전달 객체)
│           │   └── util/          # DBUtil 등 유틸 클래스
│           ├── test/             # Java 테스트 클래스
│           └── webapp/           # 웹 리소스 (JSP, 정적 파일)
│               ├── controller/   # JSP 처리 로직 (Controller)
│               ├── view/         # 사용자에게 보여지는 JSP 페이지 (View)
│               ├── test/         # JSP 테스트 파일
│               ├── css/          # 스타일시트 (style.css 등)
│               ├── img/          # 검색 아이콘, 로고 이미지
│               ├── posters/      # 영화 포스터 이미지
│               ├── webfonts/     # 폰트 리소스
│               └── index.jsp     # 첫 진입점 JSP (movieList.jsp로 리디렉션)
```

---

## 주요 기능
- 영화 목록 / 상세정보 보기
- 영화 검색 / 정렬

### 사용자
- 회원가입 / 로그인 / 로그아웃
- 마이페이지 (이메일 / 비밀번호 변경, 탈퇴)
- 리뷰 작성 및 별점 평가

### 관리자 (userId = 1)
- 영화 관리(등록 / 수정 / 삭제)
- 리뷰 관리
- 사용자 관리

---

### **SQLite DB 파일 확인**
- 프로젝트 내 `db/movies.db` 파일 확인
- 현재 프로젝트는 **SQLite DB 파일 경로를 절대경로로 고정**
- `WEB-INF/lib/` 폴더에 `sqlite-jdbc-xxx.jar` 드라이버 확인

### **DB 경로 수정 (필수!)**
- `DBUtil.java` 내부에서 DB 경로를 직접 설정하는 부분 확인
- 예시:
     ```java
     String dbPath = "C:/Users/yourname/eclipse-workspace/MovieReviewSite/db/movies.db";
     ```
- 위 경로를 **자신의 프로젝트 위치에 맞게 수정**해야 정상적으로 DB가 연결됩니다.

### **프로젝트 실행**
- `http://localhost:8080/MovieReviewSite/` 접속 후 메인 페이지 또는 `index.jsp`로 진입
- `index.jsp`는 기본적으로 `controller/movieList.jsp`로 리디렉션

### **계정 정보**
- 관리자 계정: `admin / admin`
