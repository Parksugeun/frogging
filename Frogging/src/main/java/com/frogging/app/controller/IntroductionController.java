package com.frogging.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IntroductionController {
	@GetMapping("introductionForm")
	public ModelAndView memberForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("introduction/introductionForm");
		return mav;
	}
}
