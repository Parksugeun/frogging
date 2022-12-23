package com.frogging.app.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.frogging.app.service.CommunityReplyService;
import com.frogging.app.vo.CommunityReplyVO;

@RestController 
@RequestMapping("/reply/*")
public class CommunityReplyController {
	
	@Autowired
	CommunityReplyService service;
	ModelAndView mav = null;
	//댓글 쓰기
	@PostMapping("replyWrite")
	public int replyWrite(CommunityReplyVO vo, HttpSession session) {
		
		vo.setId((String)session.getAttribute("logId"));

		return service.replyInsert(vo);
	}
	//댓글목록 선택
	@GetMapping("replyList")
	public List<CommunityReplyVO> replyList(int no) {
		return service.replyList(no);
	}
	//댓글 수정
	@PostMapping("replyEdit")
	public int replyEdit(CommunityReplyVO vo, HttpSession session2) {
		vo.setId((String)session2.getAttribute("logId"));
		return service.replyUpdate(vo);
	}
	//댓글 삭제
	@GetMapping("replyDel")
	public int replyDel(int reply_no, HttpSession session3) {
		String id = (String)session3.getAttribute("logId");
		return service.replyDelete(reply_no, id);
	}
	
	//답글 작성
	@PostMapping("reReplyInsert")
	public int reReplyInsert(CommunityReplyVO vo, HttpServletRequest request) {// reply_no, content
		//vo.setId((String)session4.getAttribute("logId"));
		vo.setId((String)request.getSession().getAttribute("logId"));// id
		CommunityReplyVO cvo = service.replyInfo(vo);//원글의 no, depth, reply_group
		
		vo.setReply_group(cvo.getReply_group());// reply_group
		vo.setNo(cvo.getNo());
		
		vo.setDepth(cvo.getDepth()+1); // depth

		return service.reReplyInsert(vo);
	}	

}
