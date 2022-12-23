package com.frogging.app.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.frogging.app.dao.CommunityDAO;
import com.frogging.app.vo.CommunityVO;
import com.frogging.app.vo.PagingVO;

@Service
public class CommunityServiceImpl implements CommunityService {
	@Autowired
	CommunityDAO dao;
	
	@Override
	public List<CommunityVO> communityList(PagingVO pVO) {
		return dao.communityList(pVO);
	}

	@Override
	public int communityWriteOk(CommunityVO vo) {
		return dao.communityWriteOk(vo);
	}

	@Override
	public CommunityVO getCommunity(int no) {
		return dao.getCommunity(no);
	}

	@Override
	public int communityEditOk(CommunityVO vo) {
		return dao.communityEditOk(vo);
	}

	@Override
	public int communityDel(int no, String id) {
		return dao.communityDel(no, id);
	}

	@Override
	public void hitCount(int no) {
		dao.hitCount(no);
		
	}

	@Override
	public int totalRecord(PagingVO pVO) {
		return dao.totalRecord(pVO);
	}

	@Override
	public int communityMultiDel(CommunityVO vo) {
		return dao.communityMultiDel(vo);
	}

}
