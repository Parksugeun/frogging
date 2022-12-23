package com.frogging.app.controller;

import java.nio.charset.Charset;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.frogging.app.service.LoginService;
import com.frogging.app.vo.UserVO;

@Controller
public class LoginController {
	@Autowired
	LoginService service;
	ModelAndView mav = new ModelAndView();

	@GetMapping("login")
	public ModelAndView memberForm() {

		mav.setViewName("login/login");
		return mav;
	}

	@GetMapping("login/loginOk")
	public ModelAndView loginOk(String id, String name, HttpSession session) {
		mav = new ModelAndView();

		UserVO vo = new UserVO();
		vo.setId(id);
		vo.setName(name);

		// db 확인
		int result = service.loginCheck(id);
		int cAdmin;
		if (result == 0) {
			System.out.println("신규회원");
			// 회원아님 -> 회원가입
			mav.addObject("vo", vo);
			mav.setViewName("login/signAgree");

		} else if (result == 1) {
			System.out.println("기존회원");
			// 회원임 -> 로그인 절차
			vo = service.loginOk(id);
			cAdmin = service.checkAdmin(id);
			if (cAdmin == 0) {
				session.setAttribute("logId", id);
				session.setAttribute("logNickName", vo.getNickname());
				session.setAttribute("logStatus", "Y");
				mav.setViewName("redirect:/");
			} else {
				session.setAttribute("logId", id);
				session.setAttribute("logNickName", "관리자");
				session.setAttribute("logStatus", "Admin");
				mav.setViewName("redirect:/");
			}

		} else {
			// 예외
			mav.setViewName("redirect:/");
		}

		return mav;
	}

	// 회원가입하기
	@PostMapping("signUpOk")
	public ResponseEntity<String> signUpOk(UserVO vo) {
		// RestController에서는 ResponseBody를 보낼 수 있다.
		// 클라이언트에게 데이터와 뷰파일을 담을 수 있는 뷰페이지를 별도로 만들 필요가 없다.
		ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=utf-8");

		try {// 회원등록-> 로그인폼으로 이동
			vo.setRestriction(0);
			service.signUpOk(vo);

			String msg = "<script>";
			msg += "alert('회원가입이 성공하였습니다.');";
			msg += "location.href='/'";
			msg += "</script>";

			entity = new ResponseEntity<String>(msg, headers, HttpStatus.OK);// 성공:200
		} catch (Exception e) {// 회원등록 실패 -> 이전페이지(history:자바스크립트)
			String msg = "<script>";
			msg += "alert('회원가입이 실패하였습니다.');";
			msg += "history.back();";
			msg += "</script>";
			entity = new ResponseEntity<String>(msg, headers, HttpStatus.BAD_REQUEST);

			e.printStackTrace();
		}
		return entity;
	}

	// 회원가입 1 약관동의
	@GetMapping("login/agreeOk")
	public ModelAndView nextSignin(UserVO vo) {
		mav = new ModelAndView();
		mav.addObject("vo", vo);
		mav.setViewName("login/signUp");
		return mav;
	}

	// id중복검사
	@PostMapping("login/nicknameCheck")
	@ResponseBody
	public String nicknameChk(String nickname) throws Exception {
		int result = service.nicknameCheck(nickname);

		if (result != 0) {
			return "fail";
		} else {
			return "success";
		}
	}

	@GetMapping("logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();// 세션의 로그인 정보를 제거
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
	}

}
