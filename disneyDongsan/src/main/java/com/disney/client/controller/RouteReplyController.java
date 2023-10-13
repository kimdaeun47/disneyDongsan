package com.disney.client.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.disney.client.service.RouteReplyService;
import com.disney.vo.MemberVO;
import com.disney.vo.RouteReplyVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping(value="/route/replies")
@Slf4j
public class RouteReplyController {
	
	@Setter(onMethod_= @Autowired)
	private RouteReplyService routeReplyService;
	
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

		entity = routeReplyService.replyList(rvo);
		return entity;
	}
	
	/**************************************************************
	 * 댓글 글쓰기 구현하기
	 * @return String
	 * 참고 : @RequestBody: JSON 데이터를 원하는 타입으로 바인딩 처리한다.{name:value} 
	 * 		consumes 속성을 이용하면 사용자가 Request Body에 담는 타입을 제한할 수 있으며 
	 * 		만약 요청 데이터가 JSON이라면 요청시 헤더에 반드시 application/json이 존재해야 한다.
	 * 
	 * 		produces 속성을 추가하고 dataType을 지정하면 해당 데이터타입으로만 
	 * 		사용자에게 응답하겠다는 의미로 해석하면 된다.
	 * 현재 요청 URL : http://localhost:8080/replies/replyInsert
	 **************************************************************/
	
	//댓글 글쓰기 구현하기
	@PostMapping(value="/replyInsert", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	public String replyInsert(@RequestBody RouteReplyVO rvo, @SessionAttribute(name="Member", required = false) MemberVO Member) { //{b_num:1, r_name:홍길동...}
		log.info("replyInsert 호출 성공");
		log.info("ReplyVO : " + rvo);
		int result = 0;
		
		String rs = "";
		if(Member != null) {
			rvo.setReplyMemberId(Member.getMemberId());
			result = routeReplyService.replyInsert(rvo);
			if(result == 1) {
				rs = "SUCCESS";
			} else {
				rs = "FAILURE";
			}
		} else {
			rs = "NO_SESSION";
		}
		
		log.info(rs);
		
		
		return rs;
		
	}
	/*****************************************************************
	 * 댓글 수정 구현하기
	 * @return
	 * 참고 : REST 방식에서 UPDATE 작업은 PUT,PATCH방식을 이용해서 처리.
	 * 		전체 데이터를 수정하는 경우에는 PUT을 이용하고,
	 * 		일부의 데이터를 수정하는 경우에는 PATCH를 이용.
	 * 현재 요청 URL:http://localhost:8080/replies/댓글번호
	 ***************************************************************/
	
	 @PutMapping(value = "/{replyNo}", consumes = "application/json", produces = MediaType.TEXT_PLAIN_VALUE)
	 public String replyUpdate(@PathVariable("replyNo") int replyNo, @RequestBody RouteReplyVO rvo) {
	    log.info("replyUpdate 호출 성공");
	      
	    rvo.setReplyNo(replyNo);
	    int result = routeReplyService.replyUpdate(rvo);
	    return (result == 1) ? "SUCCESS" : "FAILURE";
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
		result = routeReplyService.replyDelete(replyNo);
		return (result==1) ? "SUCCESS": "FAILURE";
	}
	

	
    // 전체 댓글 삭제
    @DeleteMapping(value="/all/{routeNo}", produces = MediaType.TEXT_PLAIN_VALUE)
    public String replyChoiceDelete(@PathVariable("routeNo") int routeNo) { 
        log.info("replyChoiceDelete 호출 성공");
        log.info("routeNo : " + routeNo);
        
        int result = 0;
        result = routeReplyService.replyChoiceDelete(routeNo);
        return (result >= 1) ? "SUCCESS": "FAILURE"; // 삭제된 댓글 수에 따라 SUCCESS 또는 FAILURE 반환
    }
	

	
	
	
}
