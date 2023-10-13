package com.disney.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.disney.client.service.AdminMainService;
import com.disney.vo.MainBenerVO;
import com.disney.vo.MainVO;

import lombok.Setter;


@Controller
public class MainController {

	@Setter(onMethod_ = @Autowired)
	private AdminMainService adminMainService;
	
	@GetMapping()
	public String index(Model model) {
		List<MainVO> mainList = adminMainService.mainList();
		List<MainBenerVO> benerList = adminMainService.benerList();
		model.addAttribute("mainList", mainList);
		model.addAttribute("benerList", benerList);
		
		return "index";
	}
}
