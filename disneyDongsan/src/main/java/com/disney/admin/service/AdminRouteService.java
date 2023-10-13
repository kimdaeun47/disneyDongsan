package com.disney.admin.service;

import java.util.List;

import com.disney.vo.RouteVO;

public interface AdminRouteService {
	
	public List<RouteVO> adminRouteList(RouteVO bvo);//검색 포함 리스트
	
	public int adminRouteListCnt(RouteVO bvo);
	
	
	public RouteVO adminRouteDetail(RouteVO vo);
	
	
	public int adminRouteDelete(RouteVO vo) throws Exception;
	
	//댓글 개수
	public int adminRouteReplyCnt(int routeNo);
	
	//체크 박스
	public int adminAllRouteDelete(RouteVO vo) throws Exception;

	public RouteVO adminSearchRouteNo(String routeId);
	
}
