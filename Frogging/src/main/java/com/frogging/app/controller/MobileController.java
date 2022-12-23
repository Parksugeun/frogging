package com.frogging.app.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.frogging.app.service.ActivityService;
import com.frogging.app.service.MapsService;
import com.frogging.app.service.UserService;
import com.frogging.app.vo.ActivityVO;
import com.frogging.app.vo.CoursePagingVO;
import com.frogging.app.vo.CourseVO;

@Controller
@RequestMapping("/mobile/*")
public class MobileController {
	
	@Inject
	MapsService m_service;
	
	@Inject
	ActivityService a_service;
	
	@Inject
	UserService u_service;
	
	ModelAndView mav = null;
	
	@GetMapping("mobileHome")
	public ModelAndView mobileHome(String id) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/mobile/mobileHome");
		return mav;
	}
	
	@GetMapping("mobileStart")
	public ModelAndView mobileStart(String id) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/mobile/mobileStart");
		return mav;
	}
	
	@GetMapping("maps/geolocation01/{course_no}")
	public ModelAndView geolocation01(@PathVariable("course_no") int course_no, HttpServletRequest request) {
		
		mav = new ModelAndView();
		
		String id = (String)request.getSession().getAttribute("logId");
		
		System.out.println(id);
		int result = m_service.courseCheck(course_no);
		if(result == 0) {
			CourseVO cvo = new CourseVO();
			cvo.setCourse_no(-1);
			mav.addObject("course", cvo);
		} else {
			mav.addObject("course", m_service.courseSelect(course_no));
			mav.addObject("courseDetail", m_service.detailSelect(course_no));
		}
		
		mav.setViewName("maps/geolocation01");
		return mav;
	}
	
	@PostMapping("activityOk/{course_no}")
	@ResponseBody
	public void activityOk(@PathVariable("course_no") int course_no,
						@RequestParam("lat[]") List<String> lat, 
						@RequestParam("log[]") List<String> log, 
						ActivityVO avo,
						HttpServletRequest request,
						HttpSession session) {
		int result1 = 0;
		int result2 = 0;
		int waypoint = 0;
		int activity_no = 0;
		CourseVO cvo = m_service.courseSelect(course_no);
		
		String id = (String)request.getSession().getAttribute("logId");
		
		avo.setId(id);
		avo.setCourse_name(cvo.getCourse_name());
		avo.setCourse_no(course_no);
		
		int height = u_service.getUserDetail(id).getHeight();
		int step = (int)(avo.getDistance() * 1000 / (height * 0.37 / 100));
		
		avo.setStep(step);
		
		result1 = a_service.activityInsert(avo);
		activity_no = a_service.getActivityNo(id);
		
		for(int i = 0; i < lat.size(); i++) {
			result2 = a_service.courseuserInsert(course_no, id, i, lat.get(i), log.get(i), activity_no);
			if(result2 > 0) {
				System.out.println("유저 이동 경유지 등록 성공");
				result2 = 0;
			}
			waypoint++;
		}
	}
	
	@GetMapping("mobileList")
	@ResponseBody
	public ModelAndView mobileList(CoursePagingVO cpvo) {
		
		int[] coursenoList = {0,0,0,0,0,0};
		
		ModelAndView mav = new ModelAndView();
		
		cpvo.setOnePageRecord(3);
		cpvo.setTotalRecord(m_service.totalCourse(cpvo));

		List<CourseVO> courseList = m_service.courseAllselect_t(cpvo);

		for(int i = 0; i < courseList.size(); i++) {
			coursenoList[i] = courseList.get(i).getCourse_no();
		}
		
		mav.addObject("courseList", courseList);
		mav.addObject("cpvo", cpvo);
		mav.addObject("courseDetail",
				m_service.detailAllselect_t(
				coursenoList[0], 
				coursenoList[1],
				coursenoList[2],
				coursenoList[3],
				coursenoList[4],
				coursenoList[5])
				);
		
		mav.setViewName("/mobile/mobileList");
		return mav;
	}
}