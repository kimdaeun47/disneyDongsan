package com.disney.vo;

import com.disney.common.vo.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;
@Data
@EqualsAndHashCode(callSuper = false)
public class QuestionVO extends CommonVO{
	
		private int qa_no = 0;  //문의 번호
		private String title = "";  //제목
		private String qa_content = "";  //내용
		private String qa_date;  //작성일
		private String askyn = ""; //답변 유무
		private String ask = "";  // 답변
		private String ask_date = null;  //답변일시
		private String member_id;
		
		private String[] valueArr;
	}


