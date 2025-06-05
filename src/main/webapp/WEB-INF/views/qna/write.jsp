<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A 작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        body {
            background: #f6f9fc;
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 70%;
            margin: 40px auto;
        }
        .qa-form-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            padding: 30px 40px;
        }
        .qa-form-container h2 {
            text-align: center;
            color: #007b7f;
            margin-bottom: 25px;
            font-size: 2em;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
            box-sizing: border-box;
            color: #333;
        }
        .form-group textarea {
            resize: vertical;
            min-height: 150px;
        }
        .button-group {
            text-align: center;
            margin-top: 30px;
        }
        .button-group button,
        .button-group a {
            background-color: #007b7f;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.05em;
            margin: 0 10px;
            text-decoration: none;
            display: inline-block;
        }
        .button-group button[type="reset"] {
            background-color: #6c757d;
        }
        .button-group button:hover,
        .button-group a:hover {
            background-color: #005f6a;
        }
        .button-group button[type="reset"]:hover {
            background-color: #5a6268;
        }
        .error-message {
            color: #d9534f;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
        }
        .success-message {
            color: #28a745;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <div class="qa-form-container">
        <h2>Q&A 작성</h2>

        <c:if test="${not empty errorMessage}">
            <p class="error-message">${errorMessage}</p>
        </c:if>
        <c:if test="${not empty message}">
            <p class="success-message">${message}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/qna/write" method="post">
            <input type="hidden" name="writer" value="${sessionScope.loggedInMember.memberId}" />

            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" required placeholder="질문 제목을 입력해주세요." />
            </div>

            <div class="form-group">
                <label for="category">카테고리</label>
                <select id="category" name="category" required>
                    <option value="">카테고리 선택</option>
                    <option value="도서관 서비스">도서관 서비스</option>
                    <option value="시설 문의">시설 문의</option>
                    <option value="기타">기타</option>
                </select>
            </div>

            <div class="form-group">
                <label for="content">내용</label>
                <textarea id="content" name="content" required placeholder="질문 내용을 상세히 입력해주세요."></textarea>
            </div>

            <div class="form-group">
                <label for="openYn">공개 여부</label>
                <select id="openYn" name="openYn">
                    <option value="Y" selected>공개</option>
                    <option value="N">비공개</option>
                </select>
            </div>

            <div class="form-group">
                <label for="password">비밀번호 (비공개 시 열람용)</label>
                <input type="password" id="password" name="password" placeholder="비공개 설정 시 입력하세요." />
            </div>

            <div class="button-group">
                <button type="submit">등록</button>
                <button type="reset">초기화</button>
                <a href="${pageContext.request.contextPath}/qna/list">목록으로</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />
</body>
</html>
