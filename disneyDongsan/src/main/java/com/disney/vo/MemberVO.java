package com.disney.vo;

import com.disney.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class MemberVO extends CommonVO{
	private String memberNo;
	private String memberId = "";
	private String memberPasswd = "";
	private String memberName = "";
	private String memberPhone = "";
	private String memberEmail = "";
	private String memberAddr1 = "";
	private String memberAddr2 = "";
	private String memberAddr3 = "";
	private String memberRegdate = "";
	private String memberState = "";
	
	private String new_password = "";
}
