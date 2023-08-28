package com.boot.example.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.boot.example.domain.SubjectVO;

@Mapper
public interface SubjectDAO {
	
	public List<SubjectVO> subjectList();
	
	public String subjectNumber();
	
	public int subjectInsert(SubjectVO svo);
	
	public int subjectUpdate(SubjectVO svo);
	
	public int subjectDelete(SubjectVO svo);
	
	public SubjectVO deleteCheck(SubjectVO svo);
	
}
