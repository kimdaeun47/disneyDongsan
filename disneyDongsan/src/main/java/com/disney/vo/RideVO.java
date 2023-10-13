package com.disney.vo;

import org.springframework.web.multipart.MultipartFile;

import com.disney.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class RideVO extends CommonVO {
	private int rideNo;
	private String rideTitle;
	private String rideSubTitle;
	private String rideContent;
	
	private MultipartFile file; //파일 업로드를 위한 필드
	private String rideImage;
	

}
