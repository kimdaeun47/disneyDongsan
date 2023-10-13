package com.disney.admin.service;

import java.util.List;

import com.disney.vo.RouteReplyVO;

public interface AdminRouteReplyService {
	public List<RouteReplyVO> adminReplyList(RouteReplyVO rvo);
	
	public int adminReplyDelete(int replyNo);
	
	public int adminReplyChoiceDelete(int routeNo);
	
	public int adminAllRouteReplyDelete(RouteReplyVO rvo)throws Exception;
	
	
}
