package com.disney.client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.TicketDAO;
import com.disney.vo.TicketVO;

import lombok.Setter;

@Service
public class TicketServiceImpl implements TicketService {

	@Setter(onMethod_ = @Autowired)
	private TicketDAO ticketDAO;
	
	@Override
	public List<TicketVO> ticketOrderList(TicketVO tvo) {
		List<TicketVO> list = null;
		list = ticketDAO.ticketOrderList(tvo);
		return list;
	}

	@Override
	public TicketVO visitInfoView(TicketVO tvo) {
		TicketVO detail = null;
		detail = ticketDAO.visitInfoView(tvo);
		return detail;
	}

	@Override
	public int ticketCancel(TicketVO tvo) {
		int result = 0;
		result = ticketDAO.ticketCancel(tvo);
		return result;
	}

	@Override
	public int ticketPayment(TicketVO tvo) {
		int result = 0;
		result = ticketDAO.ticketInsert(tvo);
		return result;
		
	}

	// 전체 레코드수
	@Override
	public int ticketListCnt(TicketVO tvo) {
		return ticketDAO.ticketListCnt(tvo);
	}

	@Override
	public List<TicketVO> cancelTicketList(TicketVO tvo) {
		List<TicketVO> list = null;
		list = ticketDAO.cancelTicketList(tvo);
		return list;
	}




}
