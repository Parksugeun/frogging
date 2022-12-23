package com.frogging.app.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.frogging.app.service.ActivityService;
import com.frogging.app.service.MapsService;
import com.frogging.app.service.PartyService;
import com.frogging.app.service.UserService;
import com.frogging.app.vo.ActivityPagingVO;
import com.frogging.app.vo.ActivityVO;
import com.frogging.app.vo.CoursePagingVO;
import com.frogging.app.vo.CourseVO;
import com.frogging.app.vo.MyPagingVO;
import com.frogging.app.vo.UserVO;

import java.nio.charset.Charset;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@RestController
@RequestMapping("/mypage/*")
public class MypageController {

	ModelAndView mav = null;

	@Inject
	ActivityService a_serivce;

	@Inject
	UserService u_service;

	@Inject
	PartyService p_service;

	@Inject
	MapsService m_service;

	// 마이페이지
	@GetMapping(value = "/my")
	public ModelAndView getMy(HttpSession session) {

		mav = new ModelAndView();

		String id = (String) session.getAttribute("logId");
		// System.out.println(id);
		// 랭킹 정보

		try {
			// 액티비티 내역이 있으면?
			mav.addObject("plog_count", a_serivce.getRank_p(id).getRownum());
			mav.addObject("distance", a_serivce.getRank_k(id).getRownum());

		} catch (Exception e) {
			mav.addObject("plog_count", "-");
			mav.addObject("distance", "-");
		}

		// System.out.println(a_serivce.getRank_p(id).getRownum() + "/" +
		// a_serivce.getRank_k(id).getRownum());
		// 내가 쓴 글 (커뮤니티 + 큐앤애이)
		mav.addObject("c_list", u_service.getMyWrite(id));
		mav.addObject("q_list", u_service.getMyWrite_qna(id));
		mav.addObject("s_list", u_service.getMyWrite_service(id));

		// 달성기록: 쓰레기 총량, 총 Km
		mav.addObject("a_vo", u_service.getRecord(id));
		mav.setViewName("/mypage/my");
		return mav;
	}

	// 상세정보 페이지
	@GetMapping(value = "/myDetail")
	public ModelAndView getMyDetail(HttpSession session) {

		mav = new ModelAndView();

		String id = (String) session.getAttribute("logId");

		mav.addObject("u_vo", u_service.getUserDetail(id));
		mav.setViewName("/mypage/myDetail");
		return mav;
	}

	// 상세정보 페이지 수정
	@GetMapping(value = "/myDetailEdit")
	public ModelAndView getMyDetailEdit(HttpSession session) {

		mav = new ModelAndView();

		String id = (String) session.getAttribute("logId");

		mav.addObject("u_vo", u_service.getUserDetail(id));
		mav.setViewName("/mypage/myDetailEdit");
		return mav;
	}

	// 상세졍보 저장
	@PostMapping(value = "/detailEditOk")
	public ResponseEntity<String> detailEditOk(HttpSession session, UserVO vo) {

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=utf-8");
		String msg = "<script>";

		// System.out.println(vo.toString());
		String id = (String) session.getAttribute("logId");
		vo.setId(id);

		try {
			int result = u_service.detailEditOk(vo);
			if (result > 0) {
				msg += "alert('수정완료');";
				msg += "location.href='/mypage/myDetail';";
			} else {
				msg += "alert('수정실패');";
				msg += "history.go(-1)";
			}

		} catch (Exception e) {
			// TODO: handle exception
		}

		msg += "</script>";
		return new ResponseEntity<String>(msg, headers, HttpStatus.OK);
	}

	// 나의 엑티비티 페이지
	@GetMapping(value = "activity")
	public ModelAndView getMyAct(HttpSession session, ActivityPagingVO apvo) {

		mav = new ModelAndView();

		// 나의 통계 데이터
		String id = (String) session.getAttribute("logId");
		// System.out.println(apvo.getOnePageRecord());
		mav.addObject("a_vo_w", a_serivce.getUserStatistic_w(id, "yeek"));
		mav.addObject("a_vo_m", a_serivce.getUserStatistic_m(id, "month"));
		mav.addObject("a_vo_y", a_serivce.getUserStatistic_y(id, "year"));
		mav.addObject("a_vo_t", a_serivce.getUserStatistic(id, "total"));

		mav.addObject("a_list", a_serivce.getActivityList(id));

		int[] activitynoList = { 0, 0, 0 };

		apvo.setId(id);
		apvo.setTotalRecord(a_serivce.totalUserCourse(apvo));

		List<ActivityVO> activityList = a_serivce.activityAllSelect(apvo);

		for (int i = 0; i < activityList.size(); i++) {
			activitynoList[i] = activityList.get(i).getNo();
			// System.out.println(activitynoList[i]);
		}

		mav.addObject("activityList", activityList);
		mav.addObject("apvo", apvo);
		mav.addObject("courseUser",
				a_serivce.courseUserAllSelect(
						activitynoList[0],
						activitynoList[1],
						activitynoList[2]));
		mav.setViewName("/mypage/activity");
		return mav;
	}

	// 나의 엑티비티 페이지 - 그래프 데이터1
	@GetMapping(value = "getUserRecord_w")
	public List<ActivityVO> AgetUserRecord_w(HttpSession session) {
		String id = (String) session.getAttribute("logId");
		List<ActivityVO> w_graph = a_serivce.getGraph_w(id);
		return w_graph;
	}

	// 나의 엑티비티 페이지 - 그래프 데이터2
	@GetMapping(value = "getUserRecord_m")
	public List<ActivityVO> AgetUserRecord_m(HttpSession session) {
		String id = (String) session.getAttribute("logId");
		List<ActivityVO> m_graph = a_serivce.getGraph_m(id);
		return m_graph;
	}

	// 나의 엑티비티 페이지 - 그래프 데이터3
	@GetMapping(value = "getUserRecord_y")
	public List<ActivityVO> AgetUserRecord_y(HttpSession session) {
		String id = (String) session.getAttribute("logId");
		List<ActivityVO> y_graph = a_serivce.getGraph_y(id);
		return y_graph;
	}

	// 나의 엑티비티 페이지 - 그래프 데이터4
	@GetMapping(value = "getUserRecord_t")
	public List<ActivityVO> AgetUserRecord_t(HttpSession session) {
		String id = (String) session.getAttribute("logId");
		List<ActivityVO> t_graph = a_serivce.getGraph_t(id);
		return t_graph;
	}

	// ------------------------내가 만든 코스 ------------------------------
	@GetMapping("myCourse")
	public ModelAndView getMyCourse(HttpSession session, CoursePagingVO cpvo, MyPagingVO mvo) {

		int[] coursenoList = { 0, 0, 0, 0, 0, 0 };
		mav = new ModelAndView();
		String id = (String) session.getAttribute("logId");

		// 페이징
		mvo.setId(id);
		cpvo.setTotalRecord(u_service.setTotalRecord_my(mvo));
		// cpvo.setTotalRecord(m_service.totalCourse(cpvo));
		mvo.setTotalRecord(u_service.setTotalRecord_my(mvo));

		List<CourseVO> courseList = u_service.courseAllselect_t(mvo);

		int startCourse = courseList.get(courseList.size() - 1).getCourse_no();
		int endCourse = courseList.get(0).getCourse_no();

		mav.addObject("courseList", courseList);
		mav.addObject("cpvo", cpvo);
		mav.addObject("mvo", mvo);
		mav.addObject("courseDetail", m_service.detailAllselect_tt(startCourse, endCourse));

		mav.addObject("c_list", u_service.getUserCourse(mvo));
		mav.setViewName("/mypage/myCourse");
		return mav;
	}

	// 내가 만든 코스 보기
	@GetMapping("myCourseView")
	public ModelAndView getMyCourseView(HttpSession session, int no) {

		mav = new ModelAndView();

		String id = (String) session.getAttribute("logId");

		// CourseVO vo = new CourseVO();
		// vo = p_service.getPathDetail(no);

		mav.addObject("vo", p_service.getPathDetail(no));
		mav.addObject("courseDetail", m_service.detailSelect(no));
		mav.setViewName("/mypage/myCourseView");
		return mav;
	}

	@GetMapping("myCourseEdit")
	public ModelAndView getMyCourseEdit(HttpSession session, int no) {

		mav = new ModelAndView();

		// String id = (String) session.getAttribute("logId");
		int result = m_service.courseCheck(no);
		if (result == 0) {
			CourseVO cvo = new CourseVO();
			cvo.setCourse_no(-1);
			mav.addObject("course", cvo);
		} else {
			mav.addObject("course", m_service.courseSelect(no));
			mav.addObject("courseDetail", m_service.detailSelect(no));
		}

		mav.addObject("vo", p_service.getPathDetail(no));
		mav.setViewName("/mypage/myCourseEdit");
		return mav;
	}
	
	@GetMapping("myCourseEdit_user")
	public ModelAndView getMyCourseEdit_user(HttpSession session, int no) {

		mav = new ModelAndView();

		// String id = (String) session.getAttribute("logId");
		int result = m_service.courseCheck(no);
		if (result == 0) {
			CourseVO cvo = new CourseVO();
			cvo.setCourse_no(-1);
			mav.addObject("course", cvo);
		} else {
			mav.addObject("course", m_service.courseSelect(no));
			mav.addObject("courseDetail", m_service.detailSelect(no));
		}

		mav.addObject("vo", p_service.getPathDetail(no));
		mav.setViewName("/mypage/myCourseEdit_user");
		return mav;
	}
}
