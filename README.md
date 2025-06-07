# MovieReviewSite

## 초기 세팅
1. `WEB-INF/lib/` 폴더에 `sqlite-jdbc.jar`
2. `WEB-INF/db/` 폴더에 `movies.db` 무조건 있어야함 (같이 올리긴 했으나 확인 필수)
3. `build path/Libraries/Classpath`에 `.jar` 파일이랑 `Tomcat`이 있어야함 (필수)

## DB 연결 테스트
1. `src/test/TestDB.java` : 자바 환경에서 DB연결 테스트 코드
2. `src/webapp/testDB.jsp` : jsp 환경에서 DB연결 테스트 코드

## 지금까지
1. `model` : `dao`, `dto`, `DBUtil` 정의 해놓은 패키지 (MVC의 model 부분)
2. `main.jsp` : 메인 화면 (영화 목록 출력 + 로그인/회원가입)
3. `movieDetail.jsp` : 메인에서 영화 클릭하면 이동하는 영화 상세 페이지
4. `login.jsp`/ `register.jsp` : 로그인/회원가입 (아직 로그아웃 기능 없음)

## to-do
1. css 가져오기
2. 영화 포스터 이미지 가져오기
3. 그 외 기능 구현