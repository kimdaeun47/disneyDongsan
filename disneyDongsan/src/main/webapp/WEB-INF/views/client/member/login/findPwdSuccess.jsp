<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" href="/resources/include/css/login.css">
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
		<br>
		<br>
		<h3 class="text-center">비밀번호 찾기</h3>
		<hr>
		<br>
		<h5 class="text-center">입력된 이메일로 <strong>임시 비밀번호</strong>가 전송되었습니다.</h5>
		<h5 class="text-center">다시 로그인하여 비밀번호를 변경해주세요.</h5>
		<br>
		<div class="btn-group" id="findPwdBtnDiv">
			<input type="button" id="loginFormBtn" class="button" value="로그인"/>
		</div>
	</div>
</body>
</html>