package com.disney.client.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.disney.vo.QuestionVO;

@Mapper
public interface QuestionDao {
	
	/*사용자*/
	
	public List<QuestionVO> qaList(QuestionVO qvo);
	
	public int answerListCnt(QuestionVO qvo);
	
	public QuestionVO qawriteForm(QuestionVO qvo);
	
	public int qaInsert(QuestionVO qvo);
	
	public QuestionVO qaDetail(QuestionVO qvo);
	
	public int qaDelete(QuestionVO qvo);
	
	/*관리자*/
	
	public QuestionVO anUpdateForm(QuestionVO qvo);
	
	public int anUpdate(QuestionVO qvo);
	
	public int anDelete(QuestionVO qvo);
	
	

}
