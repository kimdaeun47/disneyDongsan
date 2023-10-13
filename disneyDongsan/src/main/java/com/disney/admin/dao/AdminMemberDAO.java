package com.disney.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.MemberVO;

@Mapper
public interface AdminMemberDAO {
	public List<MemberVO> memberList(MemberVO mvo);
	public int memberListCnt();
}
