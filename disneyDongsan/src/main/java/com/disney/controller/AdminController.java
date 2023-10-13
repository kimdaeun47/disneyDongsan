package com.disney.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.disney.admin.service.AdminAnswerService;
import com.disney.admin.service.AdminGoodsService;
import com.disney.admin.service.AdminLoginService;
import com.disney.client.service.TicketService;
import com.disney.vo.AdminVO;
import com.disney.vo.OrderPayVO;
import com.disney.vo.QuestionVO;
import com.disney.vo.TicketVO;

import lombok.Setter;

@Controller
@SessionAttributes("Admin")
public class AdminController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminLoginService adminLoginService;
	
	@Setter(onMethod_ = @Autowired)
	private AdminGoodsService ags;
	@Setter(onMethod_ = @Autowired)
	private TicketService ts;
	@Setter(onMethod_ = @Autowired)
	private AdminAnswerService aas;
	
	
	
	
	@GetMapping("/admin")
	public String adminLoginForm() {
		return "admin/login/adminLogin";
	}
	
	
	
	@PostMapping("/admin/adminLogin")
	public String adminLogin(AdminVO avo, Model model, RedirectAttributes ras) {
		String url = "";
		
		AdminVO admin = adminLoginService.adminLogin(avo);
		
		if(admin != null) {
			model.addAttribute("Admin", admin);
			url = "admin/adminPage";
		} else {
			ras.addFlashAttribute("errorMsg", "관리자 로그인 실패");
			url = "admin";
		}
		
		return "redirect:/" + url;
	}
	
	@SuppressWarnings("unlikely-arg-type")
	@GetMapping("/admin/adminPage")
	public String adminPage(@SessionAttribute(name = "Admin", required = false) AdminVO Admin, RedirectAttributes ras, Model model, TicketVO tvo, QuestionVO qvo) throws Exception {
		String url = "";
		
		if(Admin != null) {
			url = "admin/adminPage";
		} else {
			ras.addFlashAttribute("errorMsg", "관리자 권한이 필요합니다.");
			url = "redirect:/admin";
		}
		//배송안한 주문
		List<OrderPayVO> orderList = ags.orderList();
		model.addAttribute("orderList", orderList);
		
		int count_order = 0;
        for (OrderPayVO item : orderList) {
            if ("배송준비".equals(item.getG_order_state())) { // "getAskyn" 값이 "n"인 항목만 카운트
            	count_order++;
            }
        }

        model.addAttribute("noneDelivery", count_order);
		
		//오늘 티켓정보
		List<TicketVO> ticketOrderList = ts.ticketOrderList(tvo);
		model.addAttribute("ticketOrderList", ticketOrderList);
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDate = sdf.format(today);
		
		System.out.print(formattedDate);
		
		System.out.print(ticketOrderList);
		
		int count = 0;
        for (TicketVO item_1 : ticketOrderList) {
            if (formattedDate.equals(item_1.getVisit_date())) { 
                count++;
            }
        }

        model.addAttribute("ticketListCnt", count);

		
		//답변안한 문의
		if (qvo.getAskyn().equals("n")) {
			
		}

		List<QuestionVO> anList = aas.anList(qvo);
		model.addAttribute("anList", anList);
		
		
		int count_1 = 0;
        for (QuestionVO item : anList) {
            if ("n".equals(item.getAskyn())) { // "getAskyn" 값이 "n"인 항목만 카운트
            	count_1++;
            }
        }

        model.addAttribute("answerListCnt", count_1);
		
		
		
		
		return url;
	}
}
