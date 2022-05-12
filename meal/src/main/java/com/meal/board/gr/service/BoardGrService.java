package com.meal.board.gr.service;

import java.util.HashMap;
import java.util.List;

import com.meal.board.gr.vo.BoardGrVO;

public interface BoardGrService {

	public List<BoardGrVO> listBoardGr(BoardGrVO boardGrVO) throws Exception;

	public void boardGrWrite(BoardGrVO boardGrVO) throws Exception;

	public List<BoardGrVO> selectBoardGrList(HashMap<String, Object> map) throws Exception;

	public BoardGrVO boardGrView(int b_gr_id) throws Exception;

	public List<BoardGrVO> selectBoardGrallList() throws Exception;

	public List<BoardGrVO> boardGrViewReview(int b_gr_id) throws Exception;

	public void boardGrUpdate(BoardGrVO boardGrVO) throws Exception;

	public void boardGrDelete(int b_gr_id) throws Exception;

}
