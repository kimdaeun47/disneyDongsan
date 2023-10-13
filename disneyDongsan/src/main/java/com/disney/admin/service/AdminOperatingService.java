package com.disney.admin.service;

import java.util.List;

import com.disney.vo.OperatingHoursVO;

public interface AdminOperatingService {

	public List<OperatingHoursVO> adminHoursList(String data);
	
	//int adminHoursUpdate(List<OperatingHoursVO> timeList);
	int adminHoursUpdate(List<OperatingHoursVO> timeList);

}
