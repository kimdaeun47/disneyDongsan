package com.boot.example.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

//@Data//설정자, 접근자, toString 모두 사용하는 어도테이션
@Setter//설정자 어노테이션
@Getter//접근자 어노테이션
@ToString//toString 어노테이션
@AllArgsConstructor//매개변수를 전부 가지고 있는 생성자 어노테이션
@NoArgsConstructor//매개변수 없는 생성자 어노테이션(디폴트 생성자)
public class SampleDTO {
	private String name;
	private int age;


}
