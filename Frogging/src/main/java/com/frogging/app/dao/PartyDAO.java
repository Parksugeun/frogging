package com.frogging.app.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.frogging.app.vo.ActivityVO;
import com.frogging.app.vo.ClubPagingVO;
import com.frogging.app.vo.CourseVO;
import com.frogging.app.vo.ManagePagingVO;
import com.frogging.app.vo.PartyDetailVO;
import com.frogging.app.vo.PartyVO;
import com.frogging.app.vo.PlogPagingVO;

@Mapper
@Repository
public interface PartyDAO {

	// 새 파티 참여 요청
	public int newPartyRequest(PartyDetailVO p_detail_vo);

	// 파티 리스트 가져오기
	public List<PartyVO> getPartyList(ClubPagingVO p_pageVO);

	// 리스트 세팅 - 파티
	public int totalRecord(ClubPagingVO p_pageVO);

	// 리스트 세팅 - 경로
	public int totalRecord_path(PlogPagingVO p_pageVO);

	// 새로운 파티 만들기
	public int addNewParty(PartyVO pVO);

	// 새로운 파티 디테일 - 파티장 추가
	public int addNewPartyDetail(PartyDetailVO p_detailVO);

	// 파티 인원 증가시키기
	public void countCurrentNum(int party_no);

	// 파티 인원 감소시키기
	public void decreaseCurrentNum(int party_no);

	// 파티 세부 정보 가져오기
	public PartyVO getPartyDetail(int no);

	// 파티장 액티비티 정보 가져오기
	public ActivityVO getLeaderInfo(String id);

	// 파티 중복 신청 확인
	public int checkOverlap(PartyDetailVO p_detail_vo);

	// 경로 리스트 가져오기
	public List<CourseVO> getPathList(PlogPagingVO p_pageVO);

	public List<CourseVO> getPathList_m(ManagePagingVO p_pageVO);

	// 나의 모임 리스트
	public List<PartyVO> getMyJoinedClub(PartyDetailVO p_dVO);

	// 최근 추가 클럽넘버
	public int getMaxNo();

	// 파티 세부 정보 가져오기
	public CourseVO getPathDetail(int no);

	// 파티이름 중복검사
	public int partynameCheck(String partyname);

	// 파티정보 수정
	public int rewriteParty(PartyVO pVO);

	// 파티 삭제
	public int deleteClub(int no);

	// 파티 디테일 삭제
	public int deleteClubDetail(int no);

	public int deleteClubDetail_2(int no, String id);

	// 파티 참여 멤버 정보 가져오기
	public List<PartyDetailVO> getMemberDetail(int no);

	// 파티 디테일 번호 가져오기
	public int getPartyDetailNo(int partyno, String userid);

	// 파티 참여 상태 변경
	public int changeStatus(int partyno, String userid); // 승인

	public int changeStatus_2(int partyno, String userid); // 거절

	// 파티 리퀘스트 거절 사유 추가
	public int addReason(int partyno, int party_detail_no, int reason);

	// 파티 관리자 리스트
	public List<PartyVO> getTotalClub(ManagePagingVO pvo);

	// 파티 여러개 삭제
	public int clubMultiDel(PartyVO vo);

	public int clubMultiDel_detail(PartyVO vo);

	public int clubMultiDel_request(PartyVO vo);

	// 파티 리퀘스트 삭제
	public int deleteClubRequest(int no);
}
