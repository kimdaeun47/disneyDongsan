package com.disney.vo;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderPayVO {
	
	private String g_order_id;
	
	private String member_name;
	
	private String member_id;
	
	private String member_addr1;
	private String member_addr2;
	private String member_addr3;
	
	private String g_order_state;
	
	private List<OrderDetailPayVO> orders;

	private int delivery_cost;
	
	private Date g_order_date;
	
	private String merchant_uid;
	private String imp_uid;
	private int paid_amount;
	
	private int orderPrice;
	private int orderFinalPrice;
	
	public void getOrderPriceInfo() {
		/* 배송비용 */
			if(orderPrice >= 30000) {
				delivery_cost = 0;
			} else {
				delivery_cost = 3000;
			}
		/* 최종 비용(상품 비용 + 배송비) */
			orderFinalPrice = orderPrice + delivery_cost;
	}
}
