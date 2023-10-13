package com.disney.client.dao;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.disney.vo.EventVO;

@Mapper
public interface EventDao {
	public List<EventVO> eventList(EventVO vo);
	public int eventListCnt(EventVO vo);
	public int insertForm();
	public int eventInsert(EventVO vo);
	public EventVO eventDetail(EventVO vo);
	public int eventUpdate(EventVO vo);
	public int eventDelete(EventVO vo);
	
	// 달력
	public List<EventVO> getEventsByDate(@Param("selectedDate") String selectedDate);
	
	// 체크박스 삭제
	public int adminAllEventDelete(EventVO vo);
	public EventVO adminSearchEventNo(String eventId);
	

}
