package com.disney.vo;

import org.springframework.web.multipart.MultipartFile;

import com.disney.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class EventVO extends CommonVO{
	
	private int e_no = 0;
	private String e_title = "";
	private String e_content = "";
	private String e_start;			// 시작일
	private String e_end;			// 종료일
	private String e_time;
	
	private MultipartFile file1;
	private MultipartFile file2;
	private MultipartFile fileT;
	
	private String e_img1 = "";
	private String e_img2 = "";
	private String e_thum = "";
	
	private String[] checkNumber;
	
	

	
}
