package com.disney.api.vo;

import java.util.List;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SmsRequestDto {
	private String type;
	private String contentType;
	private String countryCode;
	private String content;
	private String from;
	private List<MessageDto> messages;
}
