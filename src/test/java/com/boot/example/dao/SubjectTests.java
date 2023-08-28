package com.boot.example.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.boot.example.domain.SubjectVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class SubjectTests {
	
	@Setter(onMethod_ = @Autowired)
	private SubjectDAO subjectDAO;
	
	@Test
	public void subjectListTest() {
		log.info("----------------------------");
		log.info("subjectList() 메서드 실행");
		List<SubjectVO> list = subjectDAO.subjectList();
		for(SubjectVO vo : list) {
			log.info(vo.toString());
		}
	}
	
	@Test
	public void subjectNumberTest() {
		log.info("----------------------------");
		log.info("subjectNumber() 메서드 실행");
		String number = subjectDAO.subjectNumber();
		log.info(number);
	}
	
	@Test
	public void subjectInsertTest() {
		log.info("----------------------------");
		log.info("subjectInsert() 메서드 실행");
		SubjectVO vo = new SubjectVO();
		vo.setS_num(subjectDAO.subjectNumber());
		vo.setS_name("통계학과");
		int result = subjectDAO.subjectInsert(vo);
		log.info(String.valueOf(result));
	}
	
	@Test
	public void subjectUpdateTest() {
		log.info("----------------------------");
		log.info("subjectUpdate() 메서드 실행");
		SubjectVO vo = new SubjectVO();
		vo.setNo(9);
		vo.setS_name("단다");
		int result = subjectDAO.subjectUpdate(vo);
		log.info(String.valueOf(result));
	}
	
	@Test
	public void subjectDeleteTest() {
		log.info("----------------------------");
		log.info("subjectDelete() 메서드 실행");
		SubjectVO vo = new SubjectVO();
		vo.setNo(12);
		int result = subjectDAO.subjectDelete(vo);
		log.info(String.valueOf(result));
	}
	
	@Test
	public void deleteCheckTest() {
		log.info("----------------------------");
		log.info("deleteCheck() 메서드 실행");
		SubjectVO vo = new SubjectVO();
		vo.setNo(1);
		SubjectVO svo = subjectDAO.deleteCheck(vo);
		log.info(svo.getDeleteable());
	}
	
}
