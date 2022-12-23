package com.frogging.app.service;

import java.util.List;

import com.frogging.app.vo.CommunityReplyVO;

public interface CommunityReplyService {
	//댓글추가
	public int replyInsert(CommunityReplyVO vo);
	//댓글리스트
	public List<CommunityReplyVO> replyList(int no);
	//댓글수정
	public int replyUpdate(CommunityReplyVO vo);
	//댓글삭제
	public int replyDelete(int reply_no, String id);
	//답글추가
	public int reReplyInsert(CommunityReplyVO vo);
	//댓글 정보
	public CommunityReplyVO replyInfo(CommunityReplyVO vo);
}
