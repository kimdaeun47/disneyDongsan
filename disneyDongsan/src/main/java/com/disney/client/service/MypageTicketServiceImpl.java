package com.disney.client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.MypageTicketDao;
import com.disney.vo.TicketVO;

import lombok.Setter;

@Service
public class MypageTicketServiceImpl implements MypageTicketService {
	
	@Setter(onMethod_ = @Autowired)
	private MypageTicketDao mypageTicketDao;
	
	@Override
	public List<TicketVO> myTicketList(String username){
		List<TicketVO> list = null;
		list = mypageTicketDao.myTicketList(username);
		return list;
	}
	
	
	@Override
	public TicketVO myTicketDetail(TicketVO tvo) {
		TicketVO detail = mypageTicketDao.myTicketDetail(tvo);
		if(detail != null) {
			detail.setT_category(detail.getT_category().toString().replaceAll("\n", "<br />"));
		} 
		return detail;
	}
	
	@Override
	public int myTicketDelete(TicketVO tvo) {
		int result = 0;
		result = mypageTicketDao.myTicketDelete(tvo);
		return result;
	}
}
