package com.disney.client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.RouteReplyDao;
import com.disney.vo.RouteReplyVO;

import lombok.Setter;

@Service
public class RouteReplyServiceImpl implements RouteReplyService{
	   @Setter(onMethod_=@Autowired)
	   private RouteReplyDao routeReplyDao;
	   
	   //글목록 구현 - 댓글 목록 조회
	   @Override
	   public List<RouteReplyVO> replyList(RouteReplyVO rvo){
	      List<RouteReplyVO> list = null;
	      list = routeReplyDao.replyList(rvo);
	      return list;
	   }
	   //글입력 구현
	   @Override
	   public int replyInsert(RouteReplyVO rvo) {
	      int result = 0;
	      result = routeReplyDao.replyInsert(rvo);
	      return result;
	   }
	   
	   //비밀번호
	   @Override
	   public int pwdConfirm(RouteReplyVO rvo) {
	      int result = 0;
	      result = routeReplyDao.pwdConfirm(rvo);
	      return result;
	   }
	   
	   //글수정 구현
	   @Override
	   public int replyUpdate(RouteReplyVO rvo) {
	      int result = 0;
	      result = routeReplyDao.replyUpdate(rvo);
	      return result;
	   }
	   
	   //글삭제 구현
	   @Override
	   public int replyDelete(int replyNo) {
	      int result = 0;
	      result = routeReplyDao.replyDelete(replyNo);
	      return result;
	   }
	   
	   //댓글 전체 삭제 구현
	    @Override
	    public int replyChoiceDelete(int routeNo) {
	        return routeReplyDao.replyChoiceDelete(routeNo);
	    }

	

}
