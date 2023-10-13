package com.disney.vo;

import com.disney.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class TicketVO extends CommonVO {
	private long 	PAYMENT_ID;
	private String 	visit_date;
	private String 	t_category;
	private int 	t_adult =0;
	private int 	t_student =0;
	private int 	t_child =0;
	private int 	t_multi =0;
	private int 	t_afternoon =0;
	private String 	card_company;
	private int 	allday_price;
	private int 	total_price;
	private String 	pay_date;
	private String 	t_member_id;
	private String t_state;
	private String member_name;
	private String[] ticketArr;
}
