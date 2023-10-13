package com.disney.client.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.disney.vo.EventVO;

public interface EventService {
	public List<EventVO> eventList(EventVO vo);
	public int eventListCnt(EventVO vo);
	//public int eventInsert(EventVO vo) throws Exception;
	public int eventInsert(EventVO vo) throws Exception;
	public EventVO eventDetail(EventVO vo);
	public int eventUpdate(EventVO vo) throws Exception;
	public EventVO updateForm(EventVO vo);
	public int eventDelete(EventVO vo) throws Exception;	
	
	// 달력
	public List<EventVO> getEventsByDate(@Param("selectedDate") String selectedDate);

	// 체크 삭제
	public int adminAllEventDelete(EventVO vo) throws Exception;
	public EventVO adminSearchEventNo(String eventId);

}
