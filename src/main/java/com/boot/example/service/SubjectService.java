package com.boot.example.service;

import java.util.List;

import com.boot.example.domain.SubjectVO;

public interface SubjectService {
	
	public List<SubjectVO> subjectList();
	
	public String subjectNumber();
	
	public void subjectInsert(SubjectVO svo);
	
	public void subjectUpdate(SubjectVO svo);
	
	public void subjectDelete(SubjectVO svo);
	
	public String deleteCheck(SubjectVO svo);
	

}
