package com.frogging.app.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.frogging.app.vo.ActivityPagingVO;
import com.frogging.app.vo.ActivityVO;
import com.frogging.app.vo.CourseVO;

@Mapper
@Repository
public interface ActivityDAO {

	// 주간 횟수 리스트
	public List<ActivityVO> getWeeklyCount();

	// 주간 km 리스트
	public List<ActivityVO> getWeeklyKm();

	// 월간 횟수 리스트
	public List<ActivityVO> getMonthlyCount();

	// 월간 km 리스트
	public List<ActivityVO> getMonthlyKm();

	// 횟수 전체 랭킹
	public ActivityVO getRank_p(String id);

	// km 전체 랭킹
	public ActivityVO getRank_k(String id);

	// 유저 통계 가져오기
	public ActivityVO getUserStatistic(String id, String date_param);

	public ActivityVO getUserStatistic_w(String id, String date_param);

	public ActivityVO getUserStatistic_m(String id, String date_param);

	public ActivityVO getUserStatistic_y(String id, String date_param);

	// 유저 최근 활동 가져오기
	public List<ActivityVO> getActivityList(String id);

	// 유저 그래프 데이터 가져오기
	public List<ActivityVO> getGraph_w(String id);

	public List<ActivityVO> getGraph_m(String id);

	public List<ActivityVO> getGraph_y(String id);

	public List<ActivityVO> getGraph_t(String id);

	// 관리자 통계
	public List<ActivityVO> getPlogGraph();

	// 유저 통계
	public int numberOfBad();

	public int numberOfGood();

	public int numberOfActive();

	public int numberOfUnactive();

	// 쓰레기 통계
	public List<ActivityVO> getTrashGraph();
	
	public int activityInsert(ActivityVO avo);
	
	public int courseuserInsert(int course_no, String id, int waypoint, String lat, String log, int activity_no);
	
	public int getActivityNo(String id);
	
	public int totalUserCourse(ActivityPagingVO apvo);
	
	public List<ActivityVO> activityAllSelect(ActivityPagingVO apvo);
	
	public List<CourseVO> courseUserAllSelect(int activity_no1, int activity_no2, int activity_no3);
}
