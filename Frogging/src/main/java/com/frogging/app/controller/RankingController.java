package com.frogging.app.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.frogging.app.service.ActivityService;
import com.frogging.app.vo.ActivityVO;

@RestController
@RequestMapping("/ranking/*")
public class RankingController {

	ModelAndView mav = null;

	@Inject
	ActivityService a_service;

	@GetMapping("rankingForm")
	public ModelAndView memberForm() {
		mav = new ModelAndView();

		mav.addObject("list_1", a_service.getWeeklyCount());
		mav.addObject("list_2", a_service.getWeeklyKm());
		mav.addObject("list_3", a_service.getMonthlyCount());
		mav.addObject("list_4", a_service.getMonthlyKm());

		mav.setViewName("ranking/rankingForm");
		return mav;
	}
}
