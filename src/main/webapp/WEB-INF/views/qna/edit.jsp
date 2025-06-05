<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        body {
            background: #f6f9fc;
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 60%;
            margin: 40px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            padding: 30px;
        }
        h2 {
            color: #007b7f;
            font-size: 2em;
            margin-bottom: 20px;
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            font-weight: bold;
            margin-top: 15px;
            margin-bottom: 5px;
            color: #333;
        }
        input[type="text"],
        input[type="password"],
        textarea,
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 1em;
            color: #333;
        }
        textarea {
            resize: vertical;
            min-height: 150px;
        }
        input[type="submit"] {
            width: 150px;
            margin-top: 25px;
            align-self: center;
            background-color: #007b7f;
            color: white;
            padding: 12px 0;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1em;
        }
        input[type="submit"]:hover {
            background-color: #005f6a;
        }
        .error-message {
            color: #d9534f;
            font-weight: bold;
            margin-bottom: 10px;
            text-align: center;
        }
        .message {
            color: #28a745;
            font-weight: bold;
            margin-bottom: 10px;
            text-align: center;
        }
        .back-links {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        .back-links a {
            color: #007b7f;
            text-decoration: none;
            font-size: 0.95em;
        }
        .back-links a:hover {
            text-decoration: underline;
        }
        /* 상태선택(select) -> 관리자 전용 영역 강조 */
        .admin-field {
            display: flex;
            flex-direction: column;
        }
    </style>
</head>
<body>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <h2>Q&A 수정</h2>

    <c:if test="${not empty errorMessage}">
        <p class="error-message">${errorMessage}</p>
    </c:if>
    <c:if test="${not empty message}">
        <p class="message">${message}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/qna/edit" method="post">
        <input type="hidden" name="qnaId" value="${qna.qnaId}"/>

        <label for="title">제목</label>
        <input type="text" id="title" name="title" value="${qna.title}" required/>

        <label for="writer">작성자</label>
        <input type="text" id="writer" name="writer" value="${qna.writer}" readonly/>

        <label for="regDate">작성일</label>
        <input type="text" id="regDate"
               value="<fmt:formatDate value='${qna.regDate}' pattern='yyyy-MM-dd'/>"
               readonly/>

        <label for="category">카테고리</label>
        <select id="category" name="category">
            <option value="">선택</option>
            <option value="도서관 서비스" ${qna.category eq '도서관 서비스' ? 'selected' : ''}>도서관 서비스</option>
            <option value="시설 문의" ${qna.category eq '시설 문의' ? 'selected' : ''}>시설 문의</option>
            <option value="기타" ${qna.category eq '기타' ? 'selected' : ''}>기타</option>
        </select>

        <label for="content">내용</label>
        <textarea id="content" name="content" required>${qna.content}</textarea>

        <label for="openYn">공개 여부</label>
        <select id="openYn" name="openYn">
            <option value="Y" ${qna.openYn eq 'Y' ? 'selected' : ''}>공개</option>
            <option value="N" ${qna.openYn eq 'N' ? 'selected' : ''}>비공개</option>
        </select>

        <label for="password">비밀번호 (비공개글 확인용)</label>
        <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요"/>

        <c:if test="${sessionScope.adminUser != null}">
            <div class="admin-field">
                <label for="status">처리 상태</label>
                <select id="status" name="status">
                    <option value="대기중" ${qna.status eq '대기중' ? 'selected' : ''}>대기중</option>
                    <option value="완료" ${qna.status eq '완료' ? 'selected' : ''}>완료</option>
                </select>
            </div>
        </c:if>

        <input type="submit" value="수정 완료"/>
    </form>

    <div class="back-links">
        <a href="${pageContext.request.contextPath}/qna/detail/${qna.qnaId}">← 상세 보기로 돌아가기</a>
        <a href="${pageContext.request.contextPath}/qna/list">← 목록으로</a>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />
</body>
</html>
