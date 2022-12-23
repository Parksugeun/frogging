package com.frogging.app.service;

import java.util.List;

import com.frogging.app.vo.AddrVO;

public interface DataService {
	public List<AddrVO> getAddr_1();

	public List<AddrVO> getAddr_2(String addr_1);
}
