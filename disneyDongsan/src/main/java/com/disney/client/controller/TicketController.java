package com.disney.client.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.disney.client.service.CardService;
import com.disney.client.service.TicketService;
import com.disney.vo.CardVO;
import com.disney.vo.MemberVO;
import com.disney.vo.TicketVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/ticket/*")
@Slf4j
public class TicketController {
	
	@Setter(onMethod_ = @Autowired)
	private TicketService ticketService;
	
	@Setter(onMethod_ = @Autowired)
	private CardService cardService;
	
	//방문정보확인
	@PostMapping("/visitInfoView")
	public String visitInfoView(@ModelAttribute TicketVO tvo,@SessionAttribute(name="Member", required = false) MemberVO Member, Model model, RedirectAttributes ras) {
		model.addAttribute("tvo", tvo);
		
		String url = "";
		
		if(Member != null) {
			url = "client/ticket/visitInfoView";
		} else {
			ras.addFlashAttribute("errorMsg","로그인 페이지로 이동합니다");
			url = "redirect:/member/loginForm";
		}
		
		return url;
	}
	
	//종일권
	@GetMapping("/allDayTicketView")
	public String allDayTicketView() {
		return "client/ticket/allDayTicketView";
	}
	
	
	//오후권
	@GetMapping("/afternoonTicketView")
	public String afternoonTicketView() {
		return "client/ticket/afternoonTicketView";
	}
	
	//2/3/4인 패키지
	@GetMapping("/packageTicketView")
	public String packageTicketView() {
		return "client/ticket/packageTicketView";
	}
	
	//카드사 할인율 가져오기
	@ResponseBody
	@GetMapping("/getDiscountRate")
	public int getDiscountRate(CardVO cvo) {
		int discountRate = 0;
		discountRate = cardService.getCardDiscount(cvo);
		
		return discountRate;
	}
	
	/* 약관동의 팝업 */
//	@GetMapping("/agreePop")
//	public void agreePopGET() throws Exception{
//		log.info("authorPopGet....");
//	}
	
	/* 약관동의 모달 */
//	@GetMapping("/agreeModal")
//	public void agreeModalGET() throws Exception{
//		log.info("authorModalGet....");
//	}
	
//	@GetMapping("/agreeModal2")
//	public String agreeModal2() {
//		return "ticket/agreeModal2";
//	}
	
//	@GetMapping("/Success")
//	public String Success() {
//		return "client/ticket/Success";
//	}
	
	@GetMapping("/ticketPaymentSuccess")
	public String Success() {
		return "client/mypage/ticket/userTicketList";
	}
	
	/* 티켓 결제 처리 */
	@PostMapping("/ticketPayment")
	public String ticketPayment(TicketVO tvo, Model model) {
		log.info("ticketPayment 호출 성공");
		
		int result = 0;
		String url = "";
		
		result = ticketService.ticketPayment(tvo);
		
		if(result == 1) {
			url = "/ticket/ticketPaymentSuccess";
		} else {
			url = "/ticket/visitInfoView";
		}
		
		return "redirect:"+url;
	}
	
	// 제휴카드
	@GetMapping("/cardInfo")
	public String cardInfo(@ModelAttribute CardVO cvo, Model model) {
		List<CardVO> cardInfo = cardService.cardInfo(cvo);
		model.addAttribute("cardInfo", cardInfo);
		return "client/ticket/cardInfo";
	}
	
	//예매 이동 페이지
	@GetMapping("/reserveTicket")
	public String reserveTicket() {
		return "client/ticket/reserveTicket";
	}
}
