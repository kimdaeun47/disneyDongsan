package com.disney.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class OrderDetailVO {
	//뷰에서 꺼낼값
	private int g_id =0;
	private int g_count =0;
	
	//이미지
	private MultipartFile file;
	private String g_image = "";
	
	//DB에서 꺼낼값
	private String g_name ="";
	private int g_price =0;
	
	//새로추가되는 값
	private int g_total_price;
	
	public void initTotal() {
		this.g_total_price = this.g_price*this.g_count;
	}
}
