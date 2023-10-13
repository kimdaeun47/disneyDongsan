package com.disney.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class OrderDetailPayVO {
	
	private String g_order_id;
	
	private String member_id;
	
	private String member_name;
	
	private String member_addr1;
	private String member_addr2;
	private String member_addr3;
	
	private String g_order_state;
	
	private String merchant_uid;
	private String imp_uid;
	private int paid_amount;
	
	private int g_id;
	
	private MultipartFile file;
	private String g_image;
	
	private int g_count;
	
	private String g_name;
	
	private int g_order_detail_id;
	
	private int g_price;
	
	private int g_total_price;
	
	public void initTotal() {
		this.g_total_price = this.g_price*this.g_count;
	}

}
