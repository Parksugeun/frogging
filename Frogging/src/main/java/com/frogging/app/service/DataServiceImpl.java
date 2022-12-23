package com.frogging.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.frogging.app.dao.DataDAO;
import com.frogging.app.vo.AddrVO;

@Service
public class DataServiceImpl implements DataService {

	@Inject
	DataDAO dao;

	@Override
	public List<AddrVO> getAddr_1() {
		return dao.getAddr_1();
	}

	@Override
	public List<AddrVO> getAddr_2(String addr_1) {
		return dao.getAddr_2(addr_1);
	}

}
