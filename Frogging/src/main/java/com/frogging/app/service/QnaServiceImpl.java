package com.frogging.app.service;


import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.frogging.app.dao.QnaDAO;
import com.frogging.app.vo.PagingVO;
import com.frogging.app.vo.QnaVO;


@Service
public class QnaServiceImpl implements QnaService{
	@Inject
	QnaDAO dao;

	@Override
	public List<QnaVO> qnaList(PagingVO pVO) {
		return dao.qnaList(pVO);
	}

	@Override
	public int qnaDel(int reply_group, String id) {
		return dao.qnaDel(reply_group, id);
	}

	@Override
	public void hitCount(int no) {
		dao.hitCount(no);
		
	}

	@Override
	public QnaVO getQna(int no) {
		return dao.getQna(no);
	}

	@Override
	public int qnaWriteOk(QnaVO vo) {
		return dao.qnaWriteOk(vo);
	}

	@Override
	public int qnaReplyOk(QnaVO vo) {
		return dao.qnaReplyOk(vo);
	}
	
	@Override
	public QnaVO getQnaReplyInfo(QnaVO vo) {
		
		
		
		return dao.getQnaReplyInfo(vo);
	}
	

	@Override
	public int qnaEditOk(QnaVO vo) {	
		return dao.qnaEditOk(vo);
	}

	@Override
	public int qnaUpdate(QnaVO vo) {
		return dao.qnaUpdate(vo);
	}

	@Override
	public int parent_reply_group(QnaVO vo) {
		return dao.parent_reply_group(vo);
	}

	@Override
	public QnaVO qnaReply(int no) {
		return dao.qnaReply(no);
	}

	@Override
	public int totalRecord(PagingVO pVO) {
		return dao.totalRecord(pVO);
	}

	@Override
	public int qnaDel2(int no, String id) {
		return dao.qnaDel2(no, id);
	}





	
	
}
