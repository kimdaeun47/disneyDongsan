package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.RestaurantVO;


@Mapper
public interface RestaurantDao {
	
	public List<RestaurantVO> restaurantList(RestaurantVO vo);
	
	public int restaurantListCnt(RestaurantVO vo);
}


