package com.boot.example.mapper;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest
public class ExampleMapperTests {
	@Setter(onMethod_ = @Autowired)
	private ExampleMapper exampleMapper;
	
	@Test
	public void testGetTime() {
		log.info(exampleMapper.getClass().getName());
		log.info("getTime() 메서드 실행");
		log.info(exampleMapper.getTime());
	}
	
	@Test
	public void testGetDate() {
		log.info("getDate() 메서드 실행");
		log.info(exampleMapper.getDate());
	}
}
