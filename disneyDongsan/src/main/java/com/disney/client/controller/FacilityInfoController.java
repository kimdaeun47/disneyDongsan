package com.disney.client.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.disney.client.service.FacilityInfoService;
import com.disney.common.vo.PageDTO;
import com.disney.vo.OperatingHoursVO;
import com.disney.vo.RestaurantVO;
import com.disney.vo.RideVO;

import lombok.Setter;


@Controller
@RequestMapping("/facilityInfo/*")
public class FacilityInfoController {
	@Setter(onMethod_ = @Autowired)
	private FacilityInfoService facilityInfoService;

	@GetMapping("/waytocome")
	public String directions() {
		return "client/facilityInfo/waytocome";
	}
	
//	@GetMapping("/operatingHours")
//	public String hoursList(Model model) {
//		
//		List<OperatingHoursVO> hoursList = facilityInfoService.hoursList();
//		model.addAttribute("hoursList", hoursList);
//		
//		return "client/facilityInfo/operatingHours";
//	}
	@GetMapping(value = "/operatingHours", produces = MediaType.APPLICATION_JSON_VALUE)
	public String hoursList(Model model) {
		LocalDate now = LocalDate.now();
		int year = now.getYear();
		int monthValue = now.getMonthValue();
		 
		 String  data = year + "-" + monthValue;
		
		List<OperatingHoursVO> hoursList = facilityInfoService.hoursList(data);
		model.addAttribute("hoursList", hoursList);
		
		return "client/facilityInfo/operatingHours";
	}
	@ResponseBody
    @PostMapping(value = "/operatingHours", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<OperatingHoursVO> hoursList(String data) {
		if(data == null) {
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int monthValue = now.getMonthValue();
			data = year + "-" + monthValue;
		}
        List<OperatingHoursVO> hoursList = facilityInfoService.hoursList(data);
        return hoursList;
    }
	

	//페이징 처리 목록 조회
	@GetMapping("/rideList")
	public String rideList(@ModelAttribute RideVO vo, Model model) {
		
		vo.setAmount(9);
		//전체 레코드 조회
		List<RideVO> rideList = facilityInfoService.rideList(vo);
		model.addAttribute("rideList" ,rideList);
		
		//전체 레코드수 반환.
		int total = facilityInfoService.rideListCnt(vo);
		//페이징 처리
		model.addAttribute("pageMaker", new PageDTO(vo, total));
		
		return "client/facilityInfo/rideList";
	}
	
	@GetMapping("/restaurantList")
	public String restaurantList(@ModelAttribute RestaurantVO vo, Model model) {
	
		vo.setAmount(9);
		//전체 레코드 조회
		List<RestaurantVO> restaurantList = facilityInfoService.restaurantList(vo);
		model.addAttribute("restaurantList" ,restaurantList);
		
		//전체 레코드수 반환.
		int total = facilityInfoService.restaurantListCnt(vo);
		//페이징 처리
		model.addAttribute("pageMaker", new PageDTO(vo, total));
		
		return "client/facilityInfo/restaurantList";
	}
	
	
	

	
}
