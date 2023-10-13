package com.disney.client.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.disney.client.service.QuestionService;
import com.disney.vo.QuestionVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/mypage/*")
@Slf4j
public class QuestionController {
	
	@Setter(onMethod_ = @Autowired)
	private QuestionService questionService;
	
	@GetMapping("/userQAList")
	public String qaList(QuestionVO qvo, Model model ) {
		
		log.info("qaList  호출 성공");
		List<QuestionVO> qaList = questionService.qaList(qvo);
		model.addAttribute("qaList", qaList);
		
		return "client/mypage/qa/userQAList";
		
	}
	
	@GetMapping(value = "/userQAWriteForm")
	public String qaWriteForm(QuestionVO qvo) {
		log.info("title"+qvo.getTitle());
		log.info("qaWriteForm 호출 성공");
		return "client/mypage/qa/userQAWriteForm";
	}
	
	@PostMapping("/userQAInsert")
	public String qaInsert(QuestionVO qvo, Model model) {
		log.info("qaInsert 호출성공");
		
		
		int result = 0;
		String url = "";
		log.info("list:" + qvo.toString());
		result = questionService.qaInsert(qvo);
		if(result == 1) {
			url="/mypage/userQAList";
		}else {
			url="/mypage/userQAWriteForm";
		}
		return "redirect:" + url;
		
	}
	
	@GetMapping("/userQADetail")
	public String qaDetail(@ModelAttribute QuestionVO qvo, Model model) {
		log.info("qaDetail() 메서드 호출");
		
		QuestionVO detail = questionService.qaDetail(qvo);
		log.info("detail=" + detail.toString());
		model.addAttribute("detail", detail);
		return "client/mypage/qa/userQADetail";
	}
	
	@PostMapping(value = "/qaDelete")
	public String qaDelete(@ModelAttribute QuestionVO qvo) {
		log.info("qaDelete() 메서드 호출");
		
		int result = 0;
		String url = "";
		
		result = questionService.qaDelete(qvo);
		
		log.info("result=" + result);
		if(result == 1) {
			url = "/mypage/userQAList";
		}else {
			url = "/mypage/userQADetail";
		}
		
		return "redirect:" + url;
	}
	
	

	
	
}
