package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.RouteVO;


@Mapper
public interface RouteDao {

	public List<RouteVO> routeList(RouteVO vo);
	
	public int routeListCnt(RouteVO vo);
		
	public int routeInsert(RouteVO vo);
	
	public RouteVO routeDetail(RouteVO vo);
	
	public int hitsUpdate(RouteVO vo);
	
	public int routeUpdate(RouteVO vo);
	
	public int routeDelete(int routeNo);
	
	public int routeGood(RouteVO vo);
	
}
