package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.GoodsVO;

@Mapper
public interface MypageGoodsDao {
	
	public List<GoodsVO> myGoodsList(String username);
	
	public int stateUpdate(GoodsVO gvo);
	
	public List<GoodsVO> userGoodsDetail(GoodsVO gvo);

}
 