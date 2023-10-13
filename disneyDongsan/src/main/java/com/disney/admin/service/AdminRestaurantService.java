package com.disney.admin.service;

import java.util.List;

import com.disney.vo.RestaurantVO;

public interface AdminRestaurantService {

	public List<RestaurantVO> adminRestaurantList(RestaurantVO vo);
	
	public int adminRestaurantListCnt(RestaurantVO vo);
	
	public int adminRestaurantInsert(RestaurantVO vo) throws Exception;
	
	public RestaurantVO adminRestaurantUpdateForm(RestaurantVO vo);
	
	public int adminRestaurantUpdate(RestaurantVO vo) throws Exception;
	
	public int adminRestaurantDelete(RestaurantVO vo) throws Exception;
}


