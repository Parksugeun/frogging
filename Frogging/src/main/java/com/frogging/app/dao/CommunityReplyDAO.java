package com.frogging.app.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.frogging.app.vo.CommunityReplyVO;

@Mapper
@Repository
public interface CommunityReplyDAO {
	public int replyInsert(CommunityReplyVO vo);
	public List<CommunityReplyVO> replyList(int no);
	public int replyUpdate(CommunityReplyVO vo);
	public int replyDelete(int reply_no, String id);
	public int reReplyInsert(CommunityReplyVO vo);
	public CommunityReplyVO replyInfo(CommunityReplyVO vo);
}
