<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 댓글 섹션 -->
<div class="reply-section">
    <h3>댓글</h3>

    <!-- 댓글 작성 폼 -->
    <c:if test="${not empty loggedInMember}">
        <form action="${pageContext.request.contextPath}/reply/add" method="post" class="reply-form">
            <input type="hidden" name="qnaId" value="${qna.qnaId}">
            <input type="hidden" name="writer" value="${loggedInMember.name}">
            <textarea name="content" placeholder="댓글을 입력하세요" required></textarea>
            <button type="submit" class="reply-submit">등록</button>
        </form>
    </c:if>
    <c:if test="${empty loggedInMember}">
        <p class="login-notice">※ 댓글을 작성하려면 로그인하세요.</p>
    </c:if>

    <!-- 댓글 목록 -->
    <c:choose>
        <c:when test="${not empty replyList}">
            <ul class="reply-list">
                <c:forEach var="reply" items="${replyList}">
                    <li class="reply-item">
                        <div class="reply-meta">
                            <span class="reply-writer">${reply.writer}</span>
                            <span class="reply-date"><fmt:formatDate value="${reply.regDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                        </div>
                        <div class="reply-content">${reply.content}</div>
                        <c:if test="${loggedInMember.name eq reply.writer || loggedInMember.role eq 'ADMIN'}">
                            <div class="reply-actions">
                                <form action="${pageContext.request.contextPath}/reply/delete" method="post" class="inline-form">
                                    <input type="hidden" name="replyId" value="${reply.replyId}">
                                    <input type="hidden" name="qnaId" value="${qna.qnaId}">
                                    <button type="submit" class="reply-delete" onclick="return confirm('댓글을 삭제하시겠습니까?')">삭제</button>
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
</div>

<!-- 이 페이지가 include되는 상단(header.jsp)보다 아래에 추가하거나,
     detail.jsp 등의 상단에 직접 붙여넣으셔도 됩니다. -->
<style>
    /* 댓글 섹션 전체 */
    .reply-section {
        margin-top: 40px;
        padding-top: 30px;
        border-top: 2px solid #007b7f;
    }
    .reply-section h3 {
        font-size: 1.5em;
        margin-bottom: 20px;
        color: #007b7f;
    }

    /* 댓글 작성 폼 */
    .reply-form {
        display: flex;
        flex-direction: column;
        margin-bottom: 30px;
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

    /* 댓글 목록 */
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

    /* 댓글 삭제 버튼 */
    .reply-actions {
        margin-top: 10px;
    }
    .reply-actions .inline-form {
        display: inline;
    }
    .reply-delete {
        background: none;
        border: none;
        color: #dc3545;
        font-size: 0.9em;
        cursor: pointer;
        padding: 0;
    }
    .reply-delete:hover {
        text-decoration: underline;
    }

    /* 댓글이 없을 때 문구 */
    .no-reply {
        color: #555;
        font-size: 0.95em;
    }
</style>
