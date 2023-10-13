<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>Insert title here</title>
<link rel="shortcut icon" href="/resources/image/icon.png" />
<link rel="apple-touch-icon" href="/resources/image/icon.png" />

<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="/resources/include/css/mypageUserInfo.css" />

<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#CkBtn").click(function() {
			$.ajax({
				url : "/mypage/pwdChk",
				type : "post",
				data : $("#f_updateForm").serialize(),
				dataType : "text",
				error : function() {
					alert('시스템 오류 입니다. 관리자에 문의하세요');
				},
				success : function(resultData) {
					if (resultData == "실패") {
						alert("비밀번호가 정확하지 않습니다.");
					} else if (resultData == "성공") {

						location.href = "/member/updateMemberInfoForm";

						// 폼의 method와 action을 변경
						/* $("#f_updateForm").attr({
						    "method" : "post", // 예시로 "post"로 변경
						    "action" : "/member/updateMemberInfoForm" // 변경할 URL
						});

						// 폼을 서버로 제출
						$("#f_updateForm").submit(); */
					}
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="mypageContainer">
		<h2>마이페이지</h2><hr>
		<form id="f_updateForm" name="f_updateForm" method="post">
			<input type="hidden" name="memberId" id="memberId" value="${Member.memberId}">
			<div>
				<h3>개인정보 수정하기전에 비밀번호를 입력하세요.</h3>
				<label>현재 비밀번호</label> <input type="password" id="memberPasswd"
					name="memberPasswd" /><br /> <br />
				<button type="button" id="CkBtn">확인</button>
				<br />

			</div>
		</form>
	</div>

</body>
</html>