package com.disney.common.vo;

//import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//@Data
@ToString
@Setter
@Getter
public class CommonVO {
	private int pageNum = 0;	//페이지 번호
	private int amount = 0;		//페이지에 보여줄 데이터 수
	
	// 조건검색시 사용할 필드(검색대상, 검색단어)
	private String search = "";
	private String keyword = "";
	private String visitDate = "";
	private String visitDateEnd = "";
	private String ticketSearch = "";
	private String cancelSearch = "";
	
	// 이전글 다음글
	   private int prevNum = 0;
	   private int nextNum = 0;
	   private String prevTitle = "";
	   private String nextTitle = "";
	   
	public CommonVO() {
		this(1, 10);
	}
	
	public CommonVO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	// 날짜검색시 사용할 필드(시작일, 종료일)
	//	private String start_date = "";
	//	private String end_date = "";
}
