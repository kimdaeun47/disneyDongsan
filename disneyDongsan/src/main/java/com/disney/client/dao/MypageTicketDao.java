package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.TicketVO;

@Mapper
public interface MypageTicketDao {
	
	public List<TicketVO> myTicketList(String username);
	
	public TicketVO myTicketDetail(TicketVO tvo);
	
	public int myTicketDelete(TicketVO tvo);

}
