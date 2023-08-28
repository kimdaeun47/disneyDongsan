package com.boot.example.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

//import lombok.Data;

//@Data
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ExampleVO {
	private Integer no;
	private String name;
	private String phone;

}
