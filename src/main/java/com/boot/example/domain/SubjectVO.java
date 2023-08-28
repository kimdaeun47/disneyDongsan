package com.boot.example.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SubjectVO {
	private int no;
	private String s_num;
	private String s_name;
	private String deleteable;

}
