package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.TicketVO;

@Mapper
public interface TicketDAO {

	public List<TicketVO> ticketOrderList(TicketVO tvo);

	public TicketVO visitInfoView(TicketVO tvo);

	public int ticketCancel(TicketVO tvo);

	public int ticketInsert(TicketVO tvo);

	public int ticketListCnt(TicketVO tvo);

	public List<TicketVO> cancelTicketList(TicketVO tvo);

}
