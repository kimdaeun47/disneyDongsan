package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.RouteReplyVO;

@Mapper
public interface RouteReplyDao {
	public List<RouteReplyVO> replyList(RouteReplyVO rvo);
	
	public int replyInsert(RouteReplyVO rvo);
	
	public int pwdConfirm(RouteReplyVO rvo);
	
	public int replyUpdate(RouteReplyVO rvo);
	
	public int replyDelete(int replyNo);
	
	public int replyChoiceDelete(int routeNo);
	
	public int routeReplyCnt(int routeNo);
	

	
}
