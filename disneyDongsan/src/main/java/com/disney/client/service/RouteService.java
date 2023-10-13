package com.disney.client.service;

import java.util.List;

import com.disney.vo.RouteVO;

public interface RouteService {
	
	//public List<BoardVO> boardList();전체 리스트 조회
	public List<RouteVO> routeList(RouteVO bvo);//검색 포함 리스트
	
	public int routeListCnt(RouteVO bvo);
	
	public int routeInsert(RouteVO vo) throws Exception;
	
	public RouteVO routeDetail(RouteVO vo);
	
	public RouteVO routeUpdateForm(RouteVO vo);
	
	public int routeUpdate(RouteVO vo) throws Exception;
	
	public int routeDelete(RouteVO vo) throws Exception;
	
	//댓글 개수
	public int routeReplyCnt(int routeNo);
	
	//좋아요 수
	public int routeGood(RouteVO vo);
}
