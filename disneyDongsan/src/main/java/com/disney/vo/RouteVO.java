package com.disney.vo;

import org.springframework.web.multipart.MultipartFile;

import com.disney.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

//equals와 hashCode 메소드 자동 생성 시 부모 클래스의 필드까지 감안할지 안할지에 대해서 설정시
//callSuper = true로 설정하면 부모 클래스 필드 값들도 동일 한지 체크하며,
//callSuper = false로 설정(기본값)하면 자신 클래스의 필드 값들만 고려한다.


@Data
@EqualsAndHashCode(callSuper = false)
public class RouteVO extends CommonVO {
	private int routeNo =0;				//번호
	private String routeTitle = "";		//제목
	private String routeContent = "";	//내용
	private String routeDate;			//작성일
	private int routeHits = 0;			//조회수
	private int routeGood = 0;			//좋아요수
	private String memberId = ""; 		//사용자 아이디
	
	private MultipartFile file; 	//파일 업로드를 위한 필드
	private String routeImage ="";	//실제서버에 저장할 파일명
	
	private String[] checkNumber;
	
	
	 
	
}
