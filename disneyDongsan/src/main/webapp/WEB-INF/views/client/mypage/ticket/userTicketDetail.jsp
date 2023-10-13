<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap-theme.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/include/css/mypage/mypageTicketBody.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		$(function(){
			
			let tState = "${detail.t_state}";
			/*목록 버튼 클릭 시 처리 이벤트*/
			$('#tkListBtn').click(function(){
				location.href="/mypage/userTicketList"
			});
				
					$("#tkDeleteBtn").click(function(){
						tiketCancel = confirm("티켓을 취소하시겠습니까?");
						if(tiketCancel === true){
							if(tState === 'N'){
								alert("이미 취소가 완료된 티켓입니다.");
							}else{
								alert("취소가 완료되었습니다.");
								$("#tk_data").attr({
									"method":"post",
									"action":"/mypage/userTicketDelete"
								});
								$("#tk_data").submit();
							}
						}else{return;}
					});
		
		});
		</script>
	</head>
	<body>
	<body>
	<div class="contentContainer container">
		 <h3 class="fw-bold">티켓 상세내역</h3>
	     <hr>
		<form name="tk_data" id="tk_data" method="post">
			<input type="hidden" name="PAYMENT_ID" value="${detail.PAYMENT_ID}">
		</form>
		<div class="allBtn">
			<button class="tkdeleteBtn" type="button" id="tkDeleteBtn"></button>
			<button class="tkListBtn" type="button" id="tkListBtn">목록</button>
		</div>
		<div class="card ticketCard w-70 m-3">
			<div class="card-body ">
				<div class="tp-div">
				<div class="ticket-div">
					<p class="category"> <strong>${detail.t_category}</strong></p>
						<div class="ticket-object">
							<img class="miki" src="/resources/img/mickeymouse.png"/>
							<p class="me-1 ms-1">방문자&nbsp;<strong>${detail.member_name}&nbsp;</strong></p>
							<c:choose>
								<c:when test="${detail.t_adult ne 0}">
									<p>|&nbsp;&nbsp;인원&nbsp;&nbsp;<strong>성인 ${detail.t_adult}인</strong></p>
								</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${detail.t_student ne 0}">
									<p>|&nbsp;&nbsp;인원&nbsp;&nbsp;<strong>학생 ${detail.t_student}인</strong></p>
								</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${detail.t_child ne 0}">
									<p>|&nbsp;&nbsp;인원&nbsp;&nbsp;<strong>어린이 ${detail.t_child}인</strong></p>
								</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${detail.t_multi ne 0}">
									<p>|&nbsp;&nbsp;인원&nbsp;&nbsp;<strong>다인권 ${detail.t_multi}인</strong></p>
								</c:when>
							</c:choose>
							<c:choose>
								<c:when test="${detail.t_afternoon ne 0}">
									<p>|&nbsp;&nbsp;인원&nbsp;&nbsp;<strong>오후권 ${detail.t_afternoon}인</strong></p>
								</c:when>
							</c:choose>
						</div>
						<div class="ticket-object">
							<img class="miki" src="/resources/img/mickeymouse.png"/>
							<p class="me-1 ms-1">방문 예정일 <strong>${detail.visit_date}&nbsp;&nbsp;</strong></p>
							<p>|</p>
							<p class="ms-1">&nbsp;&nbsp;금액 
								<strong><fmt:formatNumber type="number" value="${detail.total_price}" pattern="#,##0" />원</strong>
							</p>
							
						</div>
						
						<div class="ticket-object">
							<img class="miki" src="/resources/img/mickeymouse.png"/>
							<p class="me-1 ms-1">티켓 상태&nbsp;&nbsp;
							<c:choose>
								<c:when test="${detail.t_state eq 'Y'}">
									<strong>결제완료</strong>
								</c:when>
								<c:when test="${detail.t_state eq 'N'}">
									<strong>취소완료</strong>
								</c:when>
							</c:choose>
							</p>
						</div>
					

				</div>
				<div class="payment_div">
					<p class="fs-3">주문번호<br/><strong>${detail.PAYMENT_ID}</strong></p><br/><br/>
				</div>
				</div>
			</div>
		</div>
	</div>
</body>
	
	</body>
</html>