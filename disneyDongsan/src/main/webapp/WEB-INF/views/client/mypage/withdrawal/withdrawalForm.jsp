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
		$("#okBtn").click(function(){
			if($("#checkbox").is(":checked")){
				if(confirm("정말 탈퇴하시겠습니까?")){
					location.href = "/member/withdrawal";
				};
			} else {
				alert("탈퇴 안내를 확인하고 동의해 주세요.");
			};
		});
	});
</script>
</head>
<body>
	<div class="container">
		<h3 class="fw-bold">회원 탈퇴</h3>
		<hr>
		<div id="withdrawalDiv" class="text-center p-5">
			<h4>디즈니 동산 회원 탈퇴 시 <strong>유의사항</strong>입니다.</h4>
			<h6 class="withdrawal-h5">회원탈퇴를 신청하기 전에 유의사항을 꼭 확인해주세요.</h6><br>
			<div id="listDiv">
				<ul>
					<li><img src="/resources/img/mickeymouse.png">사용하고 계신 아이디(<strong>${Member.memberId}</strong>)는 탈퇴할 경우 재사용 및 복구가 불가능합니다.</li>
					<li><img src="/resources/img/mickeymouse.png">디즈니 동산에서 제공하는 서비스 및 할인혜택을 이용하실 수 없습니다.</li>
					<li><img src="/resources/img/mickeymouse.png">탈퇴 후에도 예약/예매 정보가 있는 경우 취소되지 않습니다.</li>
					<li><img src="/resources/img/mickeymouse.png">탈퇴 후에도 게시판형 서비스에 등록한 게시물은 그대로 남아 있습니다.</li>
					<br>
					<li><input type="checkbox" id="checkbox"> 유의사항을 모두 확인하였으며, 이에 동의합니다.</li>
				</ul>
			</div>
			<br>
			<div class="text-center with-button">
				<button type="button" id="okBtn">확인</button>
			</div>
		</div>
		
	</div>
</body>
</html>