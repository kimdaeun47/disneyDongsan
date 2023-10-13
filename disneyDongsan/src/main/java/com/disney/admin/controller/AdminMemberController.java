package com.disney.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.disney.admin.service.AdminMemberService;
import com.disney.common.vo.PageDTO;
import com.disney.vo.MemberVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/member/*")
@Slf4j
public class AdminMemberController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminMemberService adminMemberService;
	
	@GetMapping("/memberList")
	public String memberList(MemberVO mvo, Model model) {
		List<MemberVO> memberList = adminMemberService.memberList(mvo);
		model.addAttribute("memberList", memberList);

		for(MemberVO member : memberList) {
			log.info(member.toString());
		}
		
		// 전체 레코드수 반환
		int total = adminMemberService.memberListCnt();
				
		// 페이징 처리
		model.addAttribute("pageMaker", new PageDTO(mvo, total));
		
		return "admin/member/memberList";
	}
}
