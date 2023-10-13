package com.disney.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.disney.client.service.NoticeService;
import com.disney.common.file.FileUploadUtil;
import com.disney.common.vo.PageDTO;
import com.disney.vo.NoticeVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/notice")
@Slf4j
public class AdminNoticeController {
	
	@Setter(onMethod_ = @Autowired)
	private NoticeService noticeService;
	 

	@GetMapping("/noticeList")
	public String noticeList(@ModelAttribute NoticeVO nvo, Model model) {
		List<NoticeVO> noticeList = noticeService.noticeList(nvo);
		model.addAttribute("noticeList",noticeList);
		
		int total = noticeService.noticeListCnt(nvo);
		
		model.addAttribute("pageMaker", new PageDTO(nvo, total));
		model.addAttribute("total", total);
		
		// 리스트 번호 부여를 위한 속성
        int count = total - (nvo.getPageNum()-1) * nvo.getAmount();
        model.addAttribute("count", count);
		
		return "admin/notice/noticeList";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam("n_num") int n_num, Model model) {
		NoticeVO nvo = new NoticeVO();
		nvo.setN_num(n_num);;
		NoticeVO detail = noticeService.noticeDetail(nvo);
		model.addAttribute("detail", detail);
		
		return "admin/notice/noticeDetail";
	}
	
	@GetMapping("/noticeInsertForm")
	public String noticeForm(){
		return "admin/notice/noticeInsertForm";
	}
	
	@GetMapping("/noticeUpdateForm")
	public String noticeUpdateForm(@RequestParam("n_num") int nNum, Model model){
		NoticeVO vo = new NoticeVO();
		vo.setN_num(nNum);
		NoticeVO updateData = noticeService.updateForm(vo);
		model.addAttribute("updateData", updateData);
		
		return "admin/notice/noticeUpdateForm";
	}
	
	@PostMapping("/noticeInsert")
	public String noticeInsert(NoticeVO nvo, Model model) throws Exception{
		noticeService.noticeInsert(nvo);
		
		return "redirect:/admin/notice/noticeList";
	}
	
//	@PostMapping("/noticeInsert")
//	public String noticeInsert(@RequestParam("tempFileNames") List<String> tempFileNames, NoticeVO nvo, Model model) throws Exception {
//	    for (String tempFileName : tempFileNames) {
//	        String finalFileName = FileUploadUtil.moveFileFromTempToFinal(tempFileName, "notice");
//
//	        nvo.addImage(finalFileName);
//	    }
//	    noticeService.noticeInsert(nvo);
//
//	    return "redirect:/admin/notice/noticeList";
//	}


	
	@PostMapping("/noticeUpdate")
	public String noticeUpdate(@ModelAttribute NoticeVO vo, RedirectAttributes ras, @RequestParam("n_num") int nNum) throws Exception{
		int result = 0;
		String url = "";
		
		vo.setN_num(nNum);
		result = noticeService.noticeUpdate(vo);
		ras.addFlashAttribute("noticeVO", vo);
		
		if(result == 1) {
			url = "/admin/notice/noticeList";
		} else {
			url = "/admin/event/updateForm?n_num=" + vo.getN_num();
		}
		
		return "redirect:" + url;
	}
	

	
	@PostMapping("/ckeditorUpload&responseType=json")
	@ResponseBody
	public Map<String, Object> ckeditorUpload(@RequestParam("upload") MultipartFile upload) {
	    Map<String, Object> resultMap = new HashMap<>();

	    try {
	        // 파일 업로드 및 임시 파일명
	        String tempFileName = FileUploadUtil.fileUpload(upload, "notice");

	        // CKEditor에 반환할 JSON 응답 생성
	        resultMap.put("uploaded", 1);
	        resultMap.put("fileName", tempFileName);
	        resultMap.put("url", "/dongsanStorage/notice/" + tempFileName);
	    } catch (Exception e) {
	        resultMap.put("uploaded", 0);
	        resultMap.put("error", e.getMessage());
	    }

	    return resultMap;
	}

//	@PostMapping("/confirmUpload")
//	@ResponseBody
//	public Map<String, Object> confirmUpload(@RequestParam("tempFileName") String tempFileName) {
//	    Map<String, Object> resultMap = new HashMap<>();
//
//	    try {
//	        // 임시 폴더에서 이미지를 원하는 폴더로 이동
//	        String finalFileName = FileUploadUtil.moveFileFromTempToFinal(tempFileName, "final");
//
//	        resultMap.put("uploaded", 1);
//	        resultMap.put("fileName", finalFileName);
//	        resultMap.put("url", "/uploadStorage/final/" + finalFileName);
//	    } catch (Exception e) {
//	        resultMap.put("uploaded", 0);
//	        resultMap.put("error", e.getMessage());
//	    }
//
//	    return resultMap;
//	}




	@PostMapping("/noticeDelete")
	public String noticeDelete(@ModelAttribute NoticeVO vo, RedirectAttributes ras) throws Exception{
		int result = 0;
		String url = "";
		
		result = noticeService.noticeDelete(vo);
		
		if(result == 1) {
			url = "/admin/notice/noticeList";
		} else {
			ras.addFlashAttribute("errorMsg", "공지사항 삭제 실패.");
			url = "/admin/notice/noticeDetail?n_num="+vo.getN_num();
		}
		
		return "redirect:"+url;
	}
	
	
	@ResponseBody
    @PostMapping(value = "/allNoticeDelete", produces = "text/plain; charset=UTF-8")
    public String allNoticeDelete(HttpServletRequest request, @ModelAttribute NoticeVO vo) throws Exception {
        String[] checkNumber = request.getParameterValues("checkNumber");
        int valueCnt = checkNumber.length;
        log.info("valueCnt:" + valueCnt);
        vo.setCheckNumber(checkNumber);
        log.info("qvo:" + vo.toString());

        String value = "실패";
        
       
       
        // 게시물 삭제 처리
        int result = noticeService.adminAllNoticeDelete(vo);
        if(result >= 1) {
     	   value="성공";
        } else {
     	   value= "실패";
        }
 
        log.info("value=" + value);
        return value;
    }
	
	
	
	
}
