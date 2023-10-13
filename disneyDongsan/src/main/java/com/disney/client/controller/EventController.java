package com.disney.client.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.disney.client.service.EventService;
import com.disney.common.vo.PageDTO;
import com.disney.vo.EventVO;

import lombok.Setter;

@Controller
@RequestMapping("/event/*")
public class EventController {
	
	@Setter(onMethod_ = @Autowired)
	private EventService eventService;
	
	@GetMapping("/eventView")
	public String eventView(@ModelAttribute EventVO evo, Model model) {
		List<EventVO> eventList = eventService.eventList(evo);
		model.addAttribute("eventList", eventList);
		
		int total = eventService.eventListCnt(evo);
		
		model.addAttribute("pageMaker", new PageDTO(evo, total));
		
		return "client/event/eventView";
	}
	

	
	@GetMapping("/eventDetail")
	public String eventDetail(@RequestParam("e_no") int e_no, Model model) {
	    EventVO evo = new EventVO();
	    evo.setE_no(e_no);
	    EventVO detail = eventService.eventDetail(evo);
	    model.addAttribute("detail", detail);
	    
	    return "modal/eventDetail";
	}
	
	@GetMapping("/eventCalendar")
	public String eventCalendar() {
		return "client/event/eventCalendar";
	}
	
	
	@GetMapping("/getEvents")
	@ResponseBody
	public List<EventVO> getEvents(@RequestParam String selectedDate) {
	    return eventService.getEventsByDate(selectedDate);
	}


}
