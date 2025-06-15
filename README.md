# 🎬 기반 영화 리뷰 웹사이트 - 웹프로그래밍 6조

## 📌 프로젝트 소개

이 프로젝트는 영화 정보를 검색하고 리뷰를 작성할 수 있는 **영화 리뷰 웹사이트**입니다.  
Rotten Tomatoes와 Watcha의 기능을 벤치마킹하여, 사용자는 영화에 대한 리뷰를 남기고, 별점을 매길 수 있습니다.  
관리자는 영화/리뷰/사용자 관리 기능을 통해 콘텐츠를 유지·관리할 수 있습니다.

---

## 👨‍👩‍👧‍👦 팀원 (6조)

- 현재영  
- 김차민  
- 서성준  
- 황인수

---

## 📁 주요 디렉토리 구조
MovieReviewSite/
├── db/
│   └── movies.db                 # SQLite 데이터베이스 파일
├── src/
│   └── main/
│       ├── java/
│       │   ├── model/            # 데이터 계층 (Model)
│       │   │   ├── dao/          # DAO 클래스 (DB 접근 처리)
│       │   │   ├── dto/          # DTO 클래스 (데이터 전달 객체)
│       │   │   └── util/         # DBUtil 등 유틸 클래스
│       │   └── test/             # 테스트용 Java 파일
│       │
│       └── webapp/
│           ├── controller/       # JSP 처리 로직 (Controller 역할)
│           ├── view/             # 사용자에게 보여지는 JSP 페이지 (View)
│           ├── css/              # 사이트 전체 스타일시트
│           ├── img/              # 로고, 검색 아이콘 등 이미지 리소스
│           ├── posters/          # 영화 포스터 이미지
│           ├── test/             # 테스트용 JSP 파일 
│           ├── WEB-INF/
│           │   └── lib/          # JDBC 드라이버 등 라이브러리
│           └── index.jsp         # 진입점 JSP (movieList.jsp로 리디렉트)
│
└── README.txt
---

## 🔐 주요 기능

### 사용자
- 회원가입 / 로그인 / 로그아웃
- 마이페이지 (이메일 / 비밀번호 변경, 탈퇴)
- 영화 목록 / 상세정보 보기
- 리뷰 작성 및 별점 평가

### 관리자 (userId = 1)
- 영화 관리(등록 / 수정 / 삭제)
- 리뷰 관리
- 사용자 관리

---

## ⚙ 실행 방법

1. **Eclipse** 또는 **Tomcat 연동 IDE**에서 프로젝트 import
2. `movies.db`, JDBC 드라이버(`sqlite-jdbc-<버전>.jar`) 위치 확인
3. `http://localhost:8080/MovieReviewSite/` 접속  
   → 자동으로 `controller/movieList.jsp`로 리디렉션됨
