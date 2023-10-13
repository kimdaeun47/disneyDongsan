package com.disney.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.admin.dao.AdminRouteReplyDao;
import com.disney.vo.RouteReplyVO;

import lombok.Setter;

@Service
public class AdminRouteReplyServiceImpl implements AdminRouteReplyService{
	   @Setter(onMethod_=@Autowired)
	   private AdminRouteReplyDao adminRouteReplyDao;
	   
	   //글목록 구현 - 댓글 목록 조회
	   @Override
	   public List<RouteReplyVO> adminReplyList(RouteReplyVO rvo){
	      List<RouteReplyVO> list = null;
	      list = adminRouteReplyDao.adminReplyList(rvo);
	      return list;
	   }
	   //글삭제 구현
	   @Override
	   public int adminReplyDelete(int replyNo) {
	      int result = 0;
	      result = adminRouteReplyDao.adminReplyDelete(replyNo);
	      return result;
	   }
	   
	   //댓글 전체 삭제 구현
	    @Override
	    public int adminReplyChoiceDelete(int routeNo) {
	        return adminRouteReplyDao.adminReplyChoiceDelete(routeNo);
	    }
	    
		@Override
		public int adminAllRouteReplyDelete(RouteReplyVO rvo) throws Exception {
		    int result = 0;
		    result = adminRouteReplyDao.adminAllRouteReplyDelete(rvo);
		    return result;
		}	    

	

}
