package com.frogging.app.service;


import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.frogging.app.dao.CustomerServiceDAO;
import com.frogging.app.vo.PagingVO;
import com.frogging.app.vo.CustomerServiceVO;


@Service
public class CustomerServiceServiceImpl implements CustomerServiceService{
	@Inject
	CustomerServiceDAO dao;

	@Override
	public List<CustomerServiceVO> customerServiceList(PagingVO pVO) {
		return dao.customerServiceList(pVO);
	}

	@Override
	public int customerServiceDel(int reply_group, String id) {
		return dao.customerServiceDel(reply_group, id);
	}

	@Override
	public void hitCount(int no) {
		dao.hitCount(no);
		
	}

	@Override
	public CustomerServiceVO getcustomerService(int no) {
		return dao.getcustomerService(no);
	}

	@Override
	public int customerServiceWriteOk(CustomerServiceVO vo) {
		return dao.customerServiceWriteOk(vo);
	}

	@Override
	public int customerServiceReplyOk(CustomerServiceVO vo) {
		return dao.customerServiceReplyOk(vo);
	}
	
	@Override
	public CustomerServiceVO getcustomerServiceReplyInfo(CustomerServiceVO vo) {	
		return dao.getcustomerServiceReplyInfo(vo);
	}
	

	@Override
	public int customerServiceEditOk(CustomerServiceVO vo) {	
		return dao.customerServiceEditOk(vo);
	}

	@Override
	public int customerServiceUpdate(CustomerServiceVO vo) {
		return dao.customerServiceUpdate(vo);
	}

	@Override
	public CustomerServiceVO customerServiceReply(int no) {
		return dao.customerServiceReply(no);
	}

	@Override
	public int totalRecord(PagingVO pVO) {
		return dao.totalRecord(pVO);
	}

	@Override
	public int customerServiceDel2(int no, String id) {
		return dao.customerServiceDel2(no, id);
	}
	
	
}
