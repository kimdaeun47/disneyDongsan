package com.disney.admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.admin.dao.AdminLoginDAO;
import com.disney.vo.AdminVO;

import lombok.Setter;

@Service
public class AdminLoginServiceImpl implements AdminLoginService{

	@Setter(onMethod_ = @Autowired)
	private AdminLoginDAO adminLoginDAO;

	@Override
	public AdminVO adminLogin(AdminVO avo) {
		AdminVO admin = adminLoginDAO.adminLogin(avo); 
		return admin;
	}

}
