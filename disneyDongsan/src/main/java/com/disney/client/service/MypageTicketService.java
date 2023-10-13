package com.disney.client.service;

import java.util.List;

import com.disney.vo.TicketVO;

public interface MypageTicketService {
	
	public List<TicketVO> myTicketList(String username);
	
	public TicketVO myTicketDetail(TicketVO tvo);
	
	public int myTicketDelete(TicketVO tvo);
}
