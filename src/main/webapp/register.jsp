<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .form-container {
            max-width: 400px;
            margin: 120px auto;
            padding: 30px;
            background-color: #1c1c1c;
            border-radius: 10px;
            color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.5);
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            background-color: #333;
            border: 1px solid #555;
            border-radius: 5px;
            color: white;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>회원가입</h2>
        <form action="registerProcess.jsp" method="post">
            <div class="form-group">
                <label for="id">아이디 (숫자)</label>
                <input type="text" name="id" id="id" required>
            </div>
            <div class="form-group">
 				<label for="email">이메일</label>
  				<input type="email" name="email" id="email" required>
			</div>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" name="name" id="name" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" name="password" id="password" required>
            </div>
            
            <div style="text-align: center;">
                <button type="submit" class="ButtonAreaButton2">회원가입</button>
            </div>
        </form>
    </div>
</body>
</html>
