<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" type="text/css"
	href="/resources/include/css/login.css">
<script>
	$(function(){
		$("#homeBtn").click(function(){
			location.href="/";
		});
	});
</script>
</head>
<body>
	<div id="container">
		<h3 class="text-center">회원탈퇴가 완료되었습니다.</h3>
		<hr>
		<h4 class="text-center">그동안 디즈니 동산을 이용해 주셔서 감사합니다.<br>
			더욱더 노력하는 디즈니 동산이 되겠습니다.</h4><br>
		
		<div class="text-center">
			<button type="button" class="form-control button" id="homeBtn">메인 페이지로 이동</button>
		</div>
	</div>
</body>
</html>