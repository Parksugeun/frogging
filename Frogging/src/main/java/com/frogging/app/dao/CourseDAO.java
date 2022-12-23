package com.frogging.app.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.frogging.app.vo.CourseVO;

@Mapper
@Repository
public interface CourseDAO {

	// 코스 여러개 삭제
	public int courseMultiDel(CourseVO cvo);

	public int courseMultiDel_detail(CourseVO cvo);

}
