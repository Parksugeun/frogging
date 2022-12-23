package com.frogging.app.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.frogging.app.service.ActivityService;
import com.frogging.app.service.EventService;
import com.frogging.app.vo.ActivityVO;
import com.frogging.app.vo.EventPagingVO;

@Controller
public class HomeController {

	ModelAndView mav = null;

	@Inject
	ActivityService a_service;

	@Inject
	EventService e_service;

	@GetMapping("/")
	public ModelAndView memberForm(EventPagingVO pVO) {

		mav = new ModelAndView();

		mav.setViewName("index");
		pVO.setTotalRecord(e_service.totalRecord(pVO));
		mav.addObject("list", e_service.eventList_home(pVO));
		mav.addObject("pVO", pVO);

		// List<ActivityVO> data = a_service.getPlogGraph();

		// System.out.println(data.toString().toString());
		mav.addObject("data", a_service.getPlogGraph());

		return mav;
	}
}
