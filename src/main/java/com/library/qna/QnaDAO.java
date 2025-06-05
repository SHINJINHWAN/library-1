package com.library.qna;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class QnaDAO {
    private final JdbcTemplate jdbcTemplate;

    public QnaDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private Qna mapRowToQna(ResultSet rs, int rowNum) throws SQLException {
        Qna qna = new Qna();
        qna.setQnaId(rs.getInt("qna_id"));
        qna.setTitle(rs.getString("title"));
        qna.setContent(rs.getString("content"));
        qna.setWriter(rs.getString("writer"));
        qna.setRegDate(rs.getTimestamp("reg_date"));
        qna.setModifiedDate(rs.getTimestamp("modified_date"));
        qna.setStatus(rs.getString("status"));
        qna.setViewCount(rs.getInt("view_count"));
        qna.setPassword(rs.getString("password"));
        qna.setOpenYn(rs.getString("open_yn"));
        qna.setCategory(rs.getString("category"));
        qna.setAnswer(rs.getString("answer"));
        qna.setAnswerRegDate(rs.getTimestamp("answer_reg_date"));
        qna.setDeletedYn(rs.getString("deleted_yn"));
        return qna;
    }

    // ✅ QnA 글 작성
    public int insertQna(Qna qna) {
        String sql = "INSERT INTO qna (title, content, writer, password, status, open_yn, category, reg_date, view_count, deleted_yn) " +
                     "VALUES (?, ?, ?, ?, '대기중', ?, ?, NOW(), 0, 'N')";
        return jdbcTemplate.update(sql,
                qna.getTitle(), qna.getContent(), qna.getWriter(),
                qna.getPassword(), qna.getOpenYn(), qna.getCategory());
    }

    // ✅ QnA 글 1개 조회
    public Qna getQnaById(int qnaId) {
        String sql = "SELECT * FROM qna WHERE qna_id = ?";
        try {
            return jdbcTemplate.queryForObject(sql, this::mapRowToQna, qnaId);
        } catch (Exception e) {
            return null;
        }
    }

    // ✅ QnA 글 전체 목록 조회
    public List<Qna> getAllQnas() {
        String sql = "SELECT * FROM qna WHERE deleted_yn = 'N' ORDER BY qna_id DESC";
        return jdbcTemplate.query(sql, this::mapRowToQna);
    }

    // ✅ QnA 글 수정
    public int updateQna(Qna qna) {
        String sql = "UPDATE qna SET title = ?, content = ?, status = ?, password = ?, open_yn = ?, category = ?, modified_date = NOW() WHERE qna_id = ?";
        return jdbcTemplate.update(sql,
                qna.getTitle(), qna.getContent(), qna.getStatus(),
                qna.getPassword(), qna.getOpenYn(), qna.getCategory(), qna.getQnaId());
    }

    // ✅ QnA 글 삭제 (논리 삭제)
    public int deleteQna(int qnaId) {
        String sql = "UPDATE qna SET deleted_yn = 'Y' WHERE qna_id = ?";
        return jdbcTemplate.update(sql, qnaId);
    }

    // ✅ QnA 조회수 증가
    public int increaseViewCount(int qnaId) {
        String sql = "UPDATE qna SET view_count = view_count + 1 WHERE qna_id = ?";
        return jdbcTemplate.update(sql, qnaId);
    }

    // ✅ QnA 상태 업데이트
    public int updateStatus(int qnaId, String status) {
        String sql = "UPDATE qna SET status = ? WHERE qna_id = ?";
        return jdbcTemplate.update(sql, status, qnaId);
    }

    // ✅ QnA 답변 등록/수정
    public int updateAnswer(int qnaId, String answer) {
        String sql = "UPDATE qna SET answer = ?, answer_reg_date = NOW() WHERE qna_id = ?";
        return jdbcTemplate.update(sql, answer, qnaId);
    }

    // ✅ 전체 글 수 조회
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM qna WHERE deleted_yn = 'N'";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    // ✅ 페이징된 글 목록
    public List<Qna> getQnaByPage(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        String sql = "SELECT * FROM qna WHERE deleted_yn = 'N' ORDER BY qna_id DESC LIMIT ? OFFSET ?";
        return jdbcTemplate.query(sql, this::mapRowToQna, pageSize, offset);
    }

    // ✅ 검색 + 카테고리 + 정렬 + 페이징
    public List<Qna> getQnasBySearch(String keyword, String category, String sort, int page, int pageSize) {
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM qna WHERE deleted_yn = 'N'");

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (title LIKE ? OR content LIKE ? OR writer LIKE ?)");
            String kw = "%" + keyword + "%";
            params.add(kw);
            params.add(kw);
            params.add(kw);
        }

        if (category != null && !category.isEmpty()) {
            sql.append(" AND category = ?");
            params.add(category);
        }

        if ("views".equals(sort)) {
            sql.append(" ORDER BY view_count DESC");
        } else {
            sql.append(" ORDER BY qna_id DESC");
        }

        sql.append(" LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        return jdbcTemplate.query(sql.toString(), this::mapRowToQna, params.toArray());
    }

    // ✅ 검색 결과 수
    public int getTotalCountBySearch(String keyword, String category) {
        List<Object> params = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM qna WHERE deleted_yn = 'N'");

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (title LIKE ? OR content LIKE ? OR writer LIKE ?)");
            String kw = "%" + keyword + "%";
            params.add(kw);
            params.add(kw);
            params.add(kw);
        }

        if (category != null && !category.isEmpty()) {
            sql.append(" AND category = ?");
            params.add(category);
        }

        return jdbcTemplate.queryForObject(sql.toString(), Integer.class, params.toArray());
    }
}
