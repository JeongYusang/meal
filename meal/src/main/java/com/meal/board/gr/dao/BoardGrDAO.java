package com.meal.board.gr.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.meal.board.gr.vo.BoardGrVO;

public interface BoardGrDAO {
	public List<BoardGrVO> listBoardGr(BoardGrVO boardGrVO) throws DataAccessException;

	public void boardGrWrite(BoardGrVO boardGrVO) throws DataAccessException;

	public List<BoardGrVO> selectBoardGrList(HashMap<String, Object> map) throws DataAccessException;

	public BoardGrVO boardGrView(int b_gr_id) throws DataAccessException;

	public List<BoardGrVO> selectBoardGrallList() throws DataAccessException;

	public List<BoardGrVO> boardGrViewReview(int b_gr_id) throws DataAccessException;

	public void boardGrUpdate(BoardGrVO boardGrVO) throws DataAccessException;

	public void boardGrDelete1(int b_gr_id) throws DataAccessException;

	public void boardGrDelete2(int b_gr_id) throws DataAccessException;

}
