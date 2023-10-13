package com.disney.client.service;

import com.disney.vo.MemberVO;

public interface MemberService {
	public MemberVO login(MemberVO mvo);
	public int findIdMemberExists(MemberVO mvo);
	public MemberVO findId(MemberVO mvo);
	public int findPwdMemberExists(MemberVO mvo);
	public int updatePwd(MemberVO mvo);
	public int idCheck(MemberVO mvo);
	public int signup(MemberVO mvo);
	public int withdrawal(MemberVO mvo);
	public int updateInfoPhone(MemberVO mvo);
	public MemberVO memberDetail(MemberVO mvo);
	public int updateInfoEmail(MemberVO mvo);
	public int updateInfoAddr(MemberVO mvo);
}
