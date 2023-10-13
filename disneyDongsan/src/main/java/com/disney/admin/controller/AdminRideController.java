package com.disney.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.disney.admin.service.AdminRideService;
import com.disney.common.vo.PageDTO;
import com.disney.vo.RideVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/*")
@Slf4j
public class AdminRideController {
	@Setter(onMethod_ = @Autowired)
	private AdminRideService adminRideService;


	//페이징 처리 목록 조회
	@GetMapping("/rideList")
	public String adminRideList(@ModelAttribute RideVO vo, Model model) {
		log.info("boardList 메서드 호출");
		
		vo.setAmount(5);
		//전체 레코드 조회
		List<RideVO> rideList = adminRideService.adminRideList(vo);
		model.addAttribute("rideList" ,rideList);
		
		//전체 레코드수 반환.
		int total = adminRideService.adminRideListCnt(vo);
		//페이징 처리
		model.addAttribute("pageMaker", new PageDTO(vo, total));
		
		return "admin/facilityInfo/rideList";
	}
	
	//글쓰기 폼 구현
	@GetMapping("/rideInsertForm")
	public String adminRideInsertForm() {
		log.info("rideInsertForm 호출 성공");
		
		return "admin/facilityInfo/rideInsertForm";
	}
	//글쓰기 구현하기
	@PostMapping("/rideInsert")
	public String adminRideInsert(RideVO vo, Model model) throws Exception {
		log.info("rideInsert 메서드 호출");
		
		int result = 0;
		String url = "";
		
		result = adminRideService.adminRideInsert(vo);
		
		if(result == 0) {
			url = "/admin/rideInsertForm";
		}else {
			url = "/admin/rideList";
		}
		
		return "redirect:" + url;
			
	}
	//글 수정 폼
	@GetMapping(value="/rideUpdateForm")
	public String adminRideUpdateForm(@ModelAttribute RideVO vo, Model model) {
		log.info("rideUpdateForm 호출 성공");
		log.info("rideNo = " +vo.getRideNo());
		
		RideVO updateData = adminRideService.adminRideUpdateForm(vo);
		
		model.addAttribute("updateData", updateData);
		return "admin/facilityInfo/rideUpdateForm";
	}
	
	//글 수정 구현
	@PostMapping("/rideUpdate")
	public String adminRideUpdate(@ModelAttribute RideVO vo)  throws Exception {
		log.info("rideUpdate 호출 성공");
		
		int result=0;
		String url="";
		
		result = adminRideService.adminRideUpdate(vo);
		
		if(result ==1) {
			url="/admin/rideList";
		}else {
			url="/admin/rideUpdateForm?rideNo="+vo.getRideNo();
		}
		return "redirect:" + url;
	}
	//글 삭제
	@PostMapping(value="/rideDelete")
	public String adminRideDelete(@ModelAttribute RideVO vo) throws Exception{
		log.info("rideDelete 호출 성공");
		
		int result= 0;
		
		result = adminRideService.adminRideDelete(vo);
		log.info("result = " +result);
		
		return "redirect:/admin/rideList";
		

	}
}
