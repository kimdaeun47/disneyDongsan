package com.disney.admin.service;

import java.util.List;

import com.disney.vo.MemberVO;

public interface AdminMemberService {
	public List<MemberVO> memberList(MemberVO mvo);
	public int memberListCnt();
}
