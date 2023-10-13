package com.disney.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.disney.api.service.MailService;

import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Controller
@RequiredArgsConstructor
public class MailController {

	@Setter(onMethod_ = @Autowired)
	private MailService mailService;
	
	@PostMapping("/mail/process")
    @ResponseBody
    public String sendRandomString(@RequestParam String memberEmail) {
        String randomString = mailService.generateRandomString(memberEmail, "");
        return randomString;
    }

}
