package com.meal.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;

import com.meal.goods.vo.GoodsVO;

public interface GoodsService {
	public void addNewGoods(HashMap<String, Object> newGoodsMap) throws Exception;
	public void addGoodsImg(HashMap<String, Object> map) throws Exception;
	public GoodsVO findg_id (String g_name) throws Exception;
	public String goodsoverlapped(@RequestParam("g_name") String g_name) throws Exception;
}
