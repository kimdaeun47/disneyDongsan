package com.disney.client.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.disney.api.service.MailService;
import com.disney.client.service.MemberService;
import com.disney.vo.MemberVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member/*")
@SessionAttributes("Member")
public class MemberController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService memberService;
	
	@Setter(onMethod_ = @Autowired)
	private MailService mailService;
	
	/* 로그인 폼 화면 */
	@GetMapping("/loginForm")
	public String loginForm() {
		return "client/member/login/loginForm";
	}
	
	/* 로그인 처리 */
	@PostMapping("/login")
	public String login(MemberVO mvo, Model model, RedirectAttributes ras) {
		String url = "";
		
		MemberVO memberVO = null;
		memberVO = memberService.login(mvo);
		
		if(memberVO != null) {
			if(memberVO.getMemberState().equals("NE")) {
				ras.addFlashAttribute("errorMsg", "탈퇴한 회원 정보로 로그인할 수 없습니다.");
				url = "member/loginForm";
			} else {
				model.addAttribute("Member", memberVO);
				url = "";
			}
		} else {
			ras.addFlashAttribute("errorMsg", "아이디 또는 비밀번호를 잘못 입력했습니다.");
			url = "member/loginForm";
		}
		
		return "redirect:/" + url;
	}
	
	/* 로그아웃 처리 */
	@GetMapping("/logout")
	public String logout(SessionStatus sessionStatus, RedirectAttributes ras) {
		
		sessionStatus.setComplete();
		
		return "redirect:/";
	}
	
	/* 아이디 찾기 폼 화면 */
	@GetMapping("/findIdForm")
	public String findIdForm() {
		return "client/member/login/findIdForm";
	}
	
	/* 아이디 찾기 전 회원 존재 여부 확인 */
	@ResponseBody
	@PostMapping("/findIdMemberExists")
	public String findIdMemberExists(MemberVO mvo) {
		int result = memberService.findIdMemberExists(mvo);
		
		return (result == 1) ? "success" : "failure";
	}
	
	/* 아이디 찾기 처리 */
	@PostMapping("/findId")
	public String findId(MemberVO mvo, Model model) {
		MemberVO memberVO = null;
		memberVO = memberService.findId(mvo);
		
		if(memberVO != null) {
			model.addAttribute("member", memberVO);
		} else {
			model.addAttribute("errorMsg", "입력하신 정보와 일치하는 아이디가 없습니다.");
		}
		
		return "client/member/login/findIdSuccess";
	}
	
	/* 비밀번호 찾기 폼 화면 */
	@GetMapping("/findPwdForm")
	public String findPwdForm() {
		return "client/member/login/findPwdForm";
	}
	
	/* 비밀번호 찾기 전 회원 존재 여부 확인 */
	@ResponseBody
	@PostMapping("/findPwdMemberExists")
	public String findPwdMemberExists(MemberVO mvo) {
		int result = memberService.findPwdMemberExists(mvo);
		
		return (result == 1) ? "success" : "failure";
	}
	
	/* 임시 비밀번호 전송 */
	@PostMapping("/sendTempPwd")
	@ResponseBody
	public String sendTempPwd(MemberVO mvo) {
		String result = mailService.generateRandomString(mvo.getMemberEmail(), "tempPwd");
		
		return result;
	}
	
	/* 비밀번호 재설정 */
	@PostMapping("/updatePwd")
	public String updatePwd(MemberVO mvo, RedirectAttributes ras) {
		String url = "";
		
		int result = memberService.updatePwd(mvo);
		log.info("result : " + result);
		
		if(result == 1) {
			url = "client/member/login/findPwdSuccess";
		} else {
			ras.addFlashAttribute("errorMsg", "시스템 오류입니다. 이메일 인증을 다시 진행해주세요.");
			url = "redirect:/member/findPwdForm";
		}
		
		return url;
	}
	
	/* 회원가입 약관 동의 화면 */
	@GetMapping("/signupTos")
	public String signupTos() {
		return "client/member/signup/signupTos";
	}
	
	/* 회원가입 폼 화면 */
	@GetMapping("/signupForm")
	public String signupForm() {
		return "client/member/signup/signupForm";
	}
	
	/* 회원가입 - 아이디 중복확인 */
	@ResponseBody
	@PostMapping("/idCheck")
	public String idCheck(MemberVO mvo) {
		int result = memberService.idCheck(mvo);
		
		return String.valueOf(result);
	}
	
	/* 회원가입 처리 */
	@PostMapping("/signup")
	public String signup(MemberVO mvo, RedirectAttributes ras) {
		String url = "";
		int result = memberService.signup(mvo);
		
		if(result == 1) {
			url = "client/member/signup/signupSuccess";
		} else {
			ras.addFlashAttribute("errorMsg", "회원가입 실패. 다시 진행해주세요.");
			url = "redirect:/member/signupForm";
		}
		
		return url;
	}
	
	/* 회원 탈퇴 폼 화면*/
	@GetMapping("/withdrawalForm")
	public String withdrawalForm() {
		return "client/mypage/withdrawal/withdrawalForm";
	}
	
	/* 회원 탈퇴 처리 */
	@GetMapping("/withdrawal")
	public String withdrawal(@SessionAttribute MemberVO Member, SessionStatus sessionStatus, MemberVO mvo, RedirectAttributes ras) {
		String url = "";
		
		mvo.setMemberId(Member.getMemberId());
		int result = memberService.withdrawal(mvo);
		
		if(result == 1) {
			sessionStatus.setComplete();
			url = "client/mypage/withdrawal/withdrawalSuccess";
		} else {
			ras.addFlashAttribute("errorMsg", "회원 탈퇴 오류 발생. 잠시 후에 다시 시도해주세요.");
			url = "redirect:/member/withdrawalForm";
		}
		
		return url;
	}
	
	@GetMapping("/updateMemberInfoForm")
	public String updateInfoForm(@SessionAttribute(name = "Member", required = false) MemberVO Member) {
		String url = "";
		
		if(Member != null) {
			url = "client/mypage/updateinfo/updateInfoForm";
		} else {
			url = "redirect:/member/loginForm";
		}
		
		return url;
	}
	
	@PostMapping("/member/updateInfoPhone")
	public String updateInfoPhone(MemberVO mvo, Model model, RedirectAttributes ras) {
		
		int result = memberService.updateInfoPhone(mvo);
		
		if(result == 1) {
			MemberVO memberVO = memberService.memberDetail(mvo);
			model.addAttribute("Member", memberVO);
		} else {
			ras.addFlashAttribute("errorMsg", "시스템 오류입니다. 잠시 후에 다시 시도해주세요.");
		}
	
		return "redirect:/member/updateMemberInfoForm";
	}
	
	@PostMapping("/member/updateInfoEmail")
	public String updateInfoEmail(MemberVO mvo, Model model, RedirectAttributes ras) {
		
		int result = memberService.updateInfoEmail(mvo);
		
		if(result == 1) {
			MemberVO memberVO = memberService.memberDetail(mvo);
			model.addAttribute("Member", memberVO);
		} else {
			ras.addFlashAttribute("errorMsg", "시스템 오류입니다. 잠시 후에 다시 시도해주세요.");
		}
		
		return "redirect:/member/updateMemberInfoForm";
	}
	
	@PostMapping("/member/updateInfoAddr")
	public String updateInfoAddr(MemberVO mvo, Model model, RedirectAttributes ras) {
		
		int result = memberService.updateInfoAddr(mvo);
		
		if(result == 1) {
			MemberVO memberVO = memberService.memberDetail(mvo);
			model.addAttribute("Member", memberVO);
		} else {
			ras.addFlashAttribute("errorMsg", "시스템 오류입니다. 잠시 후에 다시 시도해주세요.");
		}
		
		return "redirect:/member/updateMemberInfoForm";
	}
}
