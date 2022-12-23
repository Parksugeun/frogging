package com.frogging.app.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.frogging.app.vo.ActivityVO;
import com.frogging.app.vo.CommunityVO;
import com.frogging.app.vo.CoursePagingVO;
import com.frogging.app.vo.CourseVO;
import com.frogging.app.vo.CustomerServiceVO;
import com.frogging.app.vo.MyPagingVO;
import com.frogging.app.vo.QnaVO;
import com.frogging.app.vo.UserVO;

@Mapper
@Repository
public interface UserDAO {
	// 유저 상세정보
	public UserVO getUserDetail(String id);

	// 유저 상세정보 저장
	public int detailEditOk(UserVO vo);

	// 유저가 쓴 글 - 커뮤니티 리스트
	public List<CommunityVO> getMyWrite(String id);

	// 유저가 쓴 글 - 큐앤에이 리스트
	public List<QnaVO> getMyWrite_qna(String id);

	// 유저가 쓴 글 - 고객센터 리스트
	public List<CustomerServiceVO> getMyWrite_service(String id);

	// 유저의 달성 기록 쓰레기+키로미터 총
	public ActivityVO getRecord(String id);

	// 유저가 만든 코스
	public List<CourseVO> getUserCourse(MyPagingVO mvo);

	public List<CourseVO> courseAllselect_t(MyPagingVO mvo);

	// 유저 코스 페이징
	public int setTotalRecord_my(MyPagingVO mvo);

	// 유저 상태 확인
	public int checkUserStatus(String id);
}
