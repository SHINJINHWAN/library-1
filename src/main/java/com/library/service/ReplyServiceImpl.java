package com.library.service;

import com.library.qna.Reply;
import com.library.qna.ReplyDAO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyServiceImpl implements ReplyService {

    private final ReplyDAO replyDAO;

    public ReplyServiceImpl(ReplyDAO replyDAO) {
        this.replyDAO = replyDAO;
    }

    @Override
    public List<Reply> getRepliesByQnaId(int qnaId) {
        return replyDAO.getRepliesByQnaId(qnaId);
    }

    @Override
    public Reply getReplyById(int replyId) {
        return replyDAO.getReplyById(replyId);
    }

    @Override
    public void addReply(Reply reply) {
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
