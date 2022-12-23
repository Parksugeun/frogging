package com.frogging.app.controller;

import java.nio.charset.Charset;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.frogging.app.service.AddrService;
import com.frogging.app.service.DataService;
import com.frogging.app.service.MapsService;
import com.frogging.app.service.PartyService;
import com.frogging.app.service.UserService;
import com.frogging.app.vo.ClubPagingVO;
import com.frogging.app.vo.CoursePagingVO;
import com.frogging.app.vo.CourseVO;
import com.frogging.app.vo.PartyDetailVO;
import com.frogging.app.vo.PartyVO;
import com.frogging.app.vo.PlogPagingVO;
import com.mysql.cj.xdevapi.JsonParser;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/club/*")
public class PartyController {

	ModelAndView mav = null;

	@Inject
	PartyService p_service;

	@Inject
	DataService d_service;

	@Inject
	MapsService m_service;

	@Inject
	UserService u_service;

	// 함께 시작하기
	@GetMapping(value = "/join_club")
	public ModelAndView start_party(ClubPagingVO pageVO) {

		// DB - 파티 가져오기 + 날짜 조건 + 위치 조건
		// 위치 조건 가져오기 addr_1 + addr_2
		if (pageVO.getAddr_section_1() != null) {

			// 시군구 뒤에 \n 있는거 처리
			String pull = pageVO.getAddr_section_2();
			String[] words = pull.split("\\s");
			pageVO.setAddr_section_2(words[0]);

			pageVO.setSearchLoc(pageVO.getAddr_section_1() + " " + pageVO.getAddr_section_2());
		}

		// 페이지 + 조건 검색 세팅
		// p_PageVO.setOnePageRecord(4);
		pageVO.setTotalRecord(p_service.totalRecord(pageVO));
		// System.out.println(pageVO.toString());

		mav = new ModelAndView();

		mav.addObject("addr_1", d_service.getAddr_1());
		mav.addObject("addr_2", d_service.getAddr_2("서울특별시"));
		mav.addObject("list", p_service.getPartyList(pageVO));
		mav.addObject("pVO", pageVO);
		mav.setViewName("plog_together/join_club");
		return mav;
	}

	// 새 클럽 - 추천 경로
	@GetMapping(value = "/make_club_rec_path")
	public ModelAndView make_club_rec_path(PlogPagingVO p_PageVO, CoursePagingVO cpvo) {

		int[] coursenoList = { 0, 0, 0, 0, 0, 0 };
		// DB - 경로 가져오기 + 위치 조건
		// !!!!!!!!!!!!!!!! 위치 조건 검색 !!!!!!!!!!!!!!!!
		if (p_PageVO.getAddr_section_1() != null) {

			// 시군구 뒤에 \n 있는거 처리
			String pull = p_PageVO.getAddr_section_2();
			String[] words = pull.split("\\s");
			p_PageVO.setAddr_section_2(words[0]);

			p_PageVO.setSearchLoc(p_PageVO.getAddr_section_1() + " " + p_PageVO.getAddr_section_2());
		}

		p_PageVO.setTotalRecord(p_service.totalRecord_path(p_PageVO));

		mav = new ModelAndView();
		mav.addObject("addr_1", d_service.getAddr_1());
		mav.addObject("addr_2", d_service.getAddr_2("서울특별시"));

		mav.addObject("list", p_service.getPathList(p_PageVO));
		mav.addObject("p_PageVO", p_PageVO);

		List<CourseVO> courseList = p_service.getPathList(p_PageVO);

		for (int i = 0; i < courseList.size(); i++) {
			coursenoList[i] = courseList.get(i).getCourse_no();
		}
		mav.addObject("courseDetail",
				m_service.detailAllselect_t(
						coursenoList[0],
						coursenoList[1],
						coursenoList[2],
						coursenoList[3],
						coursenoList[4],
						coursenoList[5]));
		mav.setViewName("plog_together/make_club_rec_path");
		return mav;
	}

	// 새 클럽 - 새 경로
	@GetMapping(value = "/make_club_new_path")
	public ModelAndView make_club_new_path() {

		mav = new ModelAndView();
		mav.setViewName("plog_together/make_club_new_path");
		return mav;
	}
	
	@GetMapping(value = "/make_club_new_path_user")
	public ModelAndView make_club_new_path_user() {

		mav = new ModelAndView();
		mav.setViewName("plog_together/make_club_new_path_user");
		return mav;
	}
	// 클럽관리 - 리스트
	@GetMapping(value = "/my_club_list")
	public ModelAndView my_club_list(HttpSession session, HttpServletRequest request) {
		// set_sample_user(session);
		mav = new ModelAndView();

		// DB - 해당 아이디의 파티 가져오기
		// set_sample_user(session);
		PartyDetailVO p_dVO = new PartyDetailVO();
		p_dVO.setUser_id((String) request.getSession().getAttribute("logId"));

		// 자신이 참여한 클럽
		mav.addObject("join_list", p_service.getMyJoinedClub(p_dVO));
		// 자신이 운영하는 클럽
		p_dVO.setJoin_status(4);
		mav.addObject("manage_list", p_service.getMyJoinedClub(p_dVO));

		mav.setViewName("plog_together/my_club_list");
		return mav;
	}

	// ---------------------- 모달 내 클럽 상세 정보
	@GetMapping(value = "/getClubDetail")
	public JSONObject getClubDetail(int no) {
		JSONObject voList = new JSONObject();
		try {
			// 1) party 정보 가져오기 + course 이름 + 거리 + 소요시간
			PartyVO vo = new PartyVO();
			vo = p_service.getPartyDetail(no);

			// course_no
			int course_no = vo.getCourse_no();

			// 1-1) vo 객체 jsonString으로 변환
			ObjectMapper mapper = new ObjectMapper();
			String jsonString = mapper.writeValueAsString(vo);
			// System.out.println(jsonString);

			// 1-2) jsonString -> JSONObject로 변환
			JSONParser jsonParser = new JSONParser();
			JSONObject jObj_party = (JSONObject) jsonParser.parse(jsonString);
			voList.put("party", jObj_party);

			// 2)party.id -> activity에서 group by id 해서 총 플로깅 횟수, 총 걸은 거리
			// 2-1)id 가져오기
			String p_id = vo.getId();

			// 2-2) vo -> jsonString
			jsonString = mapper.writeValueAsString(p_service.getLeaderInfo(p_id));

			// 2-3) jsonString -> JSONObject
			JSONObject jObj_activity = (JSONObject) jsonParser.parse(jsonString);
			voList.put("activity", jObj_activity);

			// 3) 코스 넘기기

			CourseVO cvo = new CourseVO();
			cvo = p_service.getPathDetail(course_no);
			jsonString = mapper.writeValueAsString(cvo);
			JSONObject jObj_course = (JSONObject) jsonParser.parse(jsonString);
			voList.put("path", jObj_course);

			List<CourseVO> course_detail = m_service.detailSelect(course_no);
			JSONObject jObj_detail;
			String name;

			for (int i = 0; i < course_detail.size(); i++) {
				jsonString = mapper.writeValueAsString(course_detail.get(i));
				jObj_detail = (JSONObject) jsonParser.parse(jsonString);
				voList.put(course_detail.get(i).getWaypoint(), jObj_detail);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return voList;
	}

	// ---------------------- 모달 내 클럽 멤버 상세 정보
	@GetMapping(value = "/getMemberDetail")
	public JSONObject getMemberDetail(int no) {
		JSONObject voList = new JSONObject();
		try {
			// party_detail + nickname + partyname => list

			int idx = 0;
			ObjectMapper mapper = new ObjectMapper();
			List<PartyDetailVO> p_list = p_service.getMemberDetail(no);

			for (PartyDetailVO vo : p_list) {
				String jsonString = mapper.writeValueAsString(vo);
				// System.out.println(jsonString);

				JSONParser jsonParser = new JSONParser();
				JSONObject jObj_p = (JSONObject) jsonParser.parse(jsonString);
				voList.put(idx, jObj_p);
				idx += 1;
			}
			voList.put("idx", idx);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return voList;
	}

	// ---------------------- 모달 내 코스 상세 정보
	@GetMapping(value = "/getPathDetail")
	public JSONObject getPathDetail(int no) {
		JSONObject voList = new JSONObject();
		// System.out.println(no);
		try {
			// 1) path 정보 가져오기 courseVO + 시작/도착 위치 + 방문횟수
			CourseVO vo = new CourseVO();
			vo = p_service.getPathDetail(no);
			// System.out.println(vo.toString());

			// 1-1) vo 객체 jsonString으로 변환
			ObjectMapper mapper = new ObjectMapper();
			String jsonString = mapper.writeValueAsString(vo);
			// System.out.println(jsonString);

			// 1-2) jsonString -> JSONObject로 변환
			JSONParser jsonParser = new JSONParser();
			JSONObject jObj_party = (JSONObject) jsonParser.parse(jsonString);

			voList.put("path", jObj_party);

			List<CourseVO> course_detail = m_service.detailSelect(no);
			JSONObject jObj_detail;
			String name;

			for (int i = 0; i < course_detail.size(); i++) {
				jsonString = mapper.writeValueAsString(course_detail.get(i));
				jObj_detail = (JSONObject) jsonParser.parse(jsonString);
				voList.put(course_detail.get(i).getWaypoint(), jObj_detail);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return voList;
	}

	// ------------------------ 클럽 참여 신청
	@GetMapping("/ask_join_in")
	public ResponseEntity<String> ask_join_in(HttpSession session, HttpServletRequest request,
			@RequestParam("party_no") int party_no) {

		// entity setting
		// ResponseEntity<String> entity = null;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=utf-8");
		String msg = "<script>";

		// 임의의 유저 세팅 (차후 로그인으로 대체)
		// set_sample_user(session);

		try {
			// 불량유저체크
			String id = (String) request.getSession().getAttribute("logId");
			int status = u_service.checkUserStatus(id);

			if (status == 0) {
				// DB에 쓸 파티 세부 정보 세팅
				PartyDetailVO p_detail_vo = new PartyDetailVO();
				p_detail_vo.setParty_no(party_no);
				p_detail_vo.setUser_id((String) request.getSession().getAttribute("logId"));
				p_detail_vo.setJoin_status(0);

				// 신청 검사
				// 검사-i) detail에 이미 있으면 x
				// System.out.println("party_no:" + p_detail_vo.getParty_no() + " /in party:" +
				// p_service.checkOverlap(p_detail_vo));
				if (p_service.checkOverlap(p_detail_vo) == 0) {

					// 검사-ii) party 정원이 찼는지 p_service.checkNumber
					PartyVO p_vo = p_service.getPartyDetail(party_no);
					if (p_vo.getCurrent_number() < p_vo.getNumber()) {

						p_service.countCurrentNum(party_no); // current number 증가
						p_service.newPartyRequest(p_detail_vo); // p_detail추가

						// 신청 성공일 때 -> 마이 클럽 리스트로
						msg += "alert('클럽 참여 신청 성공하였습니다');";
						msg += "location.href='/club/my_club_list';";
					} else {
						// 모임 정원이 다 찼을 때
						msg += "alert('모집이 마감된 모임입니다');";
						msg += "history.go(-1)";
					}
				} else {
					// 중복 신청일 때
					msg += "alert('이미 신청한 모임입니다');";
					msg += "history.go(-1)";
				}

			} // 불량유저검사
			else if (status == 1) {
				msg += "alert('클럽에 참여할 수 없는 유저입니다.');";
				msg += "history.go(-1)";
			}
		} catch (Exception e) {
			e.printStackTrace();
			// 신청 실패일 때 -> back
			msg += "alert('클럽 참여 신청 실패하였습니다.');";
			msg += "history.go(-1)";
		}
		msg += "</script>";

		return new ResponseEntity<String>(msg, headers, HttpStatus.OK);
	}

	// ------------------------ 새 클럽 생성
	@PostMapping(value = "/makeNewClub")
	public ResponseEntity<String> makeNewClub(PartyVO pVO, HttpServletRequest request, HttpSession session) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=utf-8");
		String msg = "<script>";

		try {
			// set_sample_user(session);

			// 불량유저체크
			String id = (String) request.getSession().getAttribute("logId");
			int status = u_service.checkUserStatus(id);

			if (status == 0) {
				// 1) DB:party
				// party vo세팅
				pVO.setId((String) request.getSession().getAttribute("logId"));
				pVO.setCurrent_number(1); // 현재 참여인원 1명
				// System.out.println(pVO.toString());
				p_service.addNewParty(pVO);

				// 2) DB:party_detail (파티장) - status:4
				// party_detail vo 세팅
				PartyDetailVO p_detailVO = new PartyDetailVO();
				p_detailVO.setParty_no(p_service.getMaxNo());
				p_detailVO.setUser_id(pVO.getId());
				p_detailVO.setJoin_status(4);
				// System.out.println(p_detailVO.toString());
				p_service.addNewPartyDetail(p_detailVO);

				msg += "alert('클럽 생성을 성공하였습니다');";
				msg += "location.href='/club/my_club_list';";

			} else if (status == 1) {
				msg += "alert('클럽을 생성할 수 없는 유저입니다.');";
				msg += "history.go(-1);";
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg += "alert('클럽 생성을 실패하였습니다.');";
			msg += "history.go(-1)";
		}
		msg += "</script>";

		return new ResponseEntity<String>(msg, headers, HttpStatus.OK);
	}

	// ---------파티이름 중복검사
	@PostMapping(value = "/checkPartyname")
	public String ckeckPartyname(String partyname) {
		try {
			int result = p_service.partynameCheck(partyname);
			if (result != 0) {
				return "no";
			} else {
				return "yes";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "no";
	}

	// ------------------------ 파티 관리 - 세부 ------------------
	@GetMapping(value = "/club_view")
	public ModelAndView clubView(int no, String l_id) {
		mav = new ModelAndView();

		PartyVO pvo = p_service.getPartyDetail(no);
		mav.addObject("pvo", p_service.getPartyDetail(no));

		int course_no = pvo.getCourse_no();
		mav.addObject("cvo", p_service.getPathDetail(course_no));
		mav.addObject("courseDetail", m_service.detailSelect(course_no));

		mav.addObject("avo", p_service.getLeaderInfo(l_id));
		mav.setViewName("/plog_together/club_view");
		return mav;
	}

	// ------------------ 파티 수정: 폼 -------------------------
	@GetMapping(value = "/club_edit")
	public ModelAndView clubEdit(int no, String l_id) {
		mav = new ModelAndView();
		PartyVO pvo = p_service.getPartyDetail(no);
		mav.addObject("pvo", p_service.getPartyDetail(no));

		int course_no = pvo.getCourse_no();
		mav.addObject("cvo", p_service.getPathDetail(course_no));
		mav.addObject("courseDetail", m_service.detailSelect(course_no));

		mav.addObject("avo", p_service.getLeaderInfo(l_id));
		mav.setViewName("/plog_together/club_edit");
		return mav;
	}

	// ------------------ 파티 수정:DB -------------------------
	@PostMapping(value = "/rewriteParty")
	public ResponseEntity<String> rewriteParty(PartyVO pvo) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=utf-8");
		String msg = "<script>";

		try {
			// System.out.println(pvo.toString());
			int result = p_service.rewriteParty(pvo);
			if (result != 0) {
				msg += "alert('모임 정보가 수정되었습니다.');";
				msg += "location.href='/club/club_view?no=" + pvo.getNo() + "&l_id=" + pvo.getId() + "';";
			} else {
				msg += "alert('모임 정보를 수정 실패하였습니다.');";
				msg += "history.go(-1)";
			}

		} catch (Exception e) {
			msg += "alert('모임 정보를 수정 실패하였습니다.');";
			msg += "history.go(-1)";
			e.printStackTrace();
		}

		msg += "</script>";

		return new ResponseEntity<String>(msg, headers, HttpStatus.OK);
	}

	// ------------------ 파티 삭제 -------------------------
	@GetMapping(value = "/deleteClub")
	public ResponseEntity<String> deleteClub(int no) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=utf-8");
		String msg = "<script>";

		try {
			// party_request-> party_detail ->party 순서로 삭제

			p_service.deleteClubRequest(no);
			p_service.deleteClubDetail(no);
			// System.out.println(no);
			int result = p_service.deleteClub(no);
			if (result != 0) {
				msg += "alert('모임이 삭제되었습니다.');";
				msg += "location.href='/club/my_club_list';";
			} else {
				msg += "alert('모임 삭제를 실패하였습니다.');";
				msg += "history.go(-1)";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		msg += "</script>";
		return new ResponseEntity<String>(msg, headers, HttpStatus.OK);
	}

	// ------------------ 파티 참여취소 -------------------------
	@GetMapping(value = "/leaveClub")
	public ResponseEntity<String> leaveClub(int no, HttpSession session) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=utf-8");
		String msg = "<script>";

		try {
			// party_detail에 해당 파티/유저 체크 후 삭제
			// party에서 현재 인원 1 감소
			String id = (String) session.getAttribute("logId");
			int result = p_service.deleteClubDetail_2(no, id);
			// System.out.println(no);
			p_service.decreaseCurrentNum(no);

			if (result != 0) {
				msg += "alert('모임 참여가 취소되었습니다.');";
				msg += "location.href='/club/my_club_list';";
			} else {
				msg += "alert('모임 참여 취소를 실패하였습니다.');";
				msg += "history.go(-1)";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		msg += "</script>";
		return new ResponseEntity<String>(msg, headers, HttpStatus.OK);
	}

	// ------------------------ 멤버 상태 변화: 승인
	@GetMapping(value = "/club/allowClub")
	public ResponseEntity<String> allowClub(int partyno, String userid) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=utf-8");
		String msg = "<script>";

		// System.out.println(partyno + "/" + userid);
		// join_status: 0 -> 1 (+1)
		try {
			int result = p_service.changeStatus(partyno, userid);
			if (result != 0) {
				msg += "alert('멤버 승인 완료');";
				msg += "location.href='/club/my_club_list';";
			} else {
				msg += "alert('멤버 승인 실패');";
				msg += "history.go(-1)";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		msg += "</script>";
		return new ResponseEntity<String>(msg, headers, HttpStatus.OK);
	}

	// ------------------------ 멤버 상태 변화 :거절
	@GetMapping(value = "/club/refuseClub")
	public ResponseEntity<String> refuseClub(int partyno, String userid, String reason) {
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html", Charset.forName("UTF-8")));
		headers.add("Content-Type", "text/html; charset=utf-8");
		String msg = "<script>";

		int rea = Integer.parseInt(reason);

		// System.out.println(partyno + "/" + userid);
		// join_status: 0 -> 2 or 1->3 (+2)
		// party의 current_number 감소
		// party_request 추가

		try {
			// System.out.println(partyno + "/" + userid);
			int party_detail_no = p_service.getPartyDetailNo(partyno, userid);
			// System.out.println(party_detail_no);

			int result_1 = p_service.changeStatus_2(partyno, userid);
			p_service.decreaseCurrentNum(partyno);
			int result_2 = p_service.addReason(partyno, party_detail_no, rea);

			if (result_1 != 0 && result_2 != 0) {
				msg += "alert('멤버 거절 완료');";
				msg += "location.href='/club/my_club_list';";
			} else {
				msg += "alert('멤버 거절 실패');";
				msg += "history.go(-1)";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		msg += "</script>";
		return new ResponseEntity<String>(msg, headers, HttpStatus.OK);
	}

	// 임의의 유저 세션 세팅 -> db 추가할 것
	public void set_sample_user(HttpSession session) {
		session.setAttribute("logId", "sampleId@gmail.com");
		session.setAttribute("logNickName", "sampleNickname");
		session.setAttribute("logStatus", "Y");
	}

}
