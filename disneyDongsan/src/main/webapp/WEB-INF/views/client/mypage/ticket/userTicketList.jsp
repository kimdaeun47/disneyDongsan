<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	</head>
	<body>
		<div class="container">
			<h3 class="fw-bold">티켓 예매내역</h3>
      		<hr>
			<form name="detailForm" id="detailForm">
				<input type="hidden" name="PAYMENT_ID" id="PAYMENT_ID"/>
			</form>
			
			<div id="tketList"class="tketList">

				
					<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty tketList}">
								<c:forEach var="tketList" items="${tketList}" varStatus="status">
									<div class="card ticketCard w-70 m-3 ">
										<div class="card-body goDetail" style="padding-top: 50px;" data-num="${tketList.PAYMENT_ID}">
								
											<p class="card-title">구분&nbsp;&nbsp;&nbsp;${tketList.t_category}</p>
											<p class="card-text">가격&nbsp;&nbsp;&nbsp;
												<fmt:formatNumber type="number" value="${tketList.total_price}" pattern="#,##0" />원
											</p>
											<p class="card-text">방문일시&nbsp;&nbsp;&nbsp;${tketList.visit_date}</p>
											<p class="card-text">주문일시&nbsp;&nbsp;&nbsp;${tketList.pay_date}</p>
											
											
										</div>
										<div class="ticketSide">
											<h5 class="card-title"><strong class="payment-color" id="payment-color">${tketList.PAYMENT_ID}</strong></h5>
											<c:choose>
												<c:when test="${tketList.t_state eq 'Y'}">
													<p class="card-text">결제완료</p>
												</c:when>
												<c:when test="${tketList.t_state eq 'N'}">
													<p class="card-text">취소완료</p>
												</c:when>
											</c:choose>
										</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
							<div>
								<p class="text-center">등록된 게시물이 존재하지 않습니다.</p>
							</div>
							</c:otherwise>
						</c:choose>
				
			</div>
		</div>
	
	</body>
</html>