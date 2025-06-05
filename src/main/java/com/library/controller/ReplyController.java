package com.library.controller;

import com.library.qna.Reply;
import com.library.member.MemberVO;
import com.library.service.ReplyService;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/reply")
public class ReplyController {

    private final ReplyService replyService;

    public ReplyController(ReplyService replyService) {
        this.replyService = replyService;
    }

    // ✅ 댓글 작성 처리
    @PostMapping("/add")
    public String addReply(@ModelAttribute Reply reply,
                           HttpSession session,
                           @RequestParam("qnaId") int qnaId,
                           RedirectAttributes redirectAttributes) {

        MemberVO member = (MemberVO) session.getAttribute("loggedInMember");
        if (member == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        if (reply.getContent() == null || reply.getContent().trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "댓글 내용은 비워둘 수 없습니다.");
            return "redirect:/qna/detail/" + qnaId;
        }

        reply.setQnaId(qnaId);
        reply.setWriter(member.getMemberId());

        replyService.addReply(reply);
        return "redirect:/qna/detail/" + qnaId;
    }

    // ✅ 댓글 삭제
    @PostMapping("/delete")
    public String deleteReply(@RequestParam("replyId") int replyId,
                              @RequestParam("qnaId") int qnaId,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {

        MemberVO member = (MemberVO) session.getAttribute("loggedInMember");
        if (member == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        Reply reply = replyService.getReplyById(replyId);
        if (reply != null &&
            (reply.getWriter().equals(member.getMemberId()) || "admin".equals(member.getMemberId()))) {
            replyService.deleteReply(replyId);
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "댓글 삭제 권한이 없습니다.");
        }

        return "redirect:/qna/detail/" + qnaId;
    }

    // ✅ 댓글 수정 처리
    @PostMapping("/update")
    public String updateReply(@ModelAttribute Reply reply,
                              HttpSession session,
                              @RequestParam("qnaId") int qnaId,
                              RedirectAttributes redirectAttributes) {

        MemberVO member = (MemberVO) session.getAttribute("loggedInMember");
        if (member == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/login";
        }

        Reply existingReply = replyService.getReplyById(reply.getReplyId());
        if (existingReply != null && existingReply.getWriter().equals(member.getMemberId())) {
            replyService.updateReply(reply);
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "댓글 수정 권한이 없습니다.");
        }

        return "redirect:/qna/detail/" + qnaId;
    }
}
