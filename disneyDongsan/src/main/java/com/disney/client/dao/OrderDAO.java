package com.disney.client.dao;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.OrderDetailPayVO;
import com.disney.vo.OrderDetailVO;
import com.disney.vo.OrderPayVO;

@Mapper
public interface OrderDAO {
	
	public OrderDetailVO getGoodsInfo(int g_id);
	
	public OrderDetailPayVO getOrderInfo(int g_id);
	
	public int enrollOrder(OrderPayVO opv);
	
	public int enrollOrderItem(OrderDetailPayVO odpv);
	
	
}
