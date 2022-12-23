package com.frogging.app.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.frogging.app.vo.UserVO;

@Mapper
@Repository
public interface LoginDAO {
	public int loginCheck(String id);
	public UserVO loginOk(String id);
	public int signUpOk(UserVO vo);
	public int nicknameCheck(String nickname)throws Exception;
	public int checkAdmin(String id);
}
