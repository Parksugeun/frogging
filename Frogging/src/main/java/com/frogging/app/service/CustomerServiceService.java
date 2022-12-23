package com.frogging.app.service;

import java.util.List;

import com.frogging.app.vo.PagingVO;
import com.frogging.app.vo.CustomerServiceVO;

public interface CustomerServiceService {
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
	
	public int customerServiceReplyOk(CustomerServiceVO vo);
	
	public int totalRecord(PagingVO pVO);
	
	public CustomerServiceVO getcustomerServiceReplyInfo(CustomerServiceVO vo);
	
	public int customerServiceUpdate(CustomerServiceVO vo);
	
	public CustomerServiceVO customerServiceReply(int no);
	
	
}
