package com.disney.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.admin.dao.AdminRideDao;
import com.disney.common.file.FileUploadUtil;
import com.disney.vo.RideVO;

import lombok.Setter;

@Service
public class AdminRideServiceImpl implements AdminRideService {
	@Setter(onMethod_ = @Autowired )
	private AdminRideDao adminRideDao;
	
	
	@Override
	public List<RideVO> adminRideList(RideVO vo){
		List<RideVO> list = null;
		list = adminRideDao.adminRideList(vo);
	    if (list != null && !list.isEmpty()) {
	        for (RideVO detail : list) {
	            if (detail != null && detail.getRideContent() != null) {
	                detail.setRideContent(detail.getRideContent().toString().replaceAll("\n", "<br />"));
	            }
	        }
	    }
		return list;
	}
	
	@Override
	public int adminRideListCnt(RideVO vo) {
		return  adminRideDao.adminRideListCnt(vo);

	}
	
	//글입력 구현
	@Override
	public int adminRideInsert(RideVO vo) throws Exception {
		int result = 0;
		
		String fileName = FileUploadUtil.fileUpload(vo.getFile(), "facilityInfo");//facilityInfo_128205347977_cat.jpg
		vo.setRideImage(fileName);
		
		result = adminRideDao.adminRideInsert(vo);
		return result;	
	}
	
	//글 상세 구현
	@Override
	public RideVO adminRideUpdateForm(RideVO vo) {
		
		RideVO detail = adminRideDao.adminRideUpdateForm(vo);
		/*
		 * if(detail != null) {
		 * detail.setRideContent(detail.getRideContent().toString().replaceAll("\n",
		 * "<br />")); }
		 */
		return detail;
	}
	
	//글 수정 구현(파일)
	@Override
	public int adminRideUpdate(RideVO vo) throws Exception {
		int result = 0;
		if(!vo.getFile().isEmpty()) {//새롭게 업로드할 파일이 존재한다면
			if(!vo.getRideImage().isEmpty()) {//기좀 파일이 존재하면
				FileUploadUtil.fileDelete(vo.getRideImage());
			}
			String fileName = FileUploadUtil.fileUpload(vo.getFile(), "facilityInfo");//facilityInfo_128205347977_cat.jpg
			vo.setRideImage(fileName);
		}
		
		result = adminRideDao.adminRideUpdate(vo);
		return result;
	}
	
	@Override
	public int adminRideDelete(RideVO vo) throws Exception {
		int result = 0;
		if(!vo.getRideImage().isEmpty()) { //rideImage 필드의 값이 null거나 "" 아니면(이미지 파일이 존재하면)
			FileUploadUtil.fileDelete(vo.getRideImage());
		}
		result = adminRideDao.adminRideDelete(vo.getRideNo());
		return result;
	}
}
