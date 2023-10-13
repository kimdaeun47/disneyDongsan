package com.disney.admin.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.disney.admin.service.AdminOperatingService;
import com.disney.vo.OperatingHoursVO;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/*")
@Slf4j
public class AdminOperatingHoursController {

	@Setter(onMethod_ = @Autowired)
	private AdminOperatingService adminOperatingService;
	

	@GetMapping(value = "/operatingHours", produces = MediaType.APPLICATION_JSON_VALUE)
	public String adminHoursList(Model model) {
		log.info("adminHoursList1 호출 성공");
		LocalDate now = LocalDate.now();
		int year = now.getYear();
		int monthValue = now.getMonthValue();
		String  data = year + "-" + monthValue;
		
		List<OperatingHoursVO> hoursList = adminOperatingService.adminHoursList(data);
		model.addAttribute("hoursList", hoursList);
		
		return "admin/facilityInfo/operatingHours";
	}
	@ResponseBody
    @PostMapping(value = "/operatingHours", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<OperatingHoursVO> adminHoursList(String data) {
		log.info("adminHoursList2 호출 성공");
		log.info("data=" + data);
		if(data == null) {
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int monthValue = now.getMonthValue();
			data = year + "-" + monthValue;
		}
        List<OperatingHoursVO> hoursList = adminOperatingService.adminHoursList(data);
        return hoursList;
    }
	
	@GetMapping(value = "/operatingHoursUpdateForm", produces = MediaType.APPLICATION_JSON_VALUE)
	public String adminHoursUpdateForm(Model model) {
		log.info("adminHoursList1 호출 성공");
		LocalDate now = LocalDate.now();
		int year = now.getYear();
		int monthValue = now.getMonthValue();
		String  data = year + "-" + monthValue;
		
		List<OperatingHoursVO> hoursList = adminOperatingService.adminHoursList(data);
		model.addAttribute("hoursList", hoursList);
		
		return "admin/facilityInfo/operatingHoursUpdateForm";
	}
	@ResponseBody
    @PostMapping(value = "/operatingHoursUpdateForm", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<OperatingHoursVO> adminHoursUpdateForm(String data) {
		log.info("adminHoursList2 호출 성공");
		log.info("data=" + data);
		if(data == null) {
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int monthValue = now.getMonthValue();
			data = year + "-" + monthValue;
		}
        List<OperatingHoursVO> hoursList = adminOperatingService.adminHoursList(data);
        return hoursList;
    }
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody  
    @PostMapping("/operatingHoursUpdate")
    public ResponseEntity<String> adminHoursUpdate(@RequestParam Map<String, Object> parameters) {
      log.info("operatingHoursUpdate 호출 성공");
        try {
			String json = parameters.get("timeList").toString();
			ObjectMapper mapper = new ObjectMapper();
			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
			List<OperatingHoursVO> timeList = mapper.readValue(json, new TypeReference<List<OperatingHoursVO>>(){});
	        int updateResult = adminOperatingService.adminHoursUpdate(timeList);
            
            if (updateResult > 0) {
                // 업데이트가 성공했을 경우
            	HashMap<String, String> saveResult = new HashMap<>();
                //saveResult.put("userId", "admin");
                saveResult.put("hoursDate", "hoursTime");
                return new ResponseEntity(saveResult, HttpStatus.OK);
            } else {
                // 업데이트가 실패했을 경우
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("업데이트 실패");
            }
        } catch (Exception e) {
            // 예외 발생 시
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("업데이트 중 오류 발생");
        }
    }
	
	
	

}
