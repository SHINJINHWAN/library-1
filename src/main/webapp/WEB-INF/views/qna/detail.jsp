<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A 상세 보기 - ${qna.title}</title>
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
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        }
        .qa-detail-container {
            width: 100%;
        }
        .qa-detail-header {
            border-bottom: 2px solid #007b7f;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        .qa-detail-header h2 {
            color: #007b7f;
            font-size: 2em;
            margin: 0;
        }
        .qa-info {
            display: flex;
            justify-content: space-between;
            font-size: 0.9em;
            color: #555;
            margin-top: 8px;
        }
        .qa-info span {
            margin-right: 10px;
        }
        .qa-content {
            padding: 20px 0;
            line-height: 1.8;
            color: #333;
            border-bottom: 1px dashed #ddd;
            white-space: pre-wrap;
        }
        .qa-answer {
            background-color: #f0f8ff;
            border: 1px solid #ddeeff;
            padding: 25px;
            margin-top: 20px;
            border-radius: 6px;
            white-space: pre-wrap;
        }
        .qa-answer h3 {
            color: #007b7f;
            margin-bottom: 15px;
            font-size: 1.4em;
        }
        .qa-buttons {
            text-align: right;
            margin-top: 30px;
        }
        .qa-buttons a,
        .qa-buttons button {
            background-color: #6c757d;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.95em;
            text-decoration: none;
            margin-left: 10px;
        }
        .qa-buttons .edit-btn {
            background-color: #007b7f;
        }
        .qa-buttons .delete-btn {
            background-color: #dc3545;
        }
        .qa-buttons a:hover,
        .qa-buttons button:hover {
            opacity: 0.85;
        }

        .reply-section {
            margin-top: 50px;
            padding-top: 30px;
            border-top: 2px solid #007b7f;
        }
        .reply-section h3 {
            font-size: 1.5em;
            margin-bottom: 20px;
            color: #007b7f;
        }
        .reply-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .reply-item {
            background-color: #fafafa;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 12px 16px;
            margin-bottom: 10px;
        }
        .reply-meta {
            display: flex;
            justify-content: space-between;
            font-size: 0.85em;
            color: #555;
            margin-bottom: 8px;
        }
        .reply-writer {
            font-weight: bold;
        }
        .reply-date {
            font-style: italic;
        }
        .reply-content {
            white-space: pre-wrap;
            color: #333;
            margin-top: 4px;
        }
        .reply-actions {
            margin-top: 10px;
        }
        .reply-actions .inline-form {
            display: inline;
            margin: 0 4px 0 0;
        }
        .reply-delete,
        .reply-edit {
            color: white;
            font-size: 0.8em;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            padding: 2px 6px;
            text-decoration: none;
        }
        .reply-delete {
            background-color: #dc3545;
        }
        .reply-edit {
            background-color: #007b7f;
        }
        .reply-delete:hover,
        .reply-edit:hover {
            opacity: 0.8;
        }
        .reply-form textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1em;
            color: #333;
            resize: vertical;
            min-height: 80px;
            box-sizing: border-box;
            margin-bottom: 10px;
        }
        .reply-form .reply-submit {
            align-self: flex-end;
            margin-top: 10px;
            padding: 8px 16px;
            background-color: #007b7f;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.95em;
        }
        .reply-form .reply-submit:hover {
            background-color: #005f6a;
        }
        .login-notice {
            color: gray;
            margin: 15px 0;
            font-size: 0.95em;
        }
        .no-reply {
            color: #555;
            font-size: 0.95em;
        }
    </style>
</head>
<body>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <div class="qa-detail-container">

        <c:if test="${not empty errorMessage}">
            <p style="color: red; text-align: center;">${errorMessage}</p>
        </c:if>

        <c:if test="${empty qna}">
            <div style="text-align: center; padding: 50px; color: #555;">
                <p>요청하신 Q&A를 찾을 수 없습니다.</p>
                <p><a href="${pageContext.request.contextPath}/qna/list" style="color: #007b7f; text-decoration: none;">목록으로 돌아가기</a></p>
            </div>
        </c:if>

        <c:if test="${not empty qna}">
            <div class="qa-detail-header">
                <h2>${qna.title}</h2>
                <div class="qa-info">
                    <span>작성자: ${qna.writer}</span>
                    <span>작성일: <fmt:formatDate value="${qna.regDate}" pattern="yyyy-MM-dd"/></span>
                    <span>조회수: ${qna.viewCount}</span>
                    <span>상태:
                        <c:choose>
                            <c:when test="${not empty qna.answer}">
                                답변 완료
                            </c:when>
                            <c:otherwise>
                                대기중
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>

            <div class="qa-content">${qna.content}</div>

            <c:if test="${not empty qna.answer}">
                <div class="qa-answer">
                    <h3>관리자 답변</h3>
                    <p>${qna.answer}</p>
                </div>
            </c:if>

            <div class="reply-section">
                <h3>댓글</h3>
            </div>

            <c:choose>
                <c:when test="${not empty replies}">
                    <ul class="reply-list">
                        <c:forEach var="reply" items="${replies}">
                            <li class="reply-item">
                                <div class="reply-meta">
                                    <span class="reply-writer">${reply.writer}</span>
                                    <span class="reply-date"><fmt:formatDate value="${reply.regDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                                </div>
                                <div class="reply-content">${reply.content}</div>
                                <c:if test="${reply.writer == sessionScope.loggedInMember.memberId or sessionScope.adminUser != null}">
                                    <div class="reply-actions">
                                        <form action="${pageContext.request.contextPath}/qna/reply/delete/${reply.replyId}"
                                              method="post" class="inline-form">
                                            <input type="hidden" name="qnaId" value="${qna.qnaId}" />
                                            <button type="submit" class="reply-delete"
                                                    onclick="return confirm('댓글을 삭제하시겠습니까?')">삭제</button>
                                        </form>
                                        <form method="get" class="inline-form">
                                            <input type="hidden" name="editReplyId" value="${reply.replyId}" />
                                            <button type="submit" class="reply-edit">수정</button>
                                        </form>
                                    </div>
                                </c:if>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p class="no-reply">등록된 댓글이 없습니다.</p>
                </c:otherwise>
            </c:choose>

            <c:if test="${not empty sessionScope.loggedInMember}">
                <form action="${pageContext.request.contextPath}/qna/reply/${qna.qnaId}" method="post" class="reply-form">
                    <textarea name="content" required placeholder="댓글을 입력하세요."></textarea>
                    <button type="submit" class="reply-submit">댓글 등록</button>
                </form>
            </c:if>
            <c:if test="${empty sessionScope.loggedInMember}">
                <p class="login-notice">※ 댓글을 작성하려면 <a href="${pageContext.request.contextPath}/member/login" style="color: #007b7f; text-decoration: none;">로그인</a>이 필요합니다.</p>
            </c:if>

            <div class="qa-buttons">
                <a href="${pageContext.request.contextPath}/qna/list">목록으로</a>
                <c:if test="${sessionScope.adminUser != null || sessionScope.loggedInMember.memberId == qna.writer}">
                    <a href="${pageContext.request.contextPath}/qna/edit/${qna.qnaId}" class="edit-btn">수정</a>
                    <form action="${pageContext.request.contextPath}/qna/delete/${qna.qnaId}" method="post" style="display:inline;">
                        <button type="submit" class="delete-btn" onclick="return confirm('정말로 삭제하시겠습니까?')">삭제</button>
                    </form>
                </c:if>
            </div>
        </c:if>

    </div>
</div>

<jsp:include page="../includes/footer.jsp" />
</body>
</html>
