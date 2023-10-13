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
		<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap-theme.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/include/css/mypage/mypageListBody.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$(".goDetail").click(function(){
					let PAYMENT_ID = $(this).attr("data-num");
					$("#PAYMENT_ID").val(PAYMENT_ID);
					console.log("예매 번호:" + PAYMENT_ID);
					
					$("#detailForm").attr({
						"method" : "get",
						"action" : "/mypage/userTicketDetail"
					});
					$("#detailForm").submit();
				})
			});
		</script>
	
<script>
	$(function(){
		$("#okBtn").click(function(){
			if(confirm("정말 탈퇴하시겠습니까?")){
				location.href = "/member/withdrawal";
			};
		});
	});
</script>
</head>
<body>
	<div class="container">
		<h3>회원 탈퇴</h3>
		<hr>
		<h4>디즈니 동산 회원 탈퇴 시 유의사항입니다.</h4><br>
		<ul>
			<li>회원 탈퇴를 하시면 디즈니 동산에서 제공하는 서비스 및 할인혜택을 이용하실 수 없습니다.</li>
			<li>회원 탈퇴를 하시더라도 예약/예매 정보가 있는 경우 취소되지 않습니다.</li>
			<li>회원 탈퇴를 하시면 해당 아이디 및 비밀번호를 사용하여 홈페이지를 이용하실 수 없으며, <br>
				아이디와 함께 제공하신 개인정보가 모두 삭제됩니다.</li>
		</ul><br>
		<div class="text-center">
			<button type="button" id="okBtn">확인</button>
			<button type="button" id="cancelBtn">취소</button>
		</div>
	</div>
</body>
</html>