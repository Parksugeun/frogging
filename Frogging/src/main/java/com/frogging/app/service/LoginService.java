package com.frogging.app.service;

import com.frogging.app.vo.UserVO;

public interface LoginService {

	public int loginCheck(String id);
	public UserVO loginOk(String id);
	public int signUpOk(UserVO vo);
	public int nicknameCheck(String nickname)throws Exception;
	public int checkAdmin(String id);
}
