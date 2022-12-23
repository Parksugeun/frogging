package com.frogging.app.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.frogging.app.vo.AddrVO;

@Mapper
@Repository
public interface DataDAO {
	// 주소지 대분류 가져오기
	public List<AddrVO> getAddr_1();

	// 주소지 소분류 가져오기
	public List<AddrVO> getAddr_2(String addr_1);
}
