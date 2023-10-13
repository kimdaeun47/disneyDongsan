package com.disney.vo;

import java.util.List;

public class OrderVO {
	
	private List<OrderDetailVO> orders;
	
	public List<OrderDetailVO> getOrders(){
		return orders;
	}
	
	public void setOrders(List<OrderDetailVO> orders) {
		this.orders = orders;
	}
	
	@Override
	public String toString() {
		return "OrderVO [orders=" + orders + "]";
	}
	

}
