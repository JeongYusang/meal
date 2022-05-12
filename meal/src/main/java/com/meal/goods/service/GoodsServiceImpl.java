package com.meal.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.meal.goods.dao.GoodsDAO;
import com.meal.goods.vo.GoodsVO;
import com.meal.goods.vo.Img_gVO;
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
	
	/*
	 * public Map<String,List<GoodsVO>> listGoods() throws Exception {
	 * Map<String,List<GoodsVO>> goodsMap=new HashMap<String,List<GoodsVO>>();
	 * List<GoodsVO> goodsList=goodsDAO.selectGoodsList("NewGoods");
	 * goodsMap.put("bestseller",goodsList);
	 * goodsList=goodsDAO.selectGoodsList("newbook");
	 * goodsMap.put("newbook",goodsList);
	 * 
	 * goodsList=goodsDAO.selectGoodsList("steadyseller");
	 * goodsMap.put("steadyseller",goodsList); return goodsMap; }
	 * 
	 * @Override public HashMap<String, Object> goodsDetail(int g_id) throws
	 * Exception { HashMap<String, Object> goodsMap=new HashMap<String, Object>();
	 * GoodsVO goodsVO = goodsDAO.selectGoodsDetail(g_id); goodsMap.put("goodsVO",
	 * goodsVO); List<Img_gVO> imageList =goodsDAO.selectGoodsDetailImage(g_id);
	 * goodsMap.put("imageList", imageList); return goodsMap; }
	 */
}
