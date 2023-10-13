package com.disney.client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.CardDAO;
import com.disney.vo.CardVO;

import lombok.Setter;

@Service
public class CardServiceImpl implements CardService {

	@Setter(onMethod_ = @Autowired)
	private CardDAO cardDAO;
	
	@Override
	public int getCardDiscount(CardVO cvo) {
		int discountRate = 0;
		discountRate = cardDAO.getCardDiscount(cvo);
		return discountRate;
	}
	
	@Override
	public List<CardVO> cardInfo(CardVO cvo) {
		List<CardVO> list = null;
		list = cardDAO.cardInfo(cvo);
		return list;
	}

}
