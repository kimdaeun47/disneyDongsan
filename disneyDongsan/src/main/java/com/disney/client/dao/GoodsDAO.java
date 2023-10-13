package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.GoodsVO;

@Mapper
public interface GoodsDAO {
	public List<GoodsVO> goodsList(GoodsVO gvo);
	public int goodsListCnt(GoodsVO gvo);
	
	public GoodsVO goodsDetail(GoodsVO gvo);

}
