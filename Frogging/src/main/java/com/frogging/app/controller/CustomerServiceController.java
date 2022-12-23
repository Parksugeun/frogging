package com.frogging.app.controller;

import java.nio.charset.Charset;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
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

import com.frogging.app.service.CustomerServiceService;
import com.frogging.app.vo.CustomerServiceVO;
import com.frogging.app.vo.PagingVO;

@Controller
@RequestMapping("/customerService/*")
public class CustomerServiceController {
	@Inject
	CustomerServiceService service;
	ModelAndView mav = null;
	
	//고객센터 리스트
	@GetMapping("customerServiceList")
	public ModelAndView customerServiceList(PagingVO pVO) {
		
		mav = new ModelAndView();
		System.out.println(pVO.toString());
		pVO.setTotalRecord(service.totalRecord(pVO));
		mav.addObject("list", service.customerServiceList(pVO));
		mav.addObject("pVO", pVO);
		mav.setViewName("customerService/customerServiceList");
		return mav;	
	}
	
	//고객센터 글내용
	@GetMapping("customerServiceDetail")
	public ModelAndView customerServiceDetail(@RequestParam("no") int no, CustomerServiceVO VO) {
		service.hitCount(no);
		mav = new ModelAndView();
		
		mav.addObject("vo", service.getcustomerService(no));
		mav.addObject("VO", VO);
		mav.setViewName("customerService/customerServiceDetail");
		mav.addObject("reply_group", VO);
		return mav;
	}
	
	
	//고객센터 글쓰기
	@GetMapping("customerServiceWrite")
	public ModelAndView customerServiceWrite() {
		mav	= new ModelAndView();
		mav.setViewName("customerService/customerServiceWrite");
		return mav;
	}
	
	
	@PostMapping("customerServiceWriteOk")
	public ResponseEntity<String> customerServiceWriteOk(CustomerServiceVO vo, HttpServletRequest request){		
		vo.setId((String)request.getSession().getAttribute("logId"));
		
		
		String msg="<script>";
		try {
			service.customerServiceWriteOk(vo);
			msg += "location.href='/customerService/customerServiceList';";
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
	
	
	//고객센터 글삭제
	@GetMapping("customerServiceDel")
	public ModelAndView customerServiceDel(int reply_group, HttpSession session) {
		int cnt = service.customerServiceDel(reply_group,(String)session.getAttribute("logId")); 
		mav = new ModelAndView();
		if(cnt>0) {
			mav.setViewName("redirect:/admin/customerServiceList");
		}else {
			mav.setViewName("redirect:customerServiceDetail");
		}
		return mav;
	}
	
	@GetMapping("customerServiceDel2")
	public ModelAndView customerServiceDel2(int no, HttpSession session) {
		int cnt = service.customerServiceDel2(no,(String)session.getAttribute("logId")); 
		mav = new ModelAndView();
		if(cnt>0) {
			mav.setViewName("redirect:/admin/customerServiceList");
		}else {
			mav.setViewName("redirect:customerServiceDetail");
		}
		return mav;
	}
	//고객센터 글수정
	@GetMapping("customerServiceEdit/{no}")
	public ModelAndView customerServiceEdit(@PathVariable("no") int no) {
		
		mav = new ModelAndView();
		
		mav.addObject("vo", service.getcustomerService(no));
		mav.setViewName("customerService/customerServiceEdit");
		
		return mav;
	}
	//글수정 :DB
	@PostMapping("customerServiceEditOk")
	public ResponseEntity<String> customerServiceEditOk(CustomerServiceVO vo, HttpSession session){
		//세션의 아이디를 구한다.
		vo.setId((String)session.getAttribute("logId")); //logId
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=UTF-8");
		String msg = "<script>";
		try {
			int cnt = service.customerServiceEditOk(vo);
			System.out.println(cnt);
			//수정되었을때 -글내용보기
			msg += "alert('글이 수정되었습니다. 글내용보기로 이동합니다.');";
			msg += "location.href='/customerService/customerServiceDetail?no="+vo.getNo()+"';";			
		}catch(Exception e) {
			e.printStackTrace();
			
			msg += "alert('글수정 실패하였습니다.');";
			msg += "history.go(-1);";
		}
		msg += "</script>";		
		return new ResponseEntity<String>(msg, headers, HttpStatus.OK);
	}
	//관리자 답글
	@GetMapping("customerServiceReply")
	public ModelAndView customerServiceReply(@RequestParam("no") int no, CustomerServiceVO VO) {
		mav	= new ModelAndView();
		mav.addObject("vo", service.customerServiceReply(no));
		mav.addObject("VO", VO);
		mav.setViewName("customerService/customerServiceReply");
		
		return mav;
	}
	//답글 저장
	@PostMapping("customerServiceReplyOk")
	public ResponseEntity<String> customerServiceReplyOk(CustomerServiceVO vo, HttpServletRequest request){		
		
		vo.setId((String)request.getSession().getAttribute("logId"));
		mav.addObject("reply_group", vo);
		mav.addObject("depth", vo);			
		
		String msg="<script>";
		try {
			service.customerServiceReplyOk(vo);
			msg += "location.href='/customerService/customerServiceList';";
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
