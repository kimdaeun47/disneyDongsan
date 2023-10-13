package com.disney.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.disney.admin.service.AdminRouteReplyService;
import com.disney.vo.RouteReplyVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping(value="/admin/replies")
@Slf4j
public class AdminRouteReplyController {
	
	@Setter(onMethod_= @Autowired)
	private AdminRouteReplyService adminRouteReplyService;
	
	/***************************************************************************************
	 * 댓글 글목록 구현하기
	 * @return List<ReplyVO>
	 * 참고 : @PathVariable는 URI의 경로에서 원하는 데이터를 추출하는 용도의 어노테이션.
	 * 응답 문서 타입을 xml이나 json으로 반환할 때는 produces 속성을 사용한다.
	 * produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE }
	 * 현재 요청 URL : http://localhost:8080/replies/all/게시판글번호(b_num)
	 * 예전 요청 URL : http://localhost:8080/replies/replyList?b_num=게시판글번호
	 * ResponseEntity는 개발자가 직접 결과 데이터와 HTTP 상태 코드(200, 404, 500..)를 직접 제어할 수 있는 클래스.
	 **************************************************************************************/

	@GetMapping(value = "/all/{routeNo}", produces = MediaType.APPLICATION_JSON_VALUE)
	public List<RouteReplyVO> replyList(@PathVariable("routeNo") Integer routeNo, RouteReplyVO rvo){
		log.info("list 호출");
		
		List<RouteReplyVO> entity = null;
		rvo.setRouteNo(routeNo);

		entity = adminRouteReplyService.adminReplyList(rvo);
		return entity;
	}

	
	
	/*****************************************************************
	 * 댓글 삭제 구현하기
	 * @return
	 * 참고 : REST 방식에서 삭제 작업은 DELETE 이용해서 처리.
	 * 현재 요청 URL:http://localhost:8080/replies/댓글번호
	 ***************************************************************/
	
	@DeleteMapping(value="/{replyNo}",  produces = MediaType.TEXT_PLAIN_VALUE)
	public String replyDelete(@PathVariable("replyNo") int replyNo) { 
		log.info("replyDelete 호출 성공");
		log.info("replyNo : " + replyNo);
		
		int result = 0;
		result = adminRouteReplyService.adminReplyDelete(replyNo);
		return (result==1) ? "SUCCESS": "FAILURE";
	}
	

	
    // 전체 댓글 삭제
    @DeleteMapping(value="/all/{routeNo}", produces = MediaType.TEXT_PLAIN_VALUE)
    public String replyChoiceDelete(@PathVariable("routeNo") int routeNo) { 
        log.info("replyChoiceDelete 호출 성공");
        log.info("routeNo : " + routeNo);
        
        int result = 0;
        result = adminRouteReplyService.adminReplyChoiceDelete(routeNo);
        return (result >= 1) ? "SUCCESS": "FAILURE"; // 삭제된 댓글 수에 따라 SUCCESS 또는 FAILURE 반환
    }
	

	
	
}
