package com.disney.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.RouteVO;

@Mapper
public interface AdminRouteDao {

	public List<RouteVO> adminRouteList(RouteVO vo);
	
	public int adminRouteListCnt(RouteVO vo);		
	
	public RouteVO adminRouteDetail(RouteVO vo);
	
	public int adminRouteDelete(int routeNo);
	
	public int adminAllRouteDelete(RouteVO vo);

	public RouteVO adminSearchRouteNo(String routeId);
	

}
