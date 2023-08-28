package com.boot.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.example.domain.SubjectVO;
import com.boot.example.service.SubjectService;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;



@Controller
@RequestMapping("/subject/*")
@Slf4j
public class SubjectController {
	
	@Setter(onMethod_ = @Autowired)
	private SubjectService subjectService;
	
	@GetMapping("/subjectList")
	public String subjectList(Model model) {
		log.info("subjectList 메서드 호출");
		
		List<SubjectVO> subjectList = subjectService.subjectList();
		model.addAttribute("subjectList", subjectList);
		
		return "subject/subjectList";
	}
	
	//subjectNumber 메서드 호출(자동 학과번호 얻기)
	//@return
	@GetMapping("/subjectNumber")
	@ResponseBody
	public String subjectNumber() {
		log.info("subjectNumber 메서드로 자동 학과번호 얻기");
		
		String number = subjectService.subjectNumber();
		
		return number;
	}
	
	//subjectInsert 메서드 호출
	//@param svo
	//@return
	@PostMapping("/subjectInsert")
	public String subjectInsert(SubjectVO svo) {
		log.info("subjectInsert 메서드 호출");
		
		subjectService.subjectInsert(svo);
		return "redirect:/subject/subjectList";
	}
	
	@PostMapping("/subjectUpdate")
	public String subjectUpdate(SubjectVO svo) {
		log.info("subjectUpdate 메서드 호출");
		
		subjectService.subjectUpdate(svo);
		return "redirect:/subject/subjectList";
	}
	
	@PostMapping("/subjectDelete")
	public String subjectDelete(SubjectVO svo) {
		log.info("subjectDelete 메서드 호출");
		
		subjectService.subjectDelete(svo);
		return "redirect:/subject/subjectList";
	}
	
	
	@PostMapping(value="/deleteCheck", produces="text/plain; charset=UTF-8" )
	@ResponseBody
	public String deleteCheck(SubjectVO svo) {
		String result = subjectService.deleteCheck(svo);
		
		return result;
	}

}
