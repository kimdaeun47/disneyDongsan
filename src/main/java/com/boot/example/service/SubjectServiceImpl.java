package com.boot.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.example.dao.SubjectDAO;
import com.boot.example.domain.SubjectVO;

import lombok.Setter;

@Service
public class SubjectServiceImpl implements SubjectService {
	
	@Setter(onMethod_ = @Autowired )
	private SubjectDAO subjectDAO;
	
	@Override
	public List<SubjectVO> subjectList(){
		List<SubjectVO> list = null;
		list = subjectDAO.subjectList();
		return list;
	}
	
	@Override
	public String subjectNumber() {
		String number = subjectDAO.subjectNumber();
		return number;
	}
	
	@Override
	public void subjectInsert(SubjectVO svo) {
		subjectDAO.subjectInsert(svo);	
	}
	@Override
	public void subjectUpdate(SubjectVO svo) {
		subjectDAO.subjectUpdate(svo);	
	}
	@Override
	public void subjectDelete(SubjectVO svo) {
		subjectDAO.subjectDelete(svo);	
	}
	
	@Override
	public String deleteCheck(SubjectVO svo) {
		SubjectVO vo = subjectDAO.deleteCheck(svo);
		return vo.getDeleteable();
	}

}
