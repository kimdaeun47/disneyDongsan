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
		
		$("#findPwdFormBtn").click(function(){
			location.href = "/member/findPwdForm";
		});
	});
</script>
</head>
<body>
	<div class="loginContainer text-center">
		<div id="findIdSuccess">
			<h3 class="text-center">아이디 찾기</h3>
			<hr>
			<h5 class="text-center"><strong>입력하신 정보</strong>와 일치하는 아이디입니다.</h5>
			<table class="table table-bordered" id="findIdTable">
				<tr>
					<td class="text-center">아이디</td>
					<td class="text-center">${member.memberId}</td>
				</tr>
				<tr>
					<td class="text-center">가입일</td>
					<td class="text-center">${member.memberRegdate}</td>
				</tr>
			</table>
			<div class="btn-group">
				<input type="button" id="loginFormBtn" class="button" value="로그인"/>
				<input type="button" id="findPwdFormBtn" class="button" value="비밀번호찾기"/>
			</div>
		</div>
	</div>
</body>
</html>