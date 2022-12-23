package com.frogging.app.dao;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.frogging.app.vo.PagingVO;
import com.frogging.app.vo.QnaVO;

@Mapper
@Repository
public interface QnaDAO {
	
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
	//답글
	public int qnaReplyOk(QnaVO vo);
	
	public QnaVO getQnaReplyInfo(QnaVO vo);
	
	public int totalRecord(PagingVO pVO);
	//답글 깊이 순서 정렬
	public int qnaUpdate(QnaVO vo);
	
	public int parent_reply_group(QnaVO vo);
	//답글 업데이트
	public QnaVO qnaReply(int no);
}
