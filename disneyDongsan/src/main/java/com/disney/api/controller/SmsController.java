package com.disney.api.controller;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.disney.api.service.SmsService;
import com.disney.api.vo.MessageDto;
import com.disney.api.vo.SmsResponseDto;
import com.fasterxml.jackson.core.JsonProcessingException;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class SmsController {
	private final SmsService smsService;

	@PostMapping("/sms/send")
	public SmsResponseDto sendSms(MessageDto messageDto) throws UnsupportedEncodingException,
			URISyntaxException, NoSuchAlgorithmException, InvalidKeyException, JsonProcessingException {

		SmsResponseDto responseDto = smsService.sendSMS(messageDto);
		return responseDto;
	}
}
