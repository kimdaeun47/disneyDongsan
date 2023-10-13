package com.disney.vo;

import com.disney.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
public class RouteReplyVO extends CommonVO{
	private int replyNo=0;			//댓글번호
	private int routeNo=0;			//게시판 글번호
	private String replyMemberId ="";		//댓글 작성자
	private String replyContent ="";	//댓글 내용
	private String replyDate ="";		//댓글 작성일
	
	private String[] checkNumber;

}
