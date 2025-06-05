package com.library.service;

import com.library.qna.Reply;
import java.util.List;

public interface ReplyService {
    List<Reply> getRepliesByQnaId(int qnaId);       // QnA 글에 달린 전체 댓글
    Reply getReplyById(int replyId);                // 특정 댓글 조회
    void addReply(Reply reply);                     // 댓글 추가
    void updateReply(Reply reply);                  // 댓글 수정
    void deleteReply(int replyId);                  // 댓글 삭제
}