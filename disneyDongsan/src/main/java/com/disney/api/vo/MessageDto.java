package com.disney.api.vo;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MessageDto {
	private String to;
	private String content;
}
