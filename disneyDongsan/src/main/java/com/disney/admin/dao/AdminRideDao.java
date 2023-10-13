package com.disney.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.RideVO;

@Mapper
public interface AdminRideDao {
	public List<RideVO> adminRideList(RideVO vo);
	
	public int adminRideListCnt(RideVO vo);
	
	public int adminRideInsert(RideVO vo);
	
	public RideVO adminRideUpdateForm(RideVO vo);
	
	public int adminRideUpdate(RideVO vo);
	
	public int adminRideDelete(int rideNo);
}
