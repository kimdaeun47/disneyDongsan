package com.disney.admin.controller;


import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.disney.client.service.EventService;
import com.disney.common.file.FileUploadUtil;
import com.disney.common.vo.PageDTO;
import com.disney.vo.EventVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/event/*")
@Slf4j
public class AdminEventController {
	
	@Setter(onMethod_ = @Autowired)
	private EventService eventService;
	
	 
	
	@GetMapping("/eventList")
	public String eventView(@ModelAttribute EventVO evo, Model model) {
		List<EventVO> eventList = eventService.eventList(evo);
		model.addAttribute("eventList", eventList);
		
		int total = eventService.eventListCnt(evo);
		
		model.addAttribute("pageMaker", new PageDTO(evo, total));
		model.addAttribute("total", total);
		
        // 리스트 번호 부여를 위한 속성
        int count = total - (evo.getPageNum()-1) * evo.getAmount();
        model.addAttribute("count", count);
		
		return "admin/event/eventList";
	}
	
	@GetMapping("/insertForm")
	public String insertForm() {
		return "admin/event/insertForm";
	}
	
	@PostMapping("/eventInsert")
	public String eventInsert(EventVO evo) throws Exception {
		eventService.eventInsert(evo);
		
		return "redirect:/admin/event/eventList";
	}
	
	@GetMapping("/eventDetail")
	public String eventDetail(@RequestParam("e_no") int e_no, Model model) {
	    EventVO evo = new EventVO();
	    evo.setE_no(e_no);
	    EventVO detail = eventService.eventDetail(evo);
	    
	    model.addAttribute("detail", detail);
	    
	    return "admin/event/eventDetail";
	}
	
	// 수정 폼 화면 처리
	@GetMapping("/updateForm")
	public String updateForm(@RequestParam("e_no") int eNo, Model model) {
	    EventVO vo = new EventVO();
	    vo.setE_no(eNo);
	    EventVO updateData = eventService.updateForm(vo);
	    model.addAttribute("updateData", updateData);
	    return "admin/event/updateForm";
	}

	
//	@PostMapping("/updateForm")
//	public String processUpdateForm(@ModelAttribute EventVO vo, Model model) {
//		EventVO updateData = eventService.updateForm(vo);
//		model.addAttribute("updateData",updateData);
//		
//		return "admin/event/updateForm";
//		
//		
////	    int result = eventService.eventUpdate(vo);
////	    ras.addFlashAttribute("eventVO", vo);
////
////	    String url = (result == 1) ? "/admin/event/eventList" : "/admin/event/updateForm";
////
////	    return "redirect:" + url;
//	}
	
	@PostMapping("/updateForm")
	public String processUpdateForm(@ModelAttribute EventVO vo, RedirectAttributes ras, Model model) throws Exception {
	    int result = eventService.eventUpdate(vo);
	    ras.addFlashAttribute("eventVO", vo);

	    String url = (result == 1) ? "/admin/event/eventList" : "/admin/event/updateForm?e_no=" + vo.getE_no();

	    return "redirect:" + url;
	}
	
	// 이벤트 수정 처리
	@PostMapping("/eventUpdate")
	public String eventUpdate(@ModelAttribute EventVO vo, RedirectAttributes ras, @RequestParam("e_no") int eNo) throws Exception{
		int result = 0;
		String url = "";
		
		vo.setE_no(eNo);
		result = eventService.eventUpdate(vo);
		ras.addFlashAttribute("eventVO", vo);
		
		if(result == 1) {
			url = "/admin/event/eventList";
		} else {
			url = "/admin/event/updateForm?e_no=" + vo.getE_no();
		}
		
		return "redirect:"+url;
	}
	
	
	
	
	// 이벤트 삭제
	@PostMapping("/eventDelete")
	public String boardDelete(@ModelAttribute EventVO vo, RedirectAttributes ras, Model model) throws Exception{
		int result = 0;
		String url = "";
		
		result = eventService.eventDelete(vo);
		
		if(result == 1) {
			url = "/admin/event/eventList";
		} else {
			ras.addFlashAttribute("errorMsg", "이벤트 삭제 실패.");
			url = "/admin/event/eventDetail?e_no" + vo.getE_no();
		}
		
		return "redirect:"+url;
	}
	
	
	// 삭제
    @ResponseBody
    @PostMapping(value = "/allEventDelete", produces = "text/plain; charset=UTF-8")
    public String allEventDelete(HttpServletRequest request, @ModelAttribute EventVO vo) throws Exception {
        String[] checkNumber = request.getParameterValues("checkNumber");
        int valueCnt = checkNumber.length;
        log.info("valueCnt:" + valueCnt);
        vo.setCheckNumber(checkNumber);
        log.info("qvo:" + vo.toString());

        String value = "실패";

        // 체크된 게시물을 삭제하기 전에 해당 게시물의 이미지를 먼저 삭제
        for (String eventId : checkNumber) {
            // 이미지 삭제를 위해 해당 게시물 정보를 가져옴
            EventVO event = eventService.adminSearchEventNo(eventId);
           
            if (event != null) {
                if (event.getE_thum() != null && !event.getE_thum().isEmpty()) {
                    try {
                        FileUploadUtil.fileDelete(event.getE_thum());
                    } catch (IOException e) {
                        log.error("이미지 파일 삭제 오류: " + e.getMessage());
                    }
                }
                if (event.getE_img1() != null && !event.getE_img1().isEmpty()) {
                    try {
                        FileUploadUtil.fileDelete(event.getE_img1());
                    } catch (IOException e) {
                        log.error("이미지 파일 삭제 오류: " + e.getMessage());
                    }
                }
                if (event.getE_img2() != null && !event.getE_img2().isEmpty()) {
                    try {
                        FileUploadUtil.fileDelete(event.getE_img2());
                    } catch (IOException e) {
                        log.error("이미지 파일 삭제 오류: " + e.getMessage());
                    }
                }
            }
        }
       
        // 게시물 삭제 처리
        int result = eventService.adminAllEventDelete(vo);
        if(result >= 1) {
     	    value="성공";
        } else {
      	    value= "실패";
        }

        log.info("value=" + value);
        return value;
    }



}
