package com.meal.board.gr.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.meal.board.gr.vo.BoardGrVO;
import com.meal.board.gr.vo.Img_grVO;

@Repository("boardGrDAO")
public class BoardGrDAOImpl implements BoardGrDAO {

	@Autowired
	private SqlSession sqlSession;
	
	/*
	 * @Override public void boardGrWrite(BoardGrVO boardGrVO) throws
	 * DataAccessException { sqlSession.insert("mapper.boardGr.boardGrWrite",
	 * boardGrVO); }
	 */

	@Override
	public List<BoardGrVO> selectBoardGrList(HashMap<String, Object> map) throws DataAccessException {
		List<BoardGrVO> boardInfo = (List<BoardGrVO>) sqlSession.selectList("mapper.boardGr.boardGrPage", map);
		return boardInfo;
	}

	@Override
	public List<BoardGrVO> selectBoardGrallList() throws DataAccessException {
		List<BoardGrVO> boardInfo = (List<BoardGrVO>) sqlSession.selectList("mapper.boardGr.selectBoardGrallList");
		return boardInfo;
	}

	@Override
	public List<BoardGrVO> boardGrViewReview(int b_gr_id) throws DataAccessException {
		return sqlSession.selectList("mapper.boardGr.boardGrViewReview", b_gr_id);
	}
	@Override
	public BoardGrVO selectBoardGrDetail(int b_gr_id) throws DataAccessException{
		BoardGrVO boardGrVO=(BoardGrVO)sqlSession.selectOne("mapper.boardGr.selectBoardGrDetail",b_gr_id);
		return boardGrVO;
	}
	
	@Override
	public List<Img_grVO> selectBoardGrDetailImage(int b_gr_id) throws DataAccessException{
		List<Img_grVO> imageList=(ArrayList)sqlSession.selectList("mapper.boardGr.selectBoardGrDetailImage",b_gr_id);
		return imageList;
	}

	@Override
	public void boardGrUpdate(BoardGrVO boardGrVO) throws DataAccessException {
		sqlSession.update("mapper.boardGr.boardGrUpdate", boardGrVO);
	}

	@Override
	public void boardGrDelete1(int b_gr_id) throws DataAccessException {
		sqlSession.delete("mapper.boardGr.boardGrDelete1", b_gr_id);
	}

	@Override
	public void boardGrDelete2(int b_gr_id) throws DataAccessException {
		sqlSession.delete("mapper.boardGr.boardGrDelete2", b_gr_id);
	}

	@Override
	public void boardGrWrite(HashMap<String, Object> newboardGrMap) throws DataAccessException {
		sqlSession.insert("mapper.boardGr.boardGrWrite",newboardGrMap);		
	}

	@Override
	public void addImg(HashMap<String, Object> item) throws DataAccessException {
		sqlSession.insert("mapper.boardGr.addImg",item);	
	}
	
	@Override
	public BoardGrVO findb_gr_id() throws DataAccessException {
		return (BoardGrVO) sqlSession.selectOne("mapper.boardGr.findb_gr_id");
	}

}
