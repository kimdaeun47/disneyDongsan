package com.disney.client.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.MypageUpdateDao;
import com.disney.vo.MemberVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MypageUpdateServiceImpl implements MypageUpdateService{

	@Setter(onMethod_ = @Autowired)
	private MypageUpdateDao mypagePwChangeDao;
	
	  
	  @Override
	  	public int pwdChk(MemberVO mvo) {
		  int result = 0;
		  
		  result = mypagePwChangeDao.pwdChk(mvo);
		  log.info("result=" + result);
		  return result;
	  }
	  
	  @Override
	  	public int changePw(MemberVO mvo) {
		  int result = 0;
		  result = mypagePwChangeDao.changePw(mvo);
		  return result;
	  }
	  
}
