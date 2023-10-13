package com.disney.client.service;

import java.util.List;

import com.disney.vo.GoodsVO;

public interface MypageGoodsService {
	
	public List<GoodsVO> myGoodsList(String username);
	
	public int stateUpdate(GoodsVO gvo);
	
	public List<GoodsVO> userGoodsDetail(GoodsVO gvo);

}
