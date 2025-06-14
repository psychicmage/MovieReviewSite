<%@ page import="java.util.*, java.sql.*, model.dao.ReviewDAO, model.dto.ReviewDTO, model.util.DBUtil" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    List<ReviewDTO> reviews = (List<ReviewDTO>) request.getAttribute("reviews");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 관리</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <div class="container">
        <h2>📝 리뷰 관리</h2>
        <table border="1" width="100%">
            <tr>
                <th>영화</th>
                <th>작성자</th>
                <th>평점</th>
                <th>내용</th>
                <th>작성일</th>
                <th>삭제</th>
            </tr>
            <% for (ReviewDTO r : reviews) { %>
            <tr>
                <td><%= r.getTitle() %></td>
                <td><%= r.getUsername() %></td>
                <td><%= r.getRating() %></td>
                <td><%= r.getReview() %></td>
                <td><%= r.getReviewDate() %></td>
                <td><a href="../controller/deleteReviewProcess.jsp?reviewId=<%= r.getReviewId() %>">삭제</a></td>
            </tr>
            <% } %>
        </table>
    </div>
  <div style="position: absolute; top: 10px; right: 10px;">
    <a href="../controller/movieList.jsp">
        <button style="
            background-color: black;
            color: deeppink;
            border: 2px solid deeppink;
            padding: 8px 12px;
            margin-right: 10px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        ">IPP-6조</button>
    </a>

    <a href="../view/admin.jsp">
        <button style="
            background-color: black;
            color: deeppink;
            border: 2px solid deeppink;
            padding: 8px 12px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        ">관리자 홈</button>
    </a>
</div>
  
    
</body>
</html>
