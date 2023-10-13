package com.disney.client.service;


import java.util.List;

import com.disney.vo.NoticeVO;

public interface NoticeService {
	public List<NoticeVO> noticeList(NoticeVO vo);
	public int noticeListCnt(NoticeVO vo);
	public NoticeVO noticeDetail(NoticeVO nvo);
	public NoticeVO prevNext(int reviewNum);
	public NoticeVO updateForm(NoticeVO vo);
	public int noticeInsert(NoticeVO vo) throws Exception;
	public int noticeUpdate(NoticeVO vo) throws Exception;
	public int noticeDelete(NoticeVO vo) throws Exception;   

	// 체크박스 삭제
 	public int adminAllNoticeDelete(NoticeVO vo);
 	public NoticeVO adminSearchNoticeNo(String eventId);
}
