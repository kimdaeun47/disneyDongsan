package com.disney.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.disney.client.service.AdminMainService;
import com.disney.vo.MainBenerVO;
import com.disney.vo.MainVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/*")
public class AdminMainController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminMainService adminMainService;
	
	@GetMapping("/mainList")
	public String mainList(Model model) {
		
		log.info("answerList 호출 성공");
		List<MainVO> mainList = adminMainService.mainList();
		List<MainBenerVO> benerList = adminMainService.benerList();
		model.addAttribute("mainList", mainList);
		model.addAttribute("benerList", benerList);
		
		return "admin/main/mainList";
	}
	
	@PostMapping("/mainEventUpdateForm")
	public String mainEventUpdateForm( @ModelAttribute MainVO mvo, Model model) {
		log.info("mainEventUpdateForm 호출 성공");
		MainVO mainData = adminMainService.mainUpdateForm(mvo);
		model.addAttribute("mainData", mainData);
		return "admin/main/mainEventUpdateForm";
		
	}
	
	@PostMapping("/mainEventUpdate")
	public String mainEventUpdate( @ModelAttribute MainVO mvo) throws Exception {
		log.info("mainEventUpdate 호출 성공");
		int result = 0;
		String url ="";
		
		result = adminMainService.mainUpdate(mvo);
		if(result == 1) {
			url="/admin/mainList";
		}else {
			url="/admin/mainEventUpdateForm";
		}
		return "redirect:" + url;
		
	}
	
	
	/*여기부터 배너입니다.*/
	
	@PostMapping("/benerupdateForm")
	public String benerupdateForm( @ModelAttribute MainBenerVO mbo, Model model) {
		log.info("benerupdateForm 호출 성공");
		MainBenerVO benerData = adminMainService.benerupdateForm(mbo);
		model.addAttribute("benerData", benerData);
		return "admin/main/benerupdateForm";
	}
	
	@PostMapping("/benerEventUpdate")
	public String benerEventUpdate( @ModelAttribute MainBenerVO mbo, RedirectAttributes ras) throws Exception {
		log.info("mainEventUpdate 호출 성공");
		int result = 0;
		String url ="";
		
		result = adminMainService.benerUpdate(mbo);
		if(result == 1) {
			url="/admin/mainList";
		}else {
			ras.addFlashAttribute("errorMsg", "배너 수정 실패");
			url="/admin/benerupdateForm";
		}
		return "redirect:" + url;
		
	}

}
