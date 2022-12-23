package com.frogging.app.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;


import com.frogging.app.vo.CommunityVO;
import com.frogging.app.vo.PagingVO;

@Mapper
@Repository
public interface CommunityDAO {
		//커뮤니티게시판 글목록
		public List<CommunityVO> communityList(PagingVO pVO);
		//글등록
		public int communityWriteOk(CommunityVO vo);
		//글선택(수정), 글내용보기
		public CommunityVO getCommunity(int no);
		//글수정
		public int communityEditOk(CommunityVO vo);
		//글삭제
		public int communityDel(int no, String id);
		//조회수
		public void hitCount(int no);
		//총레코드 수
		public int totalRecord(PagingVO pVO);
		//여러개의 레코드 삭제
		public int communityMultiDel(CommunityVO vo);
	
}
