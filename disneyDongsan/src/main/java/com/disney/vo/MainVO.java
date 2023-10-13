package com.disney.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MainVO {
	
	private int main_event_no = 0;
	private String main_event_title = "";
	private String main_event_image = "";
	
	private MultipartFile file; 
	

}
