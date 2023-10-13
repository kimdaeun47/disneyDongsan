package com.disney.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.RouteReplyVO;

@Mapper
public interface AdminRouteReplyDao {
	public List<RouteReplyVO> adminReplyList(RouteReplyVO rvo);

	public int adminReplyDelete(int replyNo);
	
	public int adminReplyChoiceDelete(int routeNo);
	
	public int adminRouteReplyCnt(int routeNo);
	
	public int adminAllRouteReplyDelete(RouteReplyVO rvo);
	
}
