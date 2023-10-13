package com.disney.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.QuestionDao;
import com.disney.vo.QuestionVO;

import lombok.Setter;

@Service
public class AdminAnswerServiceImpl implements AdminAnswerService{
	
	@Setter(onMethod_ = @Autowired)
	private QuestionDao questionDao;
	
	@Override
	public List<QuestionVO> anList(QuestionVO qvo){
		List<QuestionVO> list = null;
		list = questionDao.qaList(qvo);
		return list;
	}
	
	@Override
	public int answerListCnt(QuestionVO qvo) {
		return questionDao.answerListCnt(qvo);
	}
	 
	@Override
	public QuestionVO anUpdateForm(QuestionVO qvo) {
		QuestionVO updateData = null;
		updateData = questionDao.qaDetail(qvo);
		return updateData;
		
	}
	
	@Override
	public int anUpdate(QuestionVO qvo) {
		int result = 0;
		result = questionDao.anUpdate(qvo);
		return result;
	}
	
	@Override
	public int anDelete(QuestionVO qvo) {
		int result = 0;
		result = questionDao.anDelete(qvo);
		return result;
	}
	
	
	

}
