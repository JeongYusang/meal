package com.meal.goods.dao;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.meal.goods.vo.GoodsVO;

@Repository("goodsDAO")
public class GoodsDAOImpl implements GoodsDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void addNewGoods(HashMap<String,Object> newGoodsMap) throws DataAccessException{
		sqlSession.insert("mapper.goods.insertNewGoods",newGoodsMap);
		 
	}

	@Override
	public void addGoodsImg(HashMap<String, Object> map) throws DataAccessException{
		sqlSession.insert("mapper.goods.img_gInsert",map);
	}

	@Override
	public GoodsVO findg_id (String g_name) throws DataAccessException {
		GoodsVO gVO = (GoodsVO)sqlSession.selectOne("mapper.goods.findg_id", g_name);
		return gVO;
	}

	@Override
	public String selectOverlappedG_NAME(String g_name) throws DataAccessException {
		String result = (String)sqlSession.selectOne("mapper.goods.selectOverlappedG_NAME", g_name);
		return result;
	}

}
