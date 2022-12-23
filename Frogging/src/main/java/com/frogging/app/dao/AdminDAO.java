package com.frogging.app.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.frogging.app.vo.CommunityVO;
import com.frogging.app.vo.CustomerServiceVO;
import com.frogging.app.vo.EventPagingVO;
import com.frogging.app.vo.EventVO;
import com.frogging.app.vo.ManagePagingVO;
import com.frogging.app.vo.PagingVO;
import com.frogging.app.vo.QnaVO;
import com.frogging.app.vo.UserVO;

@Mapper
@Repository
public interface AdminDAO {
	public List<UserVO> userList();

	public UserVO getProfile(String id);

	public int listDel(String id);

	public int editProfile(String id, int restriction);

	public List<CommunityVO> communityList(PagingVO pVO);

	public int totalRecord(PagingVO pVO);

	// 고객센터
	public List<CustomerServiceVO> customerServiceList(PagingVO pVO);

	// 페이징
	public int totalRecord2(PagingVO pVO);

	// 내용보기
	public CustomerServiceVO getcustomerService(int no);

	// 수정
	public int customerServiceEditOk(CustomerServiceVO vo);

	// 삭제
	public int customerServiceDel(int no, String id);

	public List<EventVO> eventList(EventPagingVO pVO);

	public int totalRecord4(EventPagingVO pVO);

	public int eventEdit(EventVO vo);

	public int eventDel(int no, String id);

	public List<QnaVO> qnaList(PagingVO pVO);

	public int totalRecord3(PagingVO pVO);

	public QnaVO getQna(int no);

	public int qnaEditOk(QnaVO vo);

	public int qnaDel(int reply_group);
	
	public int qnaDel2(int no, String id);
	

	// 코스+클럽 페이징
	public int totalRecord5(ManagePagingVO pVO);

	public int totalRecord6(ManagePagingVO pVO);
}
