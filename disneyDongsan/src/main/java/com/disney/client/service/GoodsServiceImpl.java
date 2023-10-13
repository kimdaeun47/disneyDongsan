package com.disney.client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.GoodsDAO;
import com.disney.vo.GoodsVO;

import lombok.Setter;

@Service
public class GoodsServiceImpl implements GoodsService{
	
	@Setter(onMethod_ = @Autowired)
	private GoodsDAO goodsDao;
	
	@Override
	public List<GoodsVO> goodsList(GoodsVO gvo){
		List<GoodsVO> list = null;
		list = goodsDao.goodsList(gvo);
		return list;
	}
	
	@Override
	public int goodsListCnt(GoodsVO gvo) {
		return goodsDao.goodsListCnt(gvo);
	}
	
	@Override
	public GoodsVO goodsDetail(GoodsVO gvo) {
		GoodsVO detail = goodsDao.goodsDetail(gvo);
		if(detail!=null) {
			detail.setG_detail(detail.getG_detail().toString().replace("\n", "<br />"));
		}
		return detail;
	}

}
