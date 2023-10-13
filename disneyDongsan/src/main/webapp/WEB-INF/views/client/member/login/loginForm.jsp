<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" href="/resources/include/css/login.css">
<script type="text/javascript">
	$(function() {
		let errorMsg = "${errorMsg}";
		if (errorMsg != "") {
			$("#errorMsg").html(errorMsg).css("color","red");
			errorMsg = '';
		};

		$("#loginBtn").click(function() {
			if (!chkData("#memberId", "아이디를"))
				return;
			else if (!chkData("#memberPasswd", "비밀번호를"))
				return;
			else {
				$("#loginForm").attr({
					"method" : "post",
					"action" : "/member/login"
				});
				$("#loginForm").submit();
			}
		});

		$("#findIdBtn").click(function() {
			location.href = "/member/findIdForm";
		});

		$("#findPwdBtn").click(function() {
			location.href = "/member/findPwdForm";
		});

		$("#signUpFormBtn").click(function() {
			location.href = "/member/signupTos";
		});
	});
</script>
</head>
<body>
	<div class="loginContainer">
		<h3 class="text-center">로그인</h3>
		<hr>
		<form id="loginForm" name="loginForm">
			<div class="loginDiv">
				<div class="form-group text-center">
					<input type="text" id="memberId" name="memberId" placeholder="아이디" />
				</div>
				<div class="form-group text-center">
					<input type="password" id="memberPasswd" name="memberPasswd" placeholder="비밀번호" />
				</div>
				<span id="errorMsg"></span>
				
				<div class="form-group text-center">
					<input type="button" class="loginbutton" id="loginBtn" value="로그인" />
				</div>
				
				<div class="findDiv text-center">
					<button type="button" class="btn" id="findIdBtn">아이디 찾기</button>
					|
					<button type="button" class="btn" id="findPwdBtn">비밀번호 찾기</button>
					|
					<button type="button" class="btn" id="signUpFormBtn">회원가입</button>
				</div>
				
				
			</div>
		</form>
	</div>

</body>
</html>