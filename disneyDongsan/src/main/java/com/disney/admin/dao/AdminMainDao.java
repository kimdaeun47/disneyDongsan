package com.disney.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.MainBenerVO;
import com.disney.vo.MainVO;

@Mapper
public interface AdminMainDao {
	
	public List<MainVO> mainList();
	
	public List<MainBenerVO> benerList();
	
	public MainVO mainUpdateForm (MainVO mvo);
	
	public int mainUpdate (MainVO mvo) throws Exception;
	
	public MainBenerVO benerupdateForm (MainBenerVO mbo);
	
	public int benerUpdate (MainBenerVO mbo) throws Exception;
	

}
