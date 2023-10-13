package com.disney.admin.service;

import java.util.List;

import com.disney.vo.RideVO;

public interface AdminRideService {

	public List<RideVO> adminRideList(RideVO vo);
	
	public int adminRideListCnt(RideVO vo);
	
	public int adminRideInsert(RideVO vo) throws Exception;
	
	public RideVO adminRideUpdateForm(RideVO vo);
	
	public int adminRideUpdate(RideVO vo) throws Exception;
	
	public int adminRideDelete(RideVO vo) throws Exception;

}
