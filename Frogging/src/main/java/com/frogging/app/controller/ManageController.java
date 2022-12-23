package com.frogging.app.controller;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.frogging.app.service.ActivityService;
import com.frogging.app.service.AdminService;
import com.frogging.app.service.CourseService;
import com.frogging.app.service.PartyService;
import com.frogging.app.vo.ActivityVO;
import com.frogging.app.vo.CourseVO;
import com.frogging.app.vo.ManagePagingVO;
import com.frogging.app.vo.PartyDetailVO;
import com.frogging.app.vo.PartyVO;
import com.frogging.app.vo.PlogPagingVO;

@RestController
@RequestMapping("/admin/*")
public class ManageController {

	ModelAndView mav;

	@Inject
	ActivityService a_serivce;

	@Inject
	PartyService p_service;

	@Inject
	CourseService c_service;

	@Inject
	AdminService m_service;

	// 통계 페이지
	@GetMapping("/statistic")
	public ModelAndView statisticView() {

		mav = new ModelAndView();

		mav.setViewName("/admin/statistic");
		return mav;
	}

	// 관리자 - 플로깅 통계
	@GetMapping(value = "getPlogData")
	public List<ActivityVO> getPlogData() {
		List<ActivityVO> graph = a_serivce.getPlogGraph();
		return graph;
	}

	// 관리자 - 유저 통계
	@GetMapping(value = "getUserData")
	public ArrayList<Integer> getUserData() {
		ArrayList<Integer> user_data = new ArrayList<Integer>();
		user_data.add(a_serivce.numberOfBad());
		user_data.add(a_serivce.numberOfGood());

		user_data.add(a_serivce.numberOfUnactive());
		user_data.add(a_serivce.numberOfActive());

		return user_data;
	}

	// 관리자 - 쓰레기 통계
	@GetMapping(value = "getTrashData")
	public List<ActivityVO> getTrashData() {
		List<ActivityVO> graph = a_serivce.getTrashGraph();
		return graph;
	}

	// ------------------------- 코스 ---------------------------
	// 코스 관리 페이지
	@GetMapping("/manageCourse")
	public ModelAndView manageCourse(ManagePagingVO pVO) {

		mav = new ModelAndView();
		pVO.setTotalRecord(m_service.totalRecord5(pVO));

		mav.addObject("c_list", p_service.getPathList_m(pVO));
		mav.setViewName("/admin/manageCourse");
		mav.addObject("pVO", pVO);

		// System.out.println(p_service.getPathList(p_pageVO));
		return mav;
	}

	// 코스 여러개 삭제
	@PostMapping("/courseMultiDel")
	public ResponseEntity<String> courseMultiDel(CourseVO c_vo) {

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=utf-8");
		String msg = "<script>";

		// 코스삭제 : 코스 참조하는 파티 삭제 (액티비티는?) -> 코스 디테일 테이블 삭제 -> 코스 테이블 삭제 순서로

		try {
			int result_2 = c_service.courseMultiDel_detail(c_vo);
			int result_3 = c_service.courseMultiDel(c_vo);

			if (result_2 != 0 && result_3 != 0) {
				msg += "alert('삭제완료');";
				msg += "location.href='/admin/manageCourse';";
			} else {
				msg += "alert('삭제실패');";
				msg += "history.go(-1)";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		msg += "</script>";
		return new ResponseEntity<String>(msg, headers, HttpStatus.OK);
	}

	// ------------------------- 클럽 ---------------------------
	// 파티 관리 페이지
	@GetMapping("/manageClub")
	public ModelAndView manageParty(ManagePagingVO pVO) {

		mav = new ModelAndView();

		pVO.setTotalRecord(m_service.totalRecord6(pVO));
		System.out.println(m_service.totalRecord6(pVO));
		// PartyDetailVO p_dVO = new PartyDetailVO();
		// p_dVO.setJoin_status(4);
		mav.addObject("c_list", p_service.getTotalClub(pVO));
		mav.addObject("pVO", pVO);
		mav.setViewName("/admin/manageClub");
		return mav;
	}

	// 파티 여러개 삭제
	@PostMapping("/clubMultiDel")
	public ResponseEntity<String> clubMultiDel(PartyVO p_vo) {

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=utf-8");
		String msg = "<script>";

		// int result = 1;
		// System.out.println(p_vo.getNoList());

		// 파티삭제 : 파티 리퀘스트 삭제 -> 파티 디테일 테이블 삭제 -> 파티 테이블 삭제 순서로

		try {
			int result_1 = p_service.clubMultiDel_request(p_vo);
			int result_2 = p_service.clubMultiDel_detail(p_vo);
			int result_3 = p_service.clubMultiDel(p_vo);

			if (result_3 != 0) {
				msg += "alert('삭제완료');";
				msg += "location.href='/admin/manageClub';";
			} else {
				msg += "alert('삭제실패');";
				msg += "history.go(-1)";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		msg += "</script>";
		return new ResponseEntity<String>(msg, headers, HttpStatus.OK);
	}
}
