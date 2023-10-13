package com.disney.client.service;

import java.util.List;

import com.disney.vo.GoodsVO;

public interface GoodsService {
	public List<GoodsVO> goodsList(GoodsVO gvo);
	public int goodsListCnt(GoodsVO gvo);
	
	public GoodsVO goodsDetail(GoodsVO gvo);

}
