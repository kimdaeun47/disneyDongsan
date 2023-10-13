package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.NoticeVO;

@Mapper
public interface NoticeDao {
	public List<NoticeVO> noticeList(NoticeVO vo);
	public int noticeListCnt(NoticeVO vo);
	public NoticeVO noticeDetail(NoticeVO nvo);
	public NoticeVO prevNext(int reviewNum);
	
	public int noticeInsert(NoticeVO vo);
	public int noticeUpdate(NoticeVO vo);
	public int noticeDelete(NoticeVO vo);

    
    // 체크박스 삭제
 	public int adminAllNoticeDelete(NoticeVO vo);
 	public NoticeVO adminSearchNoticeNo(String eventId);
}
