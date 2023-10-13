package com.disney.vo;

import org.springframework.web.multipart.MultipartFile;

import com.disney.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class RestaurantVO extends CommonVO {

	private int restNo;
	private String restTitle;
	private String restSubTitle;
	private String restContent;
		
	private MultipartFile file; //파일 업로드를 위한 필드
	private String restImage;
		

}
