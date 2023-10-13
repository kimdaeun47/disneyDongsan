package com.disney.admin.dao;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.AdminVO;

@Mapper
public interface AdminLoginDAO {
	public AdminVO adminLogin(AdminVO avo);
}
