package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.RideVO;


@Mapper
public interface RideDao {
	
	public List<RideVO> rideList(RideVO vo);
	
	public int rideListCnt(RideVO vo);
	

}
