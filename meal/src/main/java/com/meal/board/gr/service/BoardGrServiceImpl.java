package com.meal.board.gr.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.meal.board.gr.dao.BoardGrDAO;
import com.meal.board.gr.vo.BoardGrVO;
import com.meal.board.gr.vo.Img_grVO;

@Service("boardGrService")
@Transactional(propagation = Propagation.REQUIRED)
public class BoardGrServiceImpl implements BoardGrService {

	@Autowired
	private BoardGrDAO boardGrDAO;

	public List<BoardGrVO> selectBoardGrList(HashMap<String, Object> map) throws Exception {
		List<BoardGrVO> listInfo = (List<BoardGrVO>) boardGrDAO.selectBoardGrList(map);
		return listInfo;
	}

	public List<BoardGrVO> selectBoardGrallList() throws Exception {
		List<BoardGrVO> listInfo = (List<BoardGrVO>) boardGrDAO.selectBoardGrallList();
		return listInfo;
	}

	public Map boardGrView(int b_gr_id) throws Exception {
		Map boardGrMap=new HashMap();
		BoardGrVO boardGrVO = boardGrDAO.selectBoardGrDetail(b_gr_id);
		boardGrMap.put("boardGrVO", boardGrVO);
		List<Img_grVO> imageList =boardGrDAO.selectBoardGrDetailImage(b_gr_id);
		boardGrMap.put("imageList", imageList);
		return boardGrMap;

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

	@Override
	public void boardGrWrite(HashMap<String, Object> newboardGrMap) throws Exception {
		boardGrDAO.boardGrWrite(newboardGrMap);

	}

	@Override
	public void addImg(HashMap<String, Object> item) throws Exception {
		boardGrDAO.addImg(item);

	}

	@Override
	public BoardGrVO findb_gr_id() throws Exception {
		return boardGrDAO.findb_gr_id();
	}

}
