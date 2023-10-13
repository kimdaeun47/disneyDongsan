package com.disney.client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.OperatingHoursDao;
import com.disney.client.dao.RestaurantDao;
import com.disney.client.dao.RideDao;
import com.disney.vo.OperatingHoursVO;
import com.disney.vo.RestaurantVO;
import com.disney.vo.RideVO;

import lombok.Setter;

@Service
public class FacilityInfoServiceImpl implements FacilityInfoService {
	@Setter(onMethod_ = @Autowired )
	private RideDao rideDao;
	
	@Setter(onMethod_ = @Autowired )
	private RestaurantDao restaurantDao;
	
	@Setter(onMethod_ = @Autowired )
	private OperatingHoursDao operatingHoursDao;
	
	
	@Override
	public List<RideVO> rideList(RideVO vo){
		List<RideVO> list = null;
		list = rideDao.rideList(vo);
	    if (list != null && !list.isEmpty()) {
	        for (RideVO detail : list) {
	            if (detail != null && detail.getRideContent() != null) {
	                detail.setRideContent(detail.getRideContent().toString().replaceAll("\n", "<br />"));
	            }
	        }
	    }
		return list;
	}
	
	@Override
	public int rideListCnt(RideVO vo) {
		return  rideDao.rideListCnt(vo);
	}
	
	
	@Override
	public List<RestaurantVO> restaurantList(RestaurantVO vo){
		List<RestaurantVO> list = null;
		list = restaurantDao.restaurantList(vo);
	    if (list != null && !list.isEmpty()) {
	        for (RestaurantVO detail : list) {
	            if (detail != null && detail.getRestContent() != null) {
	                detail.setRestContent(detail.getRestContent().toString().replaceAll("\n", "<br />"));
	            }
	        }
	    }
		return list;
	}
	
	@Override
	public int restaurantListCnt(RestaurantVO vo) {
		return  restaurantDao.restaurantListCnt(vo);
	}
	
	public List<OperatingHoursVO> hoursList(String data){
		List<OperatingHoursVO> list = null;
		list = operatingHoursDao.hoursList(data);
		return list;
	}

}







