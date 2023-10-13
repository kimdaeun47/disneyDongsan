package com.disney.client.service;

import com.disney.vo.MemberVO;

public interface MypageUpdateService {
	
	public int pwdChk(MemberVO mvo);
	
	public int changePw(MemberVO mvo);
	
}
