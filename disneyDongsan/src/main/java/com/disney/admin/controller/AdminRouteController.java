package com.disney.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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

import com.disney.admin.service.AdminRouteReplyService;
import com.disney.admin.service.AdminRouteService;
import com.disney.common.file.FileUploadUtil;
import com.disney.common.vo.PageDTO;
import com.disney.vo.RouteReplyVO;
import com.disney.vo.RouteVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/*")
@Slf4j
public class AdminRouteController {
	@Setter(onMethod_ = @Autowired)
	private AdminRouteService adminRouteService;
	
	@Setter(onMethod_ = @Autowired)
	private AdminRouteReplyService adminRouteReplyService;
	

	//페이징 처리 목록 조회
	@GetMapping("/routeList")
	public String AdminRouteList(@ModelAttribute RouteVO vo, Model model) {
		log.info("routeList 메서드 호출");
		//bvo.setAmount(5);
		//전체 레코드 조회
		List<RouteVO> routeList = adminRouteService.adminRouteList(vo);
		model.addAttribute("routeList" ,routeList);
		
		//전체 레코드수 반환.
		int total = adminRouteService.adminRouteListCnt(vo);

		//페이징 처리
		model.addAttribute("pageMaker", new PageDTO(vo, total));
		
		// 리스트 번호 부여를 위한 속성
		int count = total - (vo.getPageNum()-1) * vo.getAmount();
		model.addAttribute("count", count);
		
		return "admin/route/routeList";
	}

	
	//상세페이지
	@GetMapping("/routeDetail")
	public String AdminRouteDetail(@ModelAttribute RouteVO vo, Model model) {
		log.info("routeDetail 메서드 호출");
		
		RouteVO detail = adminRouteService.adminRouteDetail(vo);
		model.addAttribute("detail", detail);
		
		RouteReplyVO routeReplyVO = new RouteReplyVO();
	    model.addAttribute("routeReplyVO", routeReplyVO);
		
		return "admin/route/routeDetail";
	}
	
	

	//파일
	@PostMapping(value="/routeDelete")
	public String AdminRouteDelete(@ModelAttribute RouteVO vo) throws Exception{
		log.info("routeDelete 호출 성공");
		
		int result= 0;
		String url ="";
		
		result = adminRouteService.adminRouteDelete(vo);
		
		if(result == 1 ) {
			url = "/admin/routeList";
		}else {
			url="/admin/routeDetail?routeNo="+vo.getRouteNo();
		}
		return "redirect:" + url;
	}
	
	//글 삭제 전 댓글 개수 구현하기 @param int
	@ResponseBody
	@PostMapping(value="/adminRouteReplyCnt",  produces = MediaType.TEXT_PLAIN_VALUE)
	public String AdminRouteReplyCnt(@RequestParam("routeNo") int routeNo) {
		log.info("replyCnt 호출 성공");
		
		int result = 0;
		result = adminRouteService.adminRouteReplyCnt(routeNo);

		return String.valueOf(result);
	}
	
	
	
	@ResponseBody
	@PostMapping(value = "/adminAllRouteDelete", produces = "text/plain; charset=UTF-8")
	public String adminAllRouteDelete(HttpServletRequest request, @ModelAttribute RouteVO vo) throws Exception {
	    String[] checkNumber = request.getParameterValues("checkNumber");
	    int valueCnt = checkNumber.length;
	    log.info("valueCnt:" + valueCnt);
	    vo.setCheckNumber(checkNumber);
	    log.info("qvo:" + vo.toString());

	    // 결과를 저장할 변수
	    String value = "실패";

	    // 체크된 게시물을 삭제하기 전에 해당 게시물의 이미지를 먼저 삭제
	    for (String routeId : checkNumber) {
	        // 이미지 삭제를 위해 해당 게시물 정보를 가져옴
	    	 RouteVO route = adminRouteService.adminSearchRouteNo(routeId);
	        
	        if (route != null) {
	            if (route.getRouteImage() != null && !route.getRouteImage().isEmpty()) {
	                try {
	                    FileUploadUtil.fileDelete(route.getRouteImage());
	                } catch (IOException e) {
	                    // 파일 삭제 중 오류 발생 시 로그 기록
	                    log.error("이미지 파일 삭제 오류: " + e.getMessage());
	                }
	            }
	        }
	    }
	    
	    int replyDeleteResult = adminAllRouteReplyDelete(request, checkNumber, new RouteReplyVO());
	    // 게시물 삭제 처리
	    int result = adminRouteService.adminAllRouteDelete(vo);
	    
	    // 게시물 삭제에 성공하면 댓글 삭제를 시도합니다.
	    if (result >= 1) {
	        // 댓글 삭제를 시도하고 그 결과를 받아옴
	        //int replyDeleteResult = adminAllRouteReplyDelete(request, checkNumber, new RouteReplyVO());
	        
	        // 댓글 삭제가 성공하면 결과를 "성공"으로 설정
	        if (replyDeleteResult >= 0) {
	            value = "성공";
	        }
	    }

	    log.info("value=" + value);
	    return value;
	}

	// 댓글 삭제 메서드
	private int adminAllRouteReplyDelete(HttpServletRequest request, String[] checkNumber, RouteReplyVO rvo) throws Exception {
	    log.info("adminAllRouteReplyDelete 호출 성공");

	    int valueCnt = checkNumber.length;
	    log.info("valueCnt:" + valueCnt);
	    rvo.setCheckNumber(checkNumber);
	    log.info("qvo:" + rvo.toString());

	    // 삭제된 댓글 수를 반환합니다.
	    return adminRouteReplyService.adminAllRouteReplyDelete(rvo);
	}

	

}
