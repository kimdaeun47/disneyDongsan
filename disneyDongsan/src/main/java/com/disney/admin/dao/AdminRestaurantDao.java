package com.disney.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.RestaurantVO;

@Mapper
public interface AdminRestaurantDao {
	public List<RestaurantVO> adminRestaurantList(RestaurantVO vo);
	
	public int adminRestaurantListCnt(RestaurantVO vo);
	
	public int adminRestaurantInsert(RestaurantVO vo);
	
	public RestaurantVO adminRestaurantUpdateForm(RestaurantVO vo);
	
	public int adminRestaurantUpdate(RestaurantVO vo);
	
	public int adminRestaurantDelete(int restNo);
}

