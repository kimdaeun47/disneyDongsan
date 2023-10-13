<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		
		<title>Insert title here</title>
		<link rel="shortcut icon" href="/resources/image/icon.png"/>
		<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
		<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap-theme.min.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		let errorMsg = "${errorMsg}";
		if(errorMsg != ''){
			alert(errorMsg);
			errorMsg = '';
		};
		
		
			
	});
</script>
</head>
	<body>
		<div class="content_box">
        <form id="f_updateForm" name="f_updateForm" method="post">
        
            <input type="hidden" name="memberId" id="memberId" value="${Member.memberId}">
        <div>
        	<label>현재 비밀번호</label>
        	<input type="password" id="memberPasswd" name="memberPasswd"/><br/>
            <label>변경할 비밀번호</label>
            <input type="password" id="new_password" name="new_password"/><br/>
            <label>비밀번호 확인</label>
            <input type="password" id="chk_password" name="chk_password"/><span id="chkmsg"></span>
            <br/>
            <button type="button" id="pwdUpdate">변경하기</button>
        </div>
        </form>
    </div>
	</body>
</html>