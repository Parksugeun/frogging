package com.frogging.app.service;

import java.util.List;

import com.frogging.app.vo.PagingVO;
import com.frogging.app.vo.QnaVO;

public interface QnaService {
	//Qna게시판 글목록
	public List<QnaVO> qnaList(PagingVO pVO);
	//Qna등록 추후 관리자만 버튼이 보이도록
	public int qnaWriteOk(QnaVO vo);
	//Qna 내용보기
	public QnaVO getQna(int no);
	//수정
	public int qnaEditOk(QnaVO vo);
	//삭제
	public int qnaDel(int reply_group, String id);
	
	public int qnaDel2(int no, String id);
	//조회수
	public void hitCount(int no);
	public int qnaReplyOk(QnaVO vo);
	public int totalRecord(PagingVO pVO);
	public QnaVO getQnaReplyInfo(QnaVO vo);
	
	public int qnaUpdate(QnaVO vo);
	
	public int parent_reply_group(QnaVO vo);
	
	public QnaVO qnaReply(int no);
	
	
}
