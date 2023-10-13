package com.disney.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BasketVO {
	private int basket_id =0;
	private String member_id ="";
	private int g_id =0;
	private int g_count =0;
	
	
	//상품
	private String g_name ="";
	private int g_price = 0;
	
	private MultipartFile file;
	private String g_image ="";
	
	
	
	private int g_total_price =0;
	
	public void initTotal() {
		this.g_total_price = this.g_price*this.g_count;
	}

}
