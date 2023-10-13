package com.disney.client.service;


import java.util.List;

import com.disney.vo.BasketVO;

public interface BasketService {
	public int addBasket(BasketVO bvo);
	
	public List<BasketVO> getBasketList(String member_id);
	
	public int modifyCount(BasketVO bvo);
	
	public int deleteBasket(int basket_id);

}
