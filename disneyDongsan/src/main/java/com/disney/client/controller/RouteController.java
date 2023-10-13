package com.disney.client.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.disney.client.service.RouteService;
import com.disney.common.file.FileUploadUtil;
import com.disney.common.vo.PageDTO;
import com.disney.vo.MemberVO;
import com.disney.vo.RouteReplyVO;
import com.disney.vo.RouteVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/route/*")
@Slf4j
public class RouteController {
	@Setter(onMethod_ = @Autowired)
	private RouteService routeService;
	

	//페이징 처리 목록 조회
	@GetMapping("/routeList")
	public String routeList(@ModelAttribute RouteVO vo, Model model) {
		log.info("routeList 메서드 호출");
		//bvo.setAmount(5);
		//전체 레코드 조회
		List<RouteVO> routeList = routeService.routeList(vo);
		model.addAttribute("routeList" ,routeList);
		
		//전체 레코드수 반환.
		int total = routeService.routeListCnt(vo);

		//페이징 처리
		model.addAttribute("pageMaker", new PageDTO(vo, total));
		
		// 리스트 번호 부여를 위한 속성
		int count = total - (vo.getPageNum()-1) * vo.getAmount();
		model.addAttribute("count", count);
		
		return "client/route/routeList";
	}
	//좋아요 수 구현
	@GetMapping("/routeGoodcntUpdate")
	@ResponseBody
	public int routeGood(RouteVO vo) {
	    log.info("routeGood 메서드 호출");
	    int updatedGoodCount = routeService.routeGood(vo);
	    return updatedGoodCount;
	}
	
	//글쓰기 폼 구현
	@GetMapping("/routeInsertForm")
	public String routeInsertForm(@SessionAttribute(name="Member", required = false) MemberVO Member, RouteVO vo, Model model, RedirectAttributes ras) {
		log.info("routeInsertForm 호출 성공");
		
		String url = "";
		
		if(Member != null) {
			url = "client/route/routeInsertForm";
		} else {
			ras.addFlashAttribute("errorMsg", "회원에게만 글쓰기 권한이 있습니다.");
			url = "redirect:/member/loginForm";
		}
		
		return url;
	}
	

	@PostMapping("/routeInsert")
	public String routeInsert(@SessionAttribute(name="Member") MemberVO Member, RouteVO vo, Model model) throws Exception {
		log.info("routeInsert 메서드 호출");
		
		int result = 0;
		String url = "";

		vo.setMemberId(Member.getMemberId());
		result = routeService.routeInsert(vo);
		
		if(result == 0) {
			url = "/route/routeInsertForm";
		}else {
			url = "/route/routeList";
		}
		
		return "redirect:" + url;
		
		
//		return "redirect:/board/boardList";
	}
	
	//상세페이지
	@GetMapping("/routeDetail")
	public String routeDetail(@ModelAttribute RouteVO vo, Model model) {
		log.info("routeDetail 메서드 호출");
		
		RouteVO detail = routeService.routeDetail(vo);
		model.addAttribute("detail", detail);
		
		RouteReplyVO routeReplyVO = new RouteReplyVO();
	    model.addAttribute("routeReplyVO", routeReplyVO);
		
		return "client/route/routeDetail";
	}
	
	//글 수정 폼
	@GetMapping(value="/routeUpdateForm")
	public String routeUpdateForm(@ModelAttribute RouteVO vo, Model model) {
		log.info("routeUpdateForm 호출 성공");
		log.info("routeNo = " +vo.getRouteNo());
		
		RouteVO updateData = routeService.routeUpdateForm(vo);
		
		model.addAttribute("updateData", updateData);
		return "client/route/routeUpdateForm";
	}
	
	//글 수정 구현
	@PostMapping("/routeUpdate")
	public String routeUpdate(@ModelAttribute RouteVO vo)  throws Exception {
		log.info("routeUpdate 호출 성공");
		
		int result=0;
		String url="";
		
		result = routeService.routeUpdate(vo);
		
		if(result ==1) {
			url="/route/routeDetail?routeNo="+vo.getRouteNo();
		}else {
			url="/route/routeUpdateForm?routeNo="+vo.getRouteNo();
		}
		return "redirect:" + url;
	}
	

	//파일
	@PostMapping(value="/routeDelete")
	public String routeDelete(@ModelAttribute RouteVO vo) throws Exception{
		log.info("routeDelete 호출 성공");
		
		int result= 0;
		String url ="";
		
		result = routeService.routeDelete(vo);
		
		if(result == 1 ) {
			url = "/route/routeList";
		}else {
			url="/route/routeDetail?routeNo="+vo.getRouteNo();
		}
		return "redirect:" + url;
	}
	
	//글 삭제 전 댓글 개수 구현하기 @param int
	@ResponseBody
	@PostMapping(value="/routeReplyCnt",  produces = MediaType.TEXT_PLAIN_VALUE)
	public String routeReplyCnt(@RequestParam("routeNo") int routeNo) {
		log.info("replyCnt 호출 성공");
		
		int result = 0;
		result = routeService.routeReplyCnt(routeNo);

		return String.valueOf(result);
	}
	
	@PostMapping("/ckeditorUpload&responseType=json")
    @ResponseBody
    public Map<String, Object> ckeditorUpload(@RequestParam("upload") MultipartFile upload) {
        Map<String, Object> resultMap = new HashMap<>();

        try {
            // 파일 업로드 및 임시 파일명
            String tempFileName = FileUploadUtil.fileUpload(upload, "route");

            // CKEditor에 반환할 JSON 응답 생성
            resultMap.put("uploaded", 1);
            resultMap.put("fileName", tempFileName);
            resultMap.put("url", "/dongsanStorage/route/" + tempFileName);
        } catch (Exception e) {
            resultMap.put("uploaded", 0);
            resultMap.put("error", e.getMessage());
        }

        return resultMap;
    }
	

}
