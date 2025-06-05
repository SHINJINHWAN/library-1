package com.library.qna;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAO {

    private final JdbcTemplate jdbcTemplate;

    public ReplyDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Row 매핑
    private Reply mapRowToReply(ResultSet rs, int rowNum) throws SQLException {
        Reply reply = new Reply();
        reply.setReplyId(rs.getInt("reply_id"));
        reply.setQnaId(rs.getInt("qna_id"));
        reply.setWriter(rs.getString("writer"));
        reply.setContent(rs.getString("content"));
        reply.setRegDate(rs.getTimestamp("reg_date"));
        return reply;
    }

    // ✅ 댓글 목록 조회 (QnA ID 기준)
    public List<Reply> getRepliesByQnaId(int qnaId) {
        String sql = "SELECT * FROM reply WHERE qna_id = ? ORDER BY reg_date ASC";
        return jdbcTemplate.query(sql, this::mapRowToReply, qnaId);
    }

    // ✅ 댓글 1건 조회
    public Reply getReplyById(int replyId) {
        String sql = "SELECT * FROM reply WHERE reply_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, this::mapRowToReply, replyId);
        } catch (Exception e) {
            return null;
        }
    }

    // ✅ 댓글 등록
    public int insertReply(Reply reply) {
        String sql = "INSERT INTO reply (qna_id, writer, content, reg_date) VALUES (?, ?, ?, NOW())";
        return jdbcTemplate.update(sql, reply.getQnaId(), reply.getWriter(), reply.getContent());
    }

    // ✅ 댓글 수정
    public int updateReply(Reply reply) {
        String sql = "UPDATE reply SET content = ? WHERE reply_id = ?";
        return jdbcTemplate.update(sql, reply.getContent(), reply.getReplyId());
    }

    // ✅ 댓글 삭제
    public int deleteReply(int replyId) {
        String sql = "DELETE FROM reply WHERE reply_id = ?";
        return jdbcTemplate.update(sql, replyId);
    }
}
