<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css"
	href="/resources/include/css/login.css">
<script>
	$(function(){
		$("#loginFormBtn").click(function(){
			location.href = "/member/loginForm";
		});
	});
</script>
</head>
<body>
	<div class="loginContainer text-center">
		<h3 class="text-center">회원가입 완료</h3>
		<hr>
		<h5 class="text-center">디즈니 동산에 오신 것을 환영합니다!</h5>
		<br>
		<div>
			<img id="signupImg" src="/resources/include/img/signupsuccess.png">
		</div>
		<div class="btn-group" id="signupBtnDiv">
			<input type="button" id="loginFormBtn" class="button" value="로그인"/>
		</div>
		
	</div>
</body>
</html>