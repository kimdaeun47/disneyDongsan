package com.disney.client.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.disney.client.dao.QuestionDao;
import com.disney.vo.QuestionVO;

import lombok.Setter;

@Service
public class QuestionServiceImpl implements QuestionService {
	
	@Setter(onMethod_ = @Autowired)
	private QuestionDao questionDao;
	
	@Override
	public List<QuestionVO> qaList(QuestionVO qvo){
		List<QuestionVO> list = null;
		list = questionDao.qaList(qvo);
		return list;
	}
	
	@Override
	public QuestionVO qaWriteForm(QuestionVO qvo) {
		QuestionVO write = null;
		write = questionDao.qawriteForm(qvo);
		return write;
	}
	
	@Override
	public int qaInsert(QuestionVO qvo) {
		int result = 0;
		result = questionDao.qaInsert(qvo);
		return result;
	}
	
	@Override
	public QuestionVO qaDetail(QuestionVO qvo) {
		QuestionVO detail = questionDao.qaDetail(qvo);
		if(detail != null) {
			detail.setQa_content(detail.getQa_content().toString().replaceAll("\n", "<br />"));
		} 
		return detail;
	}
	
	@Override 
	public int qaDelete(QuestionVO qvo) {
		int result = 0;
		result = questionDao.qaDelete(qvo);
		return result;
	}
	
	

}
