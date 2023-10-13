
package com.disney.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.admin.dao.AdminRestaurantDao;
import com.disney.common.file.FileUploadUtil;
import com.disney.vo.RestaurantVO;

import lombok.Setter;


@Service
public class AdminRestaurantServiceImpl implements AdminRestaurantService {
	@Setter(onMethod_ = @Autowired )
	private AdminRestaurantDao adminRestaurantDao;
	
	
	@Override
	public List<RestaurantVO> adminRestaurantList(RestaurantVO vo){
		List<RestaurantVO> list = null;
		list = adminRestaurantDao.adminRestaurantList(vo);
	    if (list != null && !list.isEmpty()) {
	        for (RestaurantVO detail : list) {
	            if (detail != null && detail.getRestContent() != null) {
	                detail.setRestContent(detail.getRestContent().toString().replaceAll("\n", "<br />"));
	            }
	        }
	    }
		return list;
	}
	
	@Override
	public int adminRestaurantListCnt(RestaurantVO vo) {
		return  adminRestaurantDao.adminRestaurantListCnt(vo);

	}
	
	//글입력 구현
	@Override
	public int adminRestaurantInsert(RestaurantVO vo) throws Exception {
		int result = 0;
		
		String fileName = FileUploadUtil.fileUpload(vo.getFile(), "facilityInfo");//facilityInfo_128205347977_cat.jpg
		vo.setRestImage(fileName);
		
		result = adminRestaurantDao.adminRestaurantInsert(vo);
		return result;	
	}
	
	//글 상세 구현
	@Override
	public RestaurantVO adminRestaurantUpdateForm(RestaurantVO vo) {
		
		RestaurantVO detail = adminRestaurantDao.adminRestaurantUpdateForm(vo);
		/*
		 * if(detail != null) {
		 * detail.setRestContent(detail.getRestContent().toString().replaceAll("\n",
		 * "<br />")); }
		 */
		return detail;
	}
	
	//글 수정 구현(파일)
	@Override
	public int adminRestaurantUpdate(RestaurantVO vo) throws Exception {
		int result = 0;
		if(!vo.getFile().isEmpty()) {//새롭게 업로드할 파일이 존재한다면
			if(!vo.getRestImage().isEmpty()) {//기좀 파일이 존재하면
				FileUploadUtil.fileDelete(vo.getRestImage());
			}
			String fileName = FileUploadUtil.fileUpload(vo.getFile(), "facilityInfo");//facilityInfo_128205347977_cat.jpg
			vo.setRestImage(fileName);
		}
		
		result = adminRestaurantDao.adminRestaurantUpdate(vo);
		return result;
	}
	
	@Override
	public int adminRestaurantDelete(RestaurantVO vo) throws Exception {
		int result = 0;
		if(!vo.getRestImage().isEmpty()) { //rideImage 필드의 값이 null거나 "" 아니면(이미지 파일이 존재하면)
			FileUploadUtil.fileDelete(vo.getRestImage());
		}
		result = adminRestaurantDao.adminRestaurantDelete(vo.getRestNo());
		return result;
	}

}