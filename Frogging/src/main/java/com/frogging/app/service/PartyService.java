package com.frogging.app.service;

import java.util.List;

import com.frogging.app.vo.ActivityVO;
import com.frogging.app.vo.ClubPagingVO;
import com.frogging.app.vo.CourseVO;
import com.frogging.app.vo.ManagePagingVO;
import com.frogging.app.vo.PartyDetailVO;
import com.frogging.app.vo.PartyVO;
import com.frogging.app.vo.PlogPagingVO;

public interface PartyService {
	public int newPartyRequest(PartyDetailVO p_detail_vo);

	public List<PartyVO> getPartyList(ClubPagingVO p_pageVO);

	public int totalRecord(ClubPagingVO p_pageVO);

	public int totalRecord_path(PlogPagingVO p_pageVO);

	public int addNewParty(PartyVO pVO);

	public int addNewPartyDetail(PartyDetailVO p_detailVO);

	public void countCurrentNum(int party_no);

	public PartyVO getPartyDetail(int no);

	public ActivityVO getLeaderInfo(String id);

	public int checkOverlap(PartyDetailVO p_detail_vo);

	public List<CourseVO> getPathList(PlogPagingVO p_pageVO);

	public List<CourseVO> getPathList_m(ManagePagingVO p_pageVO);

	public List<PartyVO> getMyJoinedClub(PartyDetailVO p_dVO);

	public int getMaxNo();

	public CourseVO getPathDetail(int no);

	public int partynameCheck(String partyname);

	public int rewriteParty(PartyVO pVO);

	public int deleteClub(int no);

	public int deleteClubDetail(int no);

	public int deleteClubDetail_2(int no, String id);

	public void decreaseCurrentNum(int party_no);

	public List<PartyDetailVO> getMemberDetail(int no);

	public int changeStatus(int partyno, String userid);

	public int changeStatus_2(int partyno, String userid);

	// public int changeStatus_3(int partyno, String userid);

	public int getPartyDetailNo(int partyno, String userid);

	public int addReason(int partyno, int party_detail_no, int reason);

	public List<PartyVO> getTotalClub(ManagePagingVO pVO);

	public int clubMultiDel(PartyVO vo);

	public int clubMultiDel_detail(PartyVO vo);

	public int clubMultiDel_request(PartyVO vo);

	public int deleteClubRequest(int no);

}