package com.library.borrow;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BorrowDAO {
    
    private JdbcTemplate jdbcTemplate;

    public BorrowDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // 대출 정보 저장
    public void save(Borrow borrow) {
        String sql = "INSERT INTO borrow (user_id, book_seq_no, borrow_date) VALUES (?, ?, ?)";
        String update = "update book SET portal_site_book_exst_at = 'N' WHERE seq_no = ?";
        jdbcTemplate.update(sql, borrow.getUserId(), borrow.getBookSeqNo(), borrow.getBorrowDate());
        jdbcTemplate.update(update,borrow.getBookSeqNo());
    }

    // 사용자가 도서를 대출했는지 확인
    public boolean existsByUserIdAndBookSeqNo(String userId, Long bookSeqNo) {
        String sql = "SELECT COUNT(*) FROM borrow WHERE user_id = ? AND book_seq_no = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, userId, bookSeqNo);
        return count != null && count > 0;
    }
}