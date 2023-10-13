package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.OperatingHoursVO;


@Mapper
public interface OperatingHoursDao {
	
	public List<OperatingHoursVO> hoursList(String data);

}
