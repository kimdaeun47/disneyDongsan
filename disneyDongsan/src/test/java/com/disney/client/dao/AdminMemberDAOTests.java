package com.disney.client.dao;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.disney.admin.dao.AdminLoginDAO;
import com.disney.admin.dao.AdminMemberDAO;
import com.disney.vo.AdminVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
public class AdminMemberDAOTests {
	
	@Setter(onMethod_ = @Autowired)
	private AdminMemberDAO adminMemberDAO;
	
	@Setter(onMethod_ = @Autowired)
	private AdminLoginDAO adminLoginDAO;
	
//	@Test
//	public void memberListTest() {
//		log.info("memberListTest 결과");
//		
//		MemberVO vo = new MemberVO();
//		List<MemberVO> memberList = adminMemberDAO.memberList(vo);
//		
//		for(MemberVO mvo : memberList) {
//			log.info(mvo.toString());
//		}
//	}
	
	@Test
	public void adminLoginTest() {
		log.info("adminLogin 결과");
		
		AdminVO adminVO = new AdminVO();
		adminVO.setAdminId("admin");
		adminVO.setAdminPwd("admin1234");
		
		AdminVO result = adminLoginDAO.adminLogin(adminVO);
		log.info(result.toString());
	}
}
