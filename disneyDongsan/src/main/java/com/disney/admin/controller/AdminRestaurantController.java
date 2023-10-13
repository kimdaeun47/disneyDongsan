package com.disney.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.disney.admin.service.AdminRestaurantService;
import com.disney.common.vo.PageDTO;
import com.disney.vo.RestaurantVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/*")
@Slf4j
public class AdminRestaurantController {
	@Setter(onMethod_ = @Autowired)
	private AdminRestaurantService adminRestaurantService;

	//페이징 처리 목록 조회
	@GetMapping("/restaurantList")
	public String adminRestaurantList(@ModelAttribute RestaurantVO vo, Model model) {
		log.info("restaurantList 메서드 호출");
		
		vo.setAmount(5);
		//전체 레코드 조회
		List<RestaurantVO> restaurantList = adminRestaurantService.adminRestaurantList(vo);
		model.addAttribute("restaurantList" ,restaurantList);
		
		//전체 레코드수 반환.
		int total = adminRestaurantService.adminRestaurantListCnt(vo);
		//페이징 처리
		model.addAttribute("pageMaker", new PageDTO(vo, total));
		
		return "admin/facilityInfo/restaurantList";
	}
	
	//글쓰기 폼 구현
	@GetMapping("/restaurantInsertForm")
	public String adminRestaurantInsertForm() {
		log.info("restaurantInsertForm 호출 성공");
		
		return "admin/facilityInfo/restaurantInsertForm";
	}
	//글쓰기 구현하기
	@PostMapping("/restaurantInsert")
	public String adminRestaurantInsert(RestaurantVO vo, Model model) throws Exception {
		log.info("restaurantInsert 메서드 호출");
		
		int result = 0;
		String url = "";
		
		result = adminRestaurantService.adminRestaurantInsert(vo);
		
		if(result == 0) {
			url = "/admin/restaurantInsertForm";
		}else {
			url = "/admin/restaurantList";
		}
		
		return "redirect:" + url;
			
	}
	//글 수정 폼
	@GetMapping(value="/restaurantUpdateForm")
	public String adminRestaurantUpdateForm(@ModelAttribute RestaurantVO vo, Model model) {
		log.info("restaurantUpdateForm 호출 성공");
		log.info("restNo = " +vo.getRestNo());
		
		RestaurantVO updateData = adminRestaurantService.adminRestaurantUpdateForm(vo);
		
		model.addAttribute("updateData", updateData);
		return "admin/facilityInfo/restaurantUpdateForm";
	}
	
	//글 수정 구현
	@PostMapping("/restaurantUpdate")
	public String adminRestaurantUpdate(@ModelAttribute RestaurantVO vo)  throws Exception {
		log.info("restaurantUpdate 호출 성공");
		
		int result=0;
		String url="";
		
		result = adminRestaurantService.adminRestaurantUpdate(vo);
		
		if(result ==1) {
			url="/admin/restaurantList";
		}else {
			url="/admin/restaurantUpdateForm?restNo="+vo.getRestNo();
		}
		return "redirect:" + url;
	}
	//글 삭제
	@PostMapping(value="/restaurantDelete")
	public String adminRestaurantDelete(@ModelAttribute RestaurantVO vo) throws Exception{
		log.info("restaurantDelete 호출 성공");
		
		int result= 0;
		
		result = adminRestaurantService.adminRestaurantDelete(vo);
		log.info("result = " +result);
		
		return "redirect:/admin/restaurantList";
		

	}
}
