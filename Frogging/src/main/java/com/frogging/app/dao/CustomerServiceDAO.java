package com.frogging.app.dao;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.frogging.app.vo.PagingVO;
import com.frogging.app.vo.CustomerServiceVO;

@Mapper
@Repository
public interface CustomerServiceDAO {
	
	//customerService게시판 글목록
	public List<CustomerServiceVO> customerServiceList(PagingVO pVO);
	//customerService등록 추후 관리자만 버튼이 보이도록
	public int customerServiceWriteOk(CustomerServiceVO vo);
	//customerService 내용보기
	public CustomerServiceVO getcustomerService(int no);
	//수정
	public int customerServiceEditOk(CustomerServiceVO vo);
	//삭제
	public int customerServiceDel(int reply_group, String id);
	
	public int customerServiceDel2(int no, String id);
	//조회수
	public void hitCount(int no);
	//답글
	public int customerServiceReplyOk(CustomerServiceVO vo);
	
	public CustomerServiceVO getcustomerServiceReplyInfo(CustomerServiceVO vo);
	
	public int totalRecord(PagingVO pVO);
	//답글 깊이 순서 정렬
	public int customerServiceUpdate(CustomerServiceVO vo);
	
	//답글 업데이트
	public CustomerServiceVO customerServiceReply(int no);
}
