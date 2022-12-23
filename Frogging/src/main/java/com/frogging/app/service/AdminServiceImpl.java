package com.frogging.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.jdbc.core.SqlReturnResultSet;
import org.springframework.stereotype.Service;

import com.frogging.app.dao.AdminDAO;
import com.frogging.app.vo.CommunityVO;
import com.frogging.app.vo.CustomerServiceVO;
import com.frogging.app.vo.EventPagingVO;
import com.frogging.app.vo.EventVO;
import com.frogging.app.vo.ManagePagingVO;
import com.frogging.app.vo.PagingVO;
import com.frogging.app.vo.QnaVO;
import com.frogging.app.vo.UserVO;

@Service
public class AdminServiceImpl implements AdminService {
	@Inject
	AdminDAO dao;

	@Override
	public List<UserVO> userList() {
		// TODO Auto-generated method stub
		return dao.userList();
	}

	@Override
	public int listDel(String id) {
		// TODO Auto-generated method stub
		return dao.listDel(id);
	}

	@Override
	public UserVO getProfile(String id) {
		// TODO Auto-generated method stub
		return dao.getProfile(id);
	}

	@Override
	public int editProfile(String id, int restriction) {
		// TODO Auto-generated method stub
		return dao.editProfile(id, restriction);
	}

	@Override
	public List<CommunityVO> communityList(PagingVO pVO) {
		// TODO Auto-generated method stub
		return dao.communityList(pVO);
	}

	@Override
	public int totalRecord(PagingVO pVO) {
		// TODO Auto-generated method stub
		return dao.totalRecord(pVO);
	}

	@Override
	public List<CustomerServiceVO> customerServiceList(PagingVO pVO) {
		return dao.customerServiceList(pVO);
	}

	@Override
	public int customerServiceEditOk(CustomerServiceVO vo) {
		return dao.customerServiceEditOk(vo);
	}

	@Override
	public int customerServiceDel(int no, String id) {
		return dao.customerServiceDel(no, id);
	}

	@Override
	public CustomerServiceVO getcustomerService(int no) {
		return dao.getcustomerService(no);
	}

	@Override
	public int eventEdit(EventVO vo) {
		return dao.eventEdit(vo);
	}

	@Override
	public int eventDel(int no, String id) {
		return dao.eventDel(no, id);
	}

	@Override
	public QnaVO getQna(int no) {
		return dao.getQna(no);
	}

	@Override
	public int qnaEditOk(QnaVO vo) {
		return dao.qnaEditOk(vo);
	}

	@Override
	public int qnaDel(int reply_group) {
		return dao.qnaDel(reply_group);
	}

	@Override
	public int totalRecord2(PagingVO pVO) {

		return dao.totalRecord2(pVO);
	}

	@Override
	public List<QnaVO> qnaList(PagingVO pVO) {
		return dao.qnaList(pVO);
	}

	@Override
	public int totalRecord3(PagingVO pVO) {
		return dao.totalRecord3(pVO);
	}

	@Override
	public List<EventVO> eventList(EventPagingVO pVO) {
		return dao.eventList(pVO);
	}

	@Override
	public int totalRecord4(EventPagingVO pVO) {
		return dao.totalRecord4(pVO);
	}

	@Override
	public int totalRecord5(ManagePagingVO pVO) {
		return dao.totalRecord5(pVO);
	}

	@Override
	public int totalRecord6(ManagePagingVO pVO) {
		return dao.totalRecord6(pVO);
	}

	@Override
	public int qnaDel2(int no, String id) {
		return dao.qnaDel2(no, id);
	}
}
