package com.disney.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import com.disney.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)	
public class GoodsVO extends CommonVO {
	private int g_id =0;
	private String g_name ="";
	private String g_detail ="";
	private int g_price =0;

	private String g_origin ="";
	private String g_company ="";
	private String g_delivery ="";
	private Date g_date;
	
	private MultipartFile file;
	private String g_image ="";
	
	private MultipartFile file_detail;
	private String g_image_detail ="";
	
	private String g_order_id;
	private int g_count;
	private String g_order_date;
	private String g_order_state;
	private String member_addr1;
	private String member_addr2;
	private String member_addr3;
	private String member_name;
	private int total_price;
	private String[] goodsArr;
	
}
