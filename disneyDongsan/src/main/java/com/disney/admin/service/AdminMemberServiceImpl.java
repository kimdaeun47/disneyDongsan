package com.disney.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.admin.dao.AdminMemberDAO;
import com.disney.vo.MemberVO;

import lombok.Setter;

@Service
public class AdminMemberServiceImpl implements AdminMemberService{
	
	@Setter(onMethod_ = @Autowired)
	private AdminMemberDAO adminMemberDAO;

	@Override
	public List<MemberVO> memberList(MemberVO mvo) {
		List<MemberVO> memberList = adminMemberDAO.memberList(mvo);
		return memberList;
	}

	@Override
	public int memberListCnt() {
		int result = adminMemberDAO.memberListCnt();
		return result;
	}
	
	
}
