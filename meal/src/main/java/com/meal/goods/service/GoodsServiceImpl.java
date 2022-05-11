package com.meal.goods.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.meal.goods.dao.GoodsDAO;
import com.meal.goods.vo.GoodsVO;
import com.meal.seller.vo.SellerVO;

@Service("GoodsService")
@Transactional(propagation = Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService {
	@Autowired
	private GoodsDAO goodsDAO;
	

	@Override
	public void addNewGoods(HashMap<String, Object> newGoodsMap) throws Exception {
		goodsDAO.addNewGoods(newGoodsMap);
		
	}

	@Override
	public void addGoodsImg(HashMap<String, Object> map) throws Exception {
		goodsDAO.addGoodsImg(map);
		
	}
	@Override
	public GoodsVO findg_id (String g_name) throws Exception{
		return goodsDAO.findg_id(g_name);
	}

	@Override
	public String goodsoverlapped(String g_name) throws Exception {
		String result = goodsDAO.selectOverlappedG_NAME(g_name);
		return result;
	}

}
