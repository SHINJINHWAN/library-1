package com.library.service;

import com.library.qna.Qna;
import com.library.qna.QnaDAO;
import com.library.qna.Reply;
import com.library.qna.ReplyDAO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QnaServiceImpl implements QnaService {

    private final QnaDAO qnaDAO;
    private final ReplyDAO replyDAO;

    public QnaServiceImpl(QnaDAO qnaDAO, ReplyDAO replyDAO) {
        this.qnaDAO = qnaDAO;
        this.replyDAO = replyDAO;
    }

    // QnA CRUD
    @Override
    public void createQna(Qna qna) {
        qnaDAO.insertQna(qna);
    }

    @Override
    public void updateQna(Qna qna) {
        qnaDAO.updateQna(qna);
    }

    @Override
    public void deleteQna(int qnaId) {
        qnaDAO.deleteQna(qnaId);
    }

    @Override
    public Qna getQnaById(int qnaId) {
        qnaDAO.increaseViewCount(qnaId); // 조회수 증가
        return qnaDAO.getQnaById(qnaId);
    }

    @Override
    public List<Qna> getQnasBySearch(String keyword, String category, String sort, int page, int pageSize) {
        return qnaDAO.getQnasBySearch(keyword, category, sort, page, pageSize);
    }


    @Override
    public int getTotalCountBySearch(String keyword, String category) {
        return qnaDAO.getTotalCountBySearch(keyword, category);
    }
    // 답변
    @Override
    public void updateAnswer(int qnaId, String answer) {
        qnaDAO.updateAnswer(qnaId, answer);
    }

    // 댓글
    @Override
    public List<Reply> getRepliesByQnaId(int qnaId) {
        return replyDAO.getRepliesByQnaId(qnaId);
    }

    @Override
    public Reply getReplyById(int replyId) {
        return replyDAO.getReplyById(replyId);
    }

    @Override
    public void createReply(Reply reply) {
        replyDAO.insertReply(reply);
    }

    @Override
    public void updateReply(Reply reply) {
        replyDAO.updateReply(reply);
    }

    @Override
    public void deleteReply(int replyId) {
        replyDAO.deleteReply(replyId);
    }
}
