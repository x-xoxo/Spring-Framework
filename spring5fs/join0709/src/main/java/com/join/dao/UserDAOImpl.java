package com.join.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.join.dto.UserVO;

@Repository
public class UserDAOImpl implements UserDAO{

	@Inject
	private SqlSession sqlSession;
	
	private static final String Namespace = "com.join.mapper.userMapper";
	
	
	@Override
	public void insertUser(UserVO userVO) throws Exception
	{
		sqlSession.insert(Namespace+".insertUser", userVO);
	}
	
	@Override
	public int checkEmail(UserVO userVO)  throws Exception
	{
		return sqlSession.selectOne(Namespace+".emailCheck", userVO);
	}
	
	@Override
	public int loginCheck(UserVO userVO)  throws Exception
	{
		return sqlSession.selectOne(Namespace+".loginCheck", userVO);
	}
	
}
