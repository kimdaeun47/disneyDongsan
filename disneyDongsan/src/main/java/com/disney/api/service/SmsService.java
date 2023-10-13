package com.disney.api.service;

import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import org.springframework.web.client.RestClientException;

import com.disney.api.vo.MessageDto;
import com.disney.api.vo.SmsResponseDto;
import com.fasterxml.jackson.core.JsonProcessingException;

public interface SmsService {
	public SmsResponseDto sendSMS(MessageDto messageDto) 
			throws JsonProcessingException, 
					RestClientException, 
					URISyntaxException, 
					InvalidKeyException, 
					NoSuchAlgorithmException, 
					UnsupportedEncodingException;
}
