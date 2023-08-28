package com.boot.example.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ExampleVOList {
	private List<ExampleVO> list;
	
	public ExampleVOList() {
		list = new ArrayList<>();
		
	}

}
