package com.frogging.app.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.frogging.app.dao.LoginDAO;
import com.frogging.app.vo.UserVO;

@Service
public class LoginServiceImpl implements LoginService {
	@Inject
	LoginDAO dao;
	
	@Override
	public int loginCheck(String id) {
		return dao.loginCheck(id);
	}

	@Override
	public UserVO loginOk(String id) {
		return dao.loginOk(id);
	}

	@Override
	public int signUpOk(UserVO vo) {
		return dao.signUpOk(vo);
	}

	@Override
	public int nicknameCheck(String nickname) throws Exception {
		// TODO Auto-generated method stub
		return dao.nicknameCheck(nickname);
	}

	@Override
	public int checkAdmin(String id) {
		// TODO Auto-generated method stub
		return dao.checkAdmin(id);
	}


}
