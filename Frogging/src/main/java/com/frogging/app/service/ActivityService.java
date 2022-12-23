package com.frogging.app.service;

import java.util.List;

import com.frogging.app.vo.ActivityPagingVO;
import com.frogging.app.vo.ActivityVO;
import com.frogging.app.vo.CourseVO;

public interface ActivityService {
	public List<ActivityVO> getWeeklyCount();

	public List<ActivityVO> getWeeklyKm();

	public List<ActivityVO> getMonthlyCount();

	public List<ActivityVO> getMonthlyKm();

	public ActivityVO getRank_p(String id);

	public ActivityVO getRank_k(String id);

	public ActivityVO getUserStatistic(String id, String date_param);

	public ActivityVO getUserStatistic_w(String id, String date_param);

	public ActivityVO getUserStatistic_m(String id, String date_param);

	public ActivityVO getUserStatistic_y(String id, String date_param);

	public List<ActivityVO> getActivityList(String id);

	public List<ActivityVO> getGraph_w(String id);

	public List<ActivityVO> getGraph_m(String id);

	public List<ActivityVO> getGraph_y(String id);

	public List<ActivityVO> getGraph_t(String id);

	public List<ActivityVO> getPlogGraph();

	public int numberOfBad();

	public int numberOfGood();

	public int numberOfActive();

	public int numberOfUnactive();

	public List<ActivityVO> getTrashGraph();
	
	public int activityInsert(ActivityVO avo);
	
	public int courseuserInsert(int course_no, String id, int waypoint, String lat, String log, int activity_no);
	
	public int getActivityNo(String id);
	
	public int totalUserCourse(ActivityPagingVO apvo);
	
	public List<ActivityVO> activityAllSelect(ActivityPagingVO apvo);
	
	public List<CourseVO> courseUserAllSelect(int activity_no1, int activity_no2, int activity_no3);
}
