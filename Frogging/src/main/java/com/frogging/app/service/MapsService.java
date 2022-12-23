package com.frogging.app.service;

import java.util.List;

import com.frogging.app.vo.CoursePagingVO;
import com.frogging.app.vo.CourseVO;

public interface MapsService {
	public int courseInsert(CourseVO vo);
	public int courseCheck(int course_no);
	public int coursenoSearch(String course_name);
	public int coursedetailInsert(int course_no, int waypoint, String lat, String log, String addr);
	
	public List<CourseVO> courseAllselect();
	
	public int courseDelete(int course_no);
	
	public CourseVO courseSelect(int course_no);
	public List<CourseVO> detailSelect(int course_no);
	
	public int courseUpdate(CourseVO vo);
	public int waypointCheck(int course_no);
	public int coursedetailUpdate(int course_no, int waypoint, String lat, String log, String addr);
	public int waypointDelete(int course_no, int waypoint);
	
	public List<CourseVO> courseAllselect_t(CoursePagingVO cpvo);
	public List<CourseVO> detailAllselect_tt(int startCourse, int endCourse);
	public List<CourseVO> detailAllselect_t(int course_no1, int course_no2, int course_no3,int course_no4,int course_no5,int course_no6);
	
	public int nameCheck(String course_name);
	public int totalCourse(CoursePagingVO cpvo);
}
