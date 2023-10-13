package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.BasketVO;

@Mapper
public interface BasketDAO {
	
	public int addBasket(BasketVO bvo) throws Exception;
	
	public int deleteBasket(int basket_id);
	
	public int modifyCount(BasketVO bvo);
	
	public List<BasketVO> getBasketList(String member_id);
	
	public BasketVO checkBasket(BasketVO bvo);
	
	//장바구니 삭제
	public int deleteOrderBasket(BasketVO bvo);

}
