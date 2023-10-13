package com.disney.client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.RouteDao;
import com.disney.client.dao.RouteReplyDao;
import com.disney.common.file.FileUploadUtil;
import com.disney.vo.RouteVO;

import lombok.Setter;

@Service
public class RouteServiceImpl implements RouteService {
	@Setter(onMethod_ = @Autowired )
	private RouteDao routeDao;
	
	@Setter(onMethod_ = @Autowired )
	private RouteReplyDao routeReplyDao;
	

	@Override
	public List<RouteVO> routeList(RouteVO vo){
		List<RouteVO> list = null;
		list = routeDao.routeList(vo);
		return list;	
	}
	
	@Override
	public int routeListCnt(RouteVO vo) {
		return  routeDao.routeListCnt(vo);

	}
	
	
	//파일 업로드 추가 소스코드
	/********************************************************************************
	 * 파일 업로드 메서드 
	 * 파일명이 중복시 해결 방법  
	 * System.currentTimeMillis()를 사용하거나 UUID는 128비트의 수이다. 
	 * 표준 형식에서 UUID는 32개의 16진수로 표현되며 총 36개 문자(32개 문자와 4개의 하이픈)로 
	 * 된 8-4-4-4-12라는 5개의 그룹을 하이픈으로 구분한다. 이를테면 다음과 같다. 
	 * 이때 UUID.randomUUID().toString()를 이용해서 얻는다.
	 * 50e8400-e29b-41d4-a716-446655440000
	 ********************************************************************************/
	@Override
	public int routeInsert(RouteVO vo) throws Exception {
		int result = 0;
		if(vo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(vo.getFile(), "route");//board_128205347977_cat.jpg
			vo.setRouteImage(fileName);
		}
		result = routeDao.routeInsert(vo);
		return result;	
	}
	
	//글 상세 구현
	@Override
	public RouteVO routeDetail(RouteVO vo) {
		routeDao.hitsUpdate(vo);
		
		RouteVO detail = routeDao.routeDetail(vo);
		if(detail != null) {
			detail.setRouteContent(detail.getRouteContent().toString().replaceAll("\n", "<br />"));
		}
		return detail;
	}
	
	
	//글 수정 폼 구현
	@Override
	public RouteVO routeUpdateForm(RouteVO vo) {
		RouteVO updateData = routeDao.routeDetail(vo);
		return updateData;
	}
	
	//글 수정 구현(파일)
	@Override
	public int routeUpdate(RouteVO vo) throws Exception {
		int result = 0;
		if(!vo.getFile().isEmpty()) {//새롭게 업로드할 파일이 존재한다면
			if(!vo.getRouteImage().isEmpty()) {//기좀 파일이 존재하면
				FileUploadUtil.fileDelete(vo.getRouteImage());
			}
			String fileName = FileUploadUtil.fileUpload(vo.getFile(), "route");//board_128205347977_cat.jpg
			vo.setRouteImage(fileName);
		}
		
		result = routeDao.routeUpdate(vo);
		return result;
	}
	

	@Override
	public int routeDelete(RouteVO vo) throws Exception {
		int result = 0;
		if(!vo.getRouteImage().isEmpty()) { //b_file 필드의 값이 null거나 "" 아니면(이미지 파일이 존재하면)
			FileUploadUtil.fileDelete(vo.getRouteImage());
		}
		result = routeDao.routeDelete(vo.getRouteNo());
		return result;
	}
	
	@Override
	public int routeReplyCnt(int routeNo) {
		int result = 0;
		result = routeReplyDao.routeReplyCnt(routeNo);
		
		return result;
	}
	
	@Override
	public int routeGood(RouteVO vo) {
		return routeDao.routeGood(vo);


	}
	
}

