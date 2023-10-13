package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.CardVO;

@Mapper
public interface CardDAO {
	public int getCardDiscount(CardVO cvo);
	
	public List<CardVO> cardInfo(CardVO cvo);
}
