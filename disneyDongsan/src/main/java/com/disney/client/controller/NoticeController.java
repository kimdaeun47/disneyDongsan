package com.disney.client.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.disney.client.service.NoticeService;
import com.disney.common.vo.PageDTO;
import com.disney.vo.NoticeVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/notice/*")
@Slf4j
public class NoticeController {
	@Setter(onMethod_ = @Autowired)
	private NoticeService noticeService;
	
	// noticeView 리스트 출력
	@GetMapping("/noticeView")
	public String notice(@ModelAttribute NoticeVO nvo, Model model) {
		log.info("notice 호출 성공");
		
		// 전체 레코드 조회
		List<NoticeVO> noticeList = noticeService.noticeList(nvo);
		model.addAttribute("noticeList",noticeList);
		
		// 전체 레코드 수 반환
		int total = noticeService.noticeListCnt(nvo);
		// 페이징 처리
		model.addAttribute("pageMaker", new PageDTO(nvo, total));
		model.addAttribute("total", total);
		
		// 리스트 번호 부여를 위한 속성
        int count = total - (nvo.getPageNum()-1) * nvo.getAmount();
        model.addAttribute("count", count);
		
		return "client/notice/noticeView";
	}
	
	// 상세 정보 출력
	@GetMapping("/noticeDetail")
	public String noticeDetail(NoticeVO nvo, Model model) {
		NoticeVO detail = noticeService.noticeDetail(nvo);
		model.addAttribute("detail",detail);
		model.addAttribute("prevNext", noticeService.prevNext(nvo.getN_num()));
		return "client/notice/noticeDetail";
	}
	
	
	
	
}
