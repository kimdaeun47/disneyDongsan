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

import com.disney.admin.service.AdminAnswerService;
import com.disney.common.vo.PageDTO;
import com.disney.vo.QuestionVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/*")
@Slf4j
public class AdminAnswerController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminAnswerService answerService;
	
	@GetMapping("/answerList")
	public String answerList(@ModelAttribute QuestionVO qvo, Model model) {
		log.info("answerList 호출 성공");
		List<QuestionVO> anList = answerService.anList(qvo);
		model.addAttribute("anList", anList);
		
		int total = answerService.answerListCnt(qvo);
		
		model.addAttribute("pageMaker",new PageDTO(qvo, total));
		
		return "admin/answer/answerList";
	}
	

	
	
	
	@GetMapping(value = "/answerUpdateForm")
	public String anUpdateForm(@ModelAttribute QuestionVO qvo, Model model) {
		log.info("anUpdateForm() 메소드 호출성공");
		
		QuestionVO updateData = answerService.anUpdateForm(qvo);
		model.addAttribute("updateData",updateData);
		return "admin/answer/answerUpdate";
	}
	
	@PostMapping("/answerUpdate")
	public String answerUpdate(@ModelAttribute QuestionVO qvo) {
		log.info("answerUpdate 메소드 호출 성공");
		
		int result = 0;
		String url = "";
		log.info("qvo=" + qvo);
		result = answerService.anUpdate(qvo);
		
		log.info("result=" + result);
		if( result == 1) {
			url = "/admin/answerList";
		}else {
			url = "/admin/answerUpdateForm";
		}
		return "redirect:" + url;
		
	}
	
	
	/*HttpServletRequest를 사용하면, 값을 받아올 수가 있는데 
	  만약 회원 정보를 컨트롤러로 보냈을 때 HttpServletRequest 객체 안에 모든 데이터들이 들어가게 된다.*/
	@ResponseBody
	@PostMapping(value = "/answerDelete", produces = "text/plain; charset=UTF-8")
	public String answerDelete(HttpServletRequest request, @ModelAttribute QuestionVO qvo) {
		String value = "";
		String[] valueArr = request.getParameterValues("valueArr");
		int valueCnt = valueArr.length;
		log.info("valueCnt:" + valueCnt);
		qvo.setValueArr(valueArr);
		log.info("qvo:" + qvo.toString());
		int result = answerService.anDelete(qvo);
		log.info("result:" + result);
		if(result == valueCnt) {
			value = "성공";
			
		}else {
			value = "실패";
		}
		log.info("value="+ value);
		return value;
		
	}
	
	

}
