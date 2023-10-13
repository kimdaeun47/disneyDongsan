package com.disney.client.service;

import java.util.List;

import com.disney.vo.TicketVO;

public interface TicketService {
	public List<TicketVO> ticketOrderList(TicketVO tvo);

	public TicketVO visitInfoView(TicketVO tvo);
	public int ticketCancel(TicketVO tvo);
	public int ticketPayment(TicketVO tvo);

	public int ticketListCnt(TicketVO tvo);
	
	public List<TicketVO> cancelTicketList(TicketVO tvo);
	
}
