package com.disney.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.OperatingHoursVO;

@Mapper
public interface AdminOperatingHoursDao {
	
	public List<OperatingHoursVO> adminHoursList(String data);
	
	int adminHoursUpdate(OperatingHoursVO list);

}
