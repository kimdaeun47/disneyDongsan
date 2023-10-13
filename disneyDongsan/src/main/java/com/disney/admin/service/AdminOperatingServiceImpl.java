package com.disney.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.admin.dao.AdminOperatingHoursDao;
import com.disney.vo.OperatingHoursVO;

import lombok.Setter;

@Service
public class AdminOperatingServiceImpl implements AdminOperatingService {

	
	@Setter(onMethod_ = @Autowired )
	private AdminOperatingHoursDao adminOperatingHoursDao;
	
	@Override
	public List<OperatingHoursVO> adminHoursList(String data){
		List<OperatingHoursVO> list = null;
		list = adminOperatingHoursDao.adminHoursList(data);
		return list;
	}
	
	  public int adminHoursUpdate(List<OperatingHoursVO> timeList){
			int num = 0;
			for(OperatingHoursVO tmp : timeList ){
				num = adminOperatingHoursDao.adminHoursUpdate(tmp);
			}
		        return num;
		    }

}







