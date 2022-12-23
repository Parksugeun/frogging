package com.frogging.app.service;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;

import com.frogging.app.dao.CourseDAO;
import com.frogging.app.vo.CourseVO;

@Controller
public class CourseServiceImpl implements CourseService {

	@Inject
	CourseDAO dao;

	@Override
	public int courseMultiDel(CourseVO cvo) {
		return dao.courseMultiDel(cvo);
	}

	@Override
	public int courseMultiDel_detail(CourseVO cvo) {
		return dao.courseMultiDel_detail(cvo);
	}

}
