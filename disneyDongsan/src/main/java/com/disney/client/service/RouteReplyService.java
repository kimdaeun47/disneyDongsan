package com.disney.client.service;

import java.util.List;

import com.disney.vo.RouteReplyVO;

public interface RouteReplyService {
	public List<RouteReplyVO> replyList(RouteReplyVO rvo);
	
	public int replyInsert(RouteReplyVO rvo);
	
	public int pwdConfirm(RouteReplyVO rvo);
	
	public int replyUpdate(RouteReplyVO rvo);
	
	public int replyDelete(int replyNo);
	
	public int replyChoiceDelete(int routeNo);
	
	
}
