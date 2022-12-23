package com.frogging.app.controller;

import java.nio.charset.Charset;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.frogging.app.service.QnaService;
import com.frogging.app.vo.CommunityVO;
import com.frogging.app.vo.PagingVO;
import com.frogging.app.vo.QnaVO;

@Controller
@RequestMapping("/qna/*")
public class QnaController {
	@Inject
	QnaService service;
	ModelAndView mav = null;
	
	@GetMapping("qnaList")
	public ModelAndView qnaList(PagingVO pVO) {
		
		mav = new ModelAndView();
		System.out.println(pVO.toString());
		pVO.setTotalRecord(service.totalRecord(pVO));
		mav.addObject("list", service.qnaList(pVO));
		mav.addObject("pVO", pVO);
		mav.setViewName("qna/qnaList");
		return mav;	
	}
	
	
	@GetMapping("qnaDetail")
	public ModelAndView qnaDetail(@RequestParam("no") int no, QnaVO VO) {
		service.hitCount(no);
		mav = new ModelAndView();
		
		mav.addObject("vo", service.getQna(no));
		mav.addObject("VO", VO);
		mav.setViewName("qna/qnaDetail");
		mav.addObject("reply_group", VO);
		return mav;
	}
	
	
	
	@GetMapping("qnaWrite")
	public ModelAndView qnaWrite() {
		mav	= new ModelAndView();
		mav.setViewName("qna/qnaWrite");
		return mav;
	}
	
	@PostMapping("qnaWriteOk")
	public ResponseEntity<String> qnaWriteOk(QnaVO vo, HttpServletRequest request){		
		vo.setId((String)request.getSession().getAttribute("logId"));
		
		
		String msg="<script>";
		try {
			service.qnaWriteOk(vo);
			msg += "location.href='/qna/qnaList';";
		}catch(Exception e) {
			msg += "alert('글등록이 실패하였습니다.');";
			msg += "history.go(-1);";
			e.printStackTrace();
		}
		msg += "</script>";
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=UTF-8");
		ResponseEntity<String> entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
		return entity;
	}
	
	
	//글삭제
	@GetMapping("qnaDel")
	public ModelAndView qnaDel(int reply_group, HttpSession session) {
		int cnt = service.qnaDel(reply_group,(String)session.getAttribute("logId")); //logId 
		mav = new ModelAndView();

		if(cnt>0) {
			mav.setViewName("redirect:/admin/qnaList");
		}else {
			mav.setViewName("redirect:qnaDetail");
		}
		return mav;
	}
	
	@GetMapping("qnaDel2")
	public ModelAndView qnaDel2(int no, HttpSession session) {
		int cnt = service.qnaDel2(no,(String)session.getAttribute("logId")); //logId 
		mav = new ModelAndView();

		if(cnt>0) {
			mav.setViewName("redirect:/admin/qnaList");
		}else {
			mav.setViewName("redirect:qnaDetail");
		}
		return mav;
	}
	
	//글수정
	@GetMapping("qnaEdit/{no}")
	public ModelAndView qnaEdit(@PathVariable("no") int no) {
		
		mav = new ModelAndView();
		
		mav.addObject("vo", service.getQna(no));
		mav.setViewName("qna/qnaEdit");
		
		return mav;
	}
	//글수정 :DB
	@PostMapping("qnaEditOk")
	public ResponseEntity<String> qnaEditOk(QnaVO vo, HttpSession session){
		//세션의 아이디를 구한다.
		vo.setId((String)session.getAttribute("logId")); //logId
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=UTF-8");
		String msg = "<script>";
		try {
			int cnt = service.qnaEditOk(vo);
			System.out.println(cnt);
			//수정되었을때 -글내용보기
			msg += "alert('글이 수정되었습니다. 글내용보기로 이동합니다.');";
			msg += "location.href='/qna/qnaDetail?no="+vo.getNo()+"';";			
		}catch(Exception e) {
			e.printStackTrace();
			
			msg += "alert('글수정 실패하였습니다.');";
			msg += "history.go(-1);";
		}
		msg += "</script>";		
		return new ResponseEntity<String>(msg, headers, HttpStatus.OK);
	}
	//답글 쓰기 뷰
	@GetMapping("qnaReply")
	public ModelAndView qnaReply(@RequestParam("no") int no, QnaVO VO) {//HttpServletRequest request, HttpServletResponse response
		mav	= new ModelAndView();
		mav.addObject("vo", service.qnaReply(no));
		mav.addObject("VO", VO);
		mav.setViewName("qna/qnaReply");
		
		return mav;
	}
	//답글 저장
	@PostMapping("qnaReplyOk")
	public ResponseEntity<String> qnaReplyOk(QnaVO vo, HttpServletRequest request){		
		
		vo.setId((String)request.getSession().getAttribute("logId"));
		mav.addObject("reply_group", vo);
		mav.addObject("depth", vo);
	
		//QnaVO qvo = service.getQnaReplyInfo(vo);
		
		//vo.setDepth(qvo.getDepth()+1);
		//vo.setReply_group(qvo.getReply_group());
		//vo.setReply_seq(qvo.getReply_seq()+1);
		
		service.qnaUpdate(vo);
		
		
		
		
		
		String msg="<script>";
		try {
			service.qnaReplyOk(vo);
			msg += "location.href='/qna/qnaList';";
		}catch(Exception e) {
			msg += "alert('글등록이 실패하였습니다.');";
			msg += "history.go(-1);";
			e.printStackTrace();
		}
		msg += "</script>";
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=UTF-8");
		ResponseEntity<String> entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);
		return entity;
	}
}
