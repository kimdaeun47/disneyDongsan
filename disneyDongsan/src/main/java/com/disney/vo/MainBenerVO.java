package com.disney.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MainBenerVO {
	private int main_bener_no = 0;
	private String main_event_bener_image = "";
	
	private MultipartFile file; 

}
