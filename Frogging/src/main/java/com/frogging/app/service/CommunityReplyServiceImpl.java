package com.frogging.app.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.frogging.app.dao.CommunityReplyDAO;
import com.frogging.app.vo.CommunityReplyVO;

@Service
public class CommunityReplyServiceImpl implements CommunityReplyService {
	
	@Autowired
	CommunityReplyDAO dao;
	
	@Override
	public int replyInsert(CommunityReplyVO vo) {
		return dao.replyInsert(vo);
	}

	@Override
	public List<CommunityReplyVO> replyList(int no) {
		return dao.replyList(no);
	}

	@Override
	public int replyUpdate(CommunityReplyVO vo) {
		return dao.replyUpdate(vo);
	}

	@Override
	public int replyDelete(int reply_no, String id) {
		return dao.replyDelete(reply_no, id);
	}

	@Override
	public int reReplyInsert(CommunityReplyVO vo) {
		return dao.reReplyInsert(vo);
	}

	@Override
	public CommunityReplyVO replyInfo(CommunityReplyVO vo) {
		return dao.replyInfo(vo);
	}



}
