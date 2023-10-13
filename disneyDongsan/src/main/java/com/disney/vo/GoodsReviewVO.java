package com.disney.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class GoodsReviewVO {

	private int g_order_detail_id; // 주문상세번호
	private int detail_num; // 주문상세번호
	private String g_image; // 상품대표 이미지
	private String g_name; // 상품명
	private String g_order_date; // 주문날짜
	private String g_order_state; // 주문 상태
	private int g_price;

  private int g_id; //주문 아이디
	private String member_id; // 회원 아이디(g_order쪽)

	private String r_member_id; // 회원 아이디(g_review 쪽)
	private String content_check; //후기 상태
	
	private int re_id = 0; //댓글id
	private String re_content = ""; //내용
	private String re_date = ""; //등록일
	
	private MultipartFile file; 
	private String re_image = ""; //사진

	

}
