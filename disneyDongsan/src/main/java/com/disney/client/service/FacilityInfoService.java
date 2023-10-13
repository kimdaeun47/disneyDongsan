package com.disney.client.service;

import java.util.List;

import com.disney.vo.OperatingHoursVO;
import com.disney.vo.RestaurantVO;
import com.disney.vo.RideVO;

public interface FacilityInfoService {

	public List<RideVO> rideList(RideVO vo);
	
	public int rideListCnt(RideVO vo);
	
	public List<RestaurantVO> restaurantList(RestaurantVO vo);
	
	public int restaurantListCnt(RestaurantVO vo);
	
	public List<OperatingHoursVO> hoursList(String data);
	

}
