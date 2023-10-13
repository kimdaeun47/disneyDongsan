<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		
		<title>Insert title here</title>
		<link rel="shortcut icon" href="/resources/image/icon.png"/>
		<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
		
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap.min.css"/>
		
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="/resources/include/css/mypageUserInfo.css">
<script>
	$(function(){
		$("#homeBtn").click(function(){
			location.href="/";
		});
	});
</script>
</head>
<body>
	<div class="container">
		<h3 class="fw-bold">회원 탈퇴</h3>
		<hr>
		<div id="withdrawalDiv" class="text-center p-5">
			<h4 class="fw-bold">회원탈퇴가 완료되었습니다.</h4>
			<h6>그동안 디즈니 동산을 이용해 주셔서 감사합니다.<br>더욱더 노력하는 디즈니 동산이 되겠습니다.</h6>
			<div>
				<img id="withImg" src="/resources/include/img/signupsuccess.png">
			</div>
			<div class="text-center with-button">
				<button type="button" id="homeBtn">메인 페이지로 이동</button>
			</div>
		</div>
	</div>
</body>
</html>