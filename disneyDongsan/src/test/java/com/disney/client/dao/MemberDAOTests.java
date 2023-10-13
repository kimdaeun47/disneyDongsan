package com.disney.client.dao;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.disney.vo.MemberVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class MemberDAOTests {

	@Setter(onMethod_ = @Autowired)
	private MemberDAO memberDAO;
	
//	@Test
//	public void loginTest() {
//		MemberVO mvo = new MemberVO();
//		
//		mvo.setMemberId("user01");
//		mvo.setMemberPasswd("user1234");
//		
//		MemberVO result = memberDAO.login(mvo);
//		log.info("loginTest 결과");
//		log.info(result.toString());
//	}
//	
//	@Test
//	public void findIdTest() {
//		MemberVO mvo = new MemberVO();
//		
//		mvo.setMemberName("사용자");
//		mvo.setMemberPhone("010-1234-1234");
//		
//		MemberVO result = memberDAO.findId(mvo);
//		log.info("findIdTest 결과");
//		log.info(result.toString());
//	}
//	
//	@Test
//	public void idCheckTest() {
//		MemberVO mvo = new MemberVO();
//		
//		mvo.setMemberId("user01");
//		
//		int result = memberDAO.idCheck(mvo);
//		log.info("idCheckTest 결과");
//		log.info("result : " + result);
//	}
//	
//	@Test
//	public void signupTest() {
//		MemberVO mvo = new MemberVO();
//		mvo.setMemberId("u0");
//		mvo.setMemberPasswd("u0");
//		mvo.setMemberName("홍길동");
//		mvo.setMemberPhone("01055553333");
//		mvo.setMemberEmail("hgd11@naver.com");
//		mvo.setMemberAddr1("16040");
//		mvo.setMemberAddr2("경기도 의왕시 갈미1로 22");
//		mvo.setMemberAddr3("108-803");
//		
//		int result = memberDAO.signup(mvo);
//		log.info("signupTest 결과");
//		log.info("result : " + result);
//	}
//	
//	@Test
//	public void withdrawalTest() {
//		MemberVO mvo = new MemberVO();
//		
//		mvo.setMemberId("u1");
//		
//		int result = memberDAO.withdrawal(mvo);
//		log.info("withdrawalTest 결과");
//		log.info("result : " + result);
//	}
	
//	@Test
//	public void updatePwd() {
//		MemberVO mvo = new MemberVO();
//		
//		mvo.setMemberId("ycl623");
//		mvo.setMemberPasswd("cofla990510*");
//		
//		int result = memberDAO.updatePwd(mvo);
//		log.info("updatePwd 결과");
//		log.info("result : " + result);
//	}
	
//	@Test
//	public void updatePhone() {
//		MemberVO mvo = new MemberVO();
//		
//		mvo.setMemberId("user01");
//		mvo.setMemberPhone("01011111111");
//		
//		int result = memberDAO.updateInfoPhone(mvo);
//		
//		log.info("updatePhone 결과 : " + result);
//	}
	
	@Test
	public void updateAddr() {
		MemberVO mvo = new MemberVO();
		
		mvo.setMemberId("user01");
		mvo.setMemberAddr1("16040");
		mvo.setMemberAddr2("경기도 의왕시");
		mvo.setMemberAddr3("108-803");
		
		int result = memberDAO.updateInfoAddr(mvo);
		
		log.info("updateAddr 결과 : " + result);
	}
}
