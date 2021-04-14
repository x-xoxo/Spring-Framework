package com.join.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.join.dto.Board;
import com.join.dto.BoardReply;

@Repository("boardDao")
public class BoardDAOImpl implements BoradDAO{

    @Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.join.mapper.boardMapper";
    
     
    @Override
    public int regContent(Map<String, Object> paramMap) {
        return sqlSession.insert(Namespace+".insertContent", paramMap);
    }
    
    @Override
    public int modifyContent(Map<String, Object> paramMap) {
        return sqlSession.update(Namespace+".updateContent", paramMap);
    }
 
    @Override
    public int getContentCnt(Map<String, Object> paramMap) {
        return sqlSession.selectOne(Namespace+".selectContentCnt", paramMap);
    }
    
    @Override
    public List<Board> getContentList(Map<String, Object> paramMap) {
        return sqlSession.selectList(Namespace+".selectContent", paramMap);
    }
 
    @Override
    public Board getContentView(Map<String, Object> paramMap) {
        return sqlSession.selectOne(Namespace+".selectContentView", paramMap);
    }
 
    @Override
    public int regReply(Map<String, Object> paramMap) {
        return sqlSession.insert(Namespace+".insertBoardReply", paramMap);
    }
 
    @Override
    public List<BoardReply> getReplyList(Map<String, Object> paramMap) {
        return sqlSession.selectList(Namespace+".selectBoardReplyList", paramMap);
    }
 
    @Override
    public int delReply(Map<String, Object> paramMap) {
        if(paramMap.get("r_type").equals("main")) {
            //부모부터 하위 다 지움
            return sqlSession.delete(Namespace+".deleteBoardReplyAll", paramMap);
        }else {
            //자기 자신만 지움
            return sqlSession.delete(Namespace+".deleteBoardReply", paramMap);
        }
        
        
    }
 
    @Override
    public int getBoardCheck(Map<String, Object> paramMap) {
        return sqlSession.selectOne(Namespace+".selectBoardCnt", paramMap);
    }
 
    @Override
    public int delBoard(Map<String, Object> paramMap) {
        return sqlSession.delete(Namespace+".deleteBoard", paramMap);
    }
 
    @Override
    public boolean checkReply(Map<String, Object> paramMap) {
        int result = sqlSession.selectOne(Namespace+".selectReplyPassword", paramMap);
                
        if(result>0) {
            return true;
        }else {
            return false;
        }
        
    }
 
    @Override
    public boolean updateReply(Map<String, Object> paramMap) {
        int result = sqlSession.update(Namespace+"updateReply", paramMap);
        
        if(result>0) {
            return true;
        }else {
            return false;
        }
    }
	
}
