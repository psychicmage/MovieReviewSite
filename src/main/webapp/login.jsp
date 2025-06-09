<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
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
        	text-align: center;
    	}

    	.form-title {
 		   background-color: #ff0558;
    		padding: 8px 16px;
    		border-radius: 8px;
    		font-size: 22px;
    		font-weight: bold;
    		color: white;
    		display: inline-block;
    		margin: 0 auto 25px auto; /* 위-오른쪽-아래-왼쪽 */
		}

    	.form-group {
        	margin-bottom: 20px;
        	text-align: left;
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
        	box-sizing: border-box;
    	}

    	.button-row {
	        display: flex;
    	    justify-content: space-between;
        	margin-top: 25px;
    	}
	</style>
</head>
<body>
    <div class="form-container">
        <div class="form-title">로그인</div>

        <form action="loginProcess.jsp" method="post">
            <div class="form-group">
                <label for="id">아이디 (숫자)</label>
                <input type="text" name="id" id="id" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" name="password" id="password" required>
            </div>

            <div class="button-row">
                <button type="submit" class="ButtonAreaButton1">로그인</button>
                <a href="register.jsp"><button type="button" class="ButtonAreaButton2">회원가입</button></a>
            </div>
        </form>
    </div>
</body>
</html>
