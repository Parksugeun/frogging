package com.frogging.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.frogging.app.service.AddrService;
import com.frogging.app.vo.AddrVO;

import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequestMapping("/addr/*")
public class AddrController {

	@Autowired
	AddrService a_service;

	// 주소지 목록 가져오기
	@GetMapping(value = "getAddrList")
	public List<AddrVO> getAddrList() {

		return null;
	}

}
