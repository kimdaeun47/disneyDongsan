package com.disney.client.service;

import java.util.List;

import com.disney.vo.CardVO;

public interface CardService {
	public int getCardDiscount(CardVO cvo);
	
	public List<CardVO> cardInfo(CardVO cvo);
}
