package com.frogging.app.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor{
	//컨트롤러가 호출되기전에 인터셉터하는 메소드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//로그인 여부 확인하기
		HttpSession session = request.getSession();
		
		//session에서 로그인 정보를 구해온다
		String logStatus = (String)session.getAttribute("logStatus");// null, Y
		
		if(logStatus!=null && (logStatus.equals("Y")||logStatus.equals("Admin"))) {
			//로그인 상태일때
			return true;
		}else {
			//로그인 안된경우
		    try {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter w = response.getWriter();
				w.write("<script>alert('로그인이 필요한 서비스입니다. 로그인페이지로 이동합니다');location.href='/login';</script>");
				w.flush();
				w.close();
		    } catch(Exception e) {
				e.printStackTrace();
		    }
			
			return false;
		}
		
	}
	
	//postHandle()
	//afterCompletion()
}
