package com.disney.client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.admin.dao.AdminMainDao;
import com.disney.common.file.FileUploadUtil;
import com.disney.vo.MainBenerVO;
import com.disney.vo.MainVO;

import lombok.Setter;

@Service
public class AdminMainServiceImpl implements AdminMainService{
	
	@Setter(onMethod_ = @Autowired)
	private AdminMainDao mainDao;
	
	@Override
	public List<MainVO> mainList(){
		List<MainVO> list = null;
		list = mainDao.mainList();
		return list;
	}
	
	
	
	@Override
	public MainVO mainUpdateForm(MainVO mvo) {
		MainVO mianUpdateData = null;
		mianUpdateData = mainDao.mainUpdateForm(mvo);
		return mianUpdateData;
	}
	
	@Override
	public int mainUpdate(MainVO mvo) throws Exception {
		int result = 0;
		if(!mvo.getFile().isEmpty()) {
			if(!mvo.getMain_event_image().isEmpty()) {
				FileUploadUtil.fileDelete(mvo.getMain_event_image());
			}
			String fileName = FileUploadUtil.fileUpload(mvo.getFile(), "mainEvent");
			mvo.setMain_event_image(fileName);
		}
		result = mainDao.mainUpdate(mvo);
		return result;
	}
	
	
	
	@Override
	public List<MainBenerVO> benerList(){
		List<MainBenerVO> list = null;
		list = mainDao.benerList();
		return list;
	}
	
	
	/*여기부터 배너입니다.*/
	
	@Override
	public MainBenerVO benerupdateForm(MainBenerVO mbo) {
		MainBenerVO benerUpdateData = null;
		benerUpdateData = mainDao.benerupdateForm(mbo);
		return benerUpdateData;
	}
	
	@Override
	public int benerUpdate(MainBenerVO mbo) throws Exception {
		int result = 0;
		if(!mbo.getFile().isEmpty()) {
			if(!mbo.getMain_event_bener_image().isEmpty()) {
				FileUploadUtil.fileDelete(mbo.getMain_event_bener_image());
			}
			String fileName = FileUploadUtil.fileUpload(mbo.getFile(), "benerEvent");
			mbo.setMain_event_bener_image(fileName);
		}
		result = mainDao.benerUpdate(mbo);
		return result;
	}

}
