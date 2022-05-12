package com.meal.board.gr.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.meal.board.gr.dao.BoardGrDAO;
import com.meal.board.gr.vo.BoardGrVO;

@Service("boardGrService")
@Transactional(propagation = Propagation.REQUIRED)
public class BoardGrServiceImpl implements BoardGrService {

	@Autowired
	private BoardGrDAO boardGrDAO;

	public List<BoardGrVO> listBoardGr(BoardGrVO boardGrVO) throws Exception {
		return boardGrDAO.listBoardGr(boardGrVO);
	}

	public void boardGrWrite(BoardGrVO boardGrVO) throws Exception {
		boardGrDAO.boardGrWrite(boardGrVO);
	}

	public List<BoardGrVO> selectBoardGrList(HashMap<String, Object> map) throws Exception {
		List<BoardGrVO> listInfo = (List<BoardGrVO>) boardGrDAO.selectBoardGrList(map);
		return listInfo;
	}

	public BoardGrVO boardGrView(int b_gr_id) throws Exception {
		return boardGrDAO.boardGrView(b_gr_id);
	}

	public List<BoardGrVO> selectBoardGrallList() throws Exception {
		List<BoardGrVO> listInfo = (List<BoardGrVO>) boardGrDAO.selectBoardGrallList();
		return listInfo;
	}

	public List<BoardGrVO> boardGrViewReview(int b_gr_id) throws Exception {
		return (List<BoardGrVO>) boardGrDAO.boardGrViewReview(b_gr_id);
	}

	public void boardGrUpdate(BoardGrVO boardGrVO) throws Exception {
		boardGrDAO.boardGrUpdate(boardGrVO);
	}

	public void boardGrDelete(int b_gr_id) throws Exception {
		boardGrDAO.boardGrDelete1(b_gr_id);
		boardGrDAO.boardGrDelete2(b_gr_id);
	}

}
