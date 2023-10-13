package com.disney.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.disney.client.service.TicketService;
import com.disney.common.vo.PageDTO;
import com.disney.vo.TicketVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/*")
@Slf4j
public class AdminTicketController {
	
	@Setter(onMethod_ = @Autowired)
	private TicketService ticketService;
	
	/* 결제내역 */
	
//	@GetMapping("/ticketOrderList")
//	public String ticketOrderList(@ModelAttribute TicketVO tvo, Model model) {
//		log.info("ticketOrderList 호출 성공");
//		
//		//전체 레코드 조회
//		List<TicketVO> ticketOrderList = ticketService.ticketOrderList(tvo);
//		model.addAttribute("ticketOrderList", ticketOrderList);
//		
//		return "admin/ticket/ticketOrderList";
//	}
	
	@GetMapping("/ticketOrderList")
	public String ticketOrderList(@ModelAttribute TicketVO tvo, Model model) {
		log.info("ticketOrderList 호출 성공");
		
		//전체 레코드 조회
		List<TicketVO> ticketOrderList = ticketService.ticketOrderList(tvo);
		model.addAttribute("ticketOrderList", ticketOrderList);
		
		//전체 레코드수 반환
		int total = ticketService.ticketListCnt(tvo);
		//페이징 처리
		model.addAttribute("pageMaker", new PageDTO(tvo, total));
		
		// 총 게시물 수
		model.addAttribute("ticketListCnt", total);
		
		return "admin/ticket/ticketOrderList";
	}
	
	/*
	 * @GetMapping("/ticketListCnt") public int ticketListCnt(@ModelAttribute
	 * TicketVO tvo, Model model) { int total = ticketService.ticketListCnt(tvo);
	 * return total; }
	 */
	
	
	/*
	 * @GetMapping("/cancelTicketList") public String
	 * cancelTicketList(@ModelAttribute TicketVO tvo, Model model) {
	 * log.info("cancelTicketList 호출 성공");
	 * 
	 * List<TicketVO> cancelTicketList = ticketService.cancelTicketList(tvo);
	 * model.addAttribute("cancelTicketList", cancelTicketList);
	 * 
	 * //전체 레코드수 반환 int total = ticketService.ticketListCnt(tvo); //페이징 처리
	 * model.addAttribute("pageMaker", new pageDTO(tvo, total));
	 * 
	 * return "admin/ticket/ticketOrderList";
	 * 
	 * }
	 */
	 
	
	
	@ResponseBody
	@PostMapping(value = "/ticketCancel", produces = "text/plain; charset=UTF-8")
	public String ticketCancel(HttpServletRequest request, @ModelAttribute TicketVO tvo) {
		log.info("ticketCancel 호출 성공");
		
		String value = "";
		int result = ticketService.ticketCancel(tvo);
		int length = tvo.getTicketArr().length;
		
		log.info("result : " + result);
		if(result == length) {
			value = "성공";
		} else {
			value = "실패";
		}
		log.info("value=" + value);
		return value;
	}
	
	
	
}
