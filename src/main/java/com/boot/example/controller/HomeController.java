package com.boot.example.controller;

//import java.time.LocalDateTime;
//import java.time.format.DateTimeFormatter;
//import java.util.Locale;

import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;



@Controller
public class HomeController {
	
//	@GetMapping("/")
//	public String home(Locale locale, Model model) {
//		LocalDateTime now = LocalDateTime.now();
//		
//		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 (E) a hh시 mm분 ss초");
//		String formattedNow = now.format(formatter);
//		
//		model.addAttribute("serverTime", formattedNow);
//		
//		return "home";
//	}
	@GetMapping("/")
	public String main() {
		return "main";//WEB-INF/views/main.jsp
	}


}
