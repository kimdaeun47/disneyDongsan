package com.disney.admin.service;

import java.util.List;

import com.disney.vo.QuestionVO;

public interface AdminAnswerService {

	public List<QuestionVO> anList(QuestionVO qvo);
	
	public int answerListCnt(QuestionVO qvo);
	
	public QuestionVO anUpdateForm(QuestionVO qvo); 
	
	public int anUpdate(QuestionVO qvo);
	
	public int anDelete(QuestionVO qvo);
	
	
}
