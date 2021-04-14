package com.join.service;

import com.join.dto.UserVO;


public interface UserService {
	public int checkEmail(UserVO userVO)  throws Exception;
	public int loginCheck(UserVO userVO)  throws Exception;
	public void insertUser(UserVO userVO) throws Exception;
}
