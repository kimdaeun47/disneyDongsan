package com.disney.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.admin.dao.AdminRouteDao;
import com.disney.admin.dao.AdminRouteReplyDao;
import com.disney.common.file.FileUploadUtil;
import com.disney.vo.RouteVO;

import lombok.Setter;

@Service
public class AdminRouteServiceImpl implements AdminRouteService {
	@Setter(onMethod_ = @Autowired )
	private AdminRouteDao adminRouteDao;
	
	@Setter(onMethod_ = @Autowired )
	private AdminRouteReplyDao adminRouteReplyDao;
	

	@Override
	public List<RouteVO> adminRouteList(RouteVO vo){
		List<RouteVO> list = null;
		list = adminRouteDao.adminRouteList(vo);
		return list;	
	}
	
	@Override
	public int adminRouteListCnt(RouteVO vo) {
		return  adminRouteDao.adminRouteListCnt(vo);

	}
	
	//글 상세 구현
	@Override
	public RouteVO adminRouteDetail(RouteVO vo) {

		RouteVO detail = adminRouteDao.adminRouteDetail(vo);
		if(detail != null) {
			detail.setRouteContent(detail.getRouteContent().toString().replaceAll("\n", "<br />"));
		}
		return detail;
	}
	

	@Override
	public int adminRouteDelete(RouteVO vo) throws Exception {
		int result = 0;
		if(!vo.getRouteImage().isEmpty()) { //b_file 필드의 값이 null거나 "" 아니면(이미지 파일이 존재하면)
			FileUploadUtil.fileDelete(vo.getRouteImage());
		}
		result = adminRouteDao.adminRouteDelete(vo.getRouteNo());
		return result;
	}
	//체크박스
	   @Override
	   public int adminAllRouteDelete(RouteVO vo) throws Exception {
	       int result = 0;
	       result = adminRouteDao.adminAllRouteDelete(vo);
	       return result;
	   }
	
		//댓글 개수
		@Override
		public int adminRouteReplyCnt(int routeNo) {
			int result = 0;
			result = adminRouteReplyDao.adminRouteReplyCnt(routeNo);
			
			return result;
		}
		
		//그림파일 삭제를 위한 아이디 셀렉
	    @Override
	    public RouteVO adminSearchRouteNo(String routeId){
	        return adminRouteDao.adminSearchRouteNo(routeId);
	    }
}

