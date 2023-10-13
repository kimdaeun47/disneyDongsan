package com.disney.api.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class SmsResponseDto {
	private String requestId;
	private LocalDateTime requestTime;
	private String statusCode;
	private String statusName;
	private String createSmsKey;
}
