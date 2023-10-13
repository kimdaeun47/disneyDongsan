package com.disney.vo;

import java.util.ArrayList;
import java.util.List;

import com.disney.common.vo.CommonVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper = false)
public class NoticeVO extends CommonVO{
	private int n_num =0;
	private String n_title = "";
	private String n_content = "";
	private String n_date;
	
	private List<String> images = new ArrayList<>();

	public void addImage(String imageFileName) {
        this.images.add(imageFileName);
    }
	
	private String[] checkNumber;
	
}
