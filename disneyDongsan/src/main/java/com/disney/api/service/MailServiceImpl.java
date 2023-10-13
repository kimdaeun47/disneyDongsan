package com.disney.api.service;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;



@Service
@RequiredArgsConstructor
public class MailServiceImpl implements MailService{

	@Autowired
	private final JavaMailSender javaMailSender;
	
	@Override
	public String generateRandomString(String email, String content) {
			String result = "";
		
			// 인증번호(랜덤 문자) 생성 
	       	Random rnd =new Random();
	       	StringBuffer buf =new StringBuffer();

	       	for(int i=0;i<10;i++){ //10자리
	       		// rnd.nextBoolean() 는 랜덤으로 true, false를 리턴. true일 시 랜덤한 소문자를, false 일 시 랜덤한 숫자를 StringBuffer에 append함
	       		if(rnd.nextBoolean()){
	       			buf.append((char)((int)(rnd.nextInt(26))+97)); //랜덤문자
	       		}else{
	       			buf.append((rnd.nextInt(10))); //랜덤숫자
	       		}
	       	}
	       
	        String randomString = buf.toString();
	      
	        if(content == "") {
	        	content = "<html><body><h2>인증번호 : " + randomString + "</h2></body></html>";
	        }
	        if(content == "tempPwd") {
	        	content = "<html><body><div>"
						+ "<h1>임시비밀번호 발급</h1>"
						+ "<h3>비밀번호 찾기를 통한 임시 비밀번호입니다.</h3>"
						+ "<p>임시비밀번호 : <h3>" + randomString + "</h3><br>"
						+ "로그인 후 비밀번호를 변경해주세요.</p>"
						+ "</div></body></html>";
	        }
	        
	        // 이메일로 랜덤 문자 발송 로직
	        try {
	            MimeMessage message = javaMailSender.createMimeMessage();
	            MimeMessageHelper helper = new MimeMessageHelper(message);
	            
	            helper.setFrom("ycl99623@gmail.com","Disney동산"); //
	            helper.setTo(email);  // 수신자 이메일 주소
	            helper.setSubject("Disney동산 이메일 인증");  // 메일 제목
	            helper.setText(content, true);  // 메일 내용 (랜덤 문자)
	            
	            javaMailSender.send(message);
	            
	            if(content.contains("인증번호")) {
	            	result = randomString;
	            } else {
	            	result = "success" + randomString;
	            }
	            
	        } catch (Exception e) {
	        	result = "failure";
	            return "Error sending email: " + e.getMessage();
	        }

	        return result;
	}

}
