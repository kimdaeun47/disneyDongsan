package com.disney.client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.BasketDAO;
import com.disney.vo.BasketVO;

import lombok.Setter;

@Service
public class BasketServiceImpl implements BasketService{
	
	@Setter(onMethod_ = @Autowired)
	private BasketDAO basketDao;
	
	//장바구니 추가
	@Override
	public int addBasket(BasketVO bvo) {
		//장바구니 데이터 체크
		BasketVO checkBasket = basketDao.checkBasket(bvo);
		
		if(checkBasket != null) {
			return 2;
		}
		//장바구니 등록&에러 시 0 반환
		try {
				return basketDao.addBasket(bvo);
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("장바구니 등록 중 예외 발생: " + e.getMessage());
			return 0;
		}
		
	}
	
	// 장바구니 리스트
	@Override
	public List<BasketVO> getBasketList(String member_id){
		
		List<BasketVO> basket = basketDao.getBasketList(member_id);
		
		for(BasketVO bvo : basket) {
			bvo.initTotal();
		}
		
		return basket;
	}
	
	//장바구니 수량 수정
	@Override
	public int modifyCount(BasketVO bvo) {
		return basketDao.modifyCount(bvo);
	}
	
	//장바구니 삭제
	@Override
	public int deleteBasket(int basket_id) {
		
		return basketDao.deleteBasket(basket_id);
	}

}
