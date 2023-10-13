package com.disney.client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.MypageGoodsDao;
import com.disney.vo.GoodsVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MypageGoodsServiceImpl implements MypageGoodsService{
	
	@Setter(onMethod_ = @Autowired)
	private MypageGoodsDao mypageGoodsDao;
	
	@Override
	public List<GoodsVO> myGoodsList(String username){
		List<GoodsVO> goodsList = null;
		goodsList = mypageGoodsDao.myGoodsList(username);
		log.info("goodsList = " + goodsList);
		return goodsList;
	}
	
	@Override
	public int stateUpdate(GoodsVO gvo) {
		int result = 0;
		result = mypageGoodsDao.stateUpdate(gvo);
		return result;
	}
	
	@Override
	public List<GoodsVO> userGoodsDetail(GoodsVO gvo) {
		List<GoodsVO> goodsList = null;
		goodsList = mypageGoodsDao.userGoodsDetail(gvo);
		
		return goodsList;
		
	}

}
