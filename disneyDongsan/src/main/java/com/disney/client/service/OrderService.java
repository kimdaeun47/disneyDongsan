package com.disney.client.service;

import java.util.List;

import com.disney.vo.MemberVO;
import com.disney.vo.OrderDetailVO;
import com.disney.vo.OrderPayVO;

public interface OrderService {
	
	public List<OrderDetailVO> getGoodsInfo(List<OrderDetailVO> orders);
	
	public void order(OrderPayVO opv, MemberVO member);
	
		

}
