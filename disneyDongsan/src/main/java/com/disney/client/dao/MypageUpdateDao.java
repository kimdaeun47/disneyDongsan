package com.disney.client.dao;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.MemberVO;

@Mapper
public interface MypageUpdateDao {
	 
	 public int pwdChk(MemberVO mvo);
	 
	 public int changePw(MemberVO mvo);
	 
	 public MemberVO updateForm(String username);
	
}
