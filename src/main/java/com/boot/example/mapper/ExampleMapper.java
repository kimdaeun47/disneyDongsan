package com.boot.example.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ExampleMapper {
	
	@Select("select sysdate from dual")
	public String getTime();
	
	public String getDate();
}
