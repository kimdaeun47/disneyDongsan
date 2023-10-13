package com.disney.client.service;

import java.util.List;

import com.disney.vo.QuestionVO;

public interface QuestionService {
	public List<QuestionVO> qaList(QuestionVO qvo);
	
	public QuestionVO qaWriteForm(QuestionVO qvo);
	
	public int qaInsert(QuestionVO qvo);
	
	public QuestionVO qaDetail(QuestionVO qvo);
	
	public int qaDelete(QuestionVO qvo);
	

}
