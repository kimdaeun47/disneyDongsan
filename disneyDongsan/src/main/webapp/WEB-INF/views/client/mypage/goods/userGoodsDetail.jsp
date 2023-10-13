<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<link rel="stylesheet" type="text/css" href="/resources/include/css/mypage/mypageDetailBody.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<style>
		.file{
			width : 200px;
		}
		</style>
		<script type="text/javascript">
	
			
		
		function goodsList(){
			location.href="/mypage/userGoodsList";
		}
			
		
		</script>
	</head>
	<body>
		
		<div class="container">
		<h3 class="fw-bold">굿즈 주문상세</h3>
	    <hr>
			<form name="detailForm" id="detailForm">
				<input type="hidden" name="g_order_detail_id" id="g_order_detail_id"/>
			</form>
			
			 
			<div id="GoodsDetail" >
					<!-- 데이터 출력 -->
						<div class="card w-70 m-3">
						<div class="top-color">
							<div class="ms-4 me-4 p-3">
								<span>주문 상품</span>
							</div>
						</div>
						<c:choose>
							<c:when test="${not empty detail}">
								<c:forEach var="detail" items="${detail}" varStatus="status">
								<div class="card-line">
									<div class="card-body" data-num="${detail.g_order_id}">
										<div class="img-div">
											<c:if test="${not empty detail.g_image}">
												<img src="/dongsanStorage/goods/${detail.g_image}"class="file"/>
											</c:if>
										</div>
										<div class="title-div">
											<a class="card-title" class="goDetail">
												<span class="span-state">${detail.g_order_state}</span>
												<span class="span-gname">${detail.g_name}</span>
											</a>
											<p class="title-price">
												<fmt:formatNumber type="number" value="${detail.g_price}" pattern="#,##0" />원
											</p>
											<p class="card-count ">주문 수량 : ${detail.g_count}개</p>
											<p class="card-date">구매일 : ${detail.g_order_date}</p>
										</div>
									</div>
								</div>
								</c:forEach>
								 <c:set var="firstDetail" value="${detail[0]}" />
							</c:when>
							<c:otherwise>
								<div>
									<p class="text-center">결제된 상품이 존재하지 않습니다.</p>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<div class="card w-70 m-3">
					<div class="ms-4 me-4 p-3">
						<span class="top-color">Detail</span>
						<span class="fs-10"> &nbsp;&nbsp;<span class="span-state fs-10">주문번호</span>${firstDetail.g_order_id}
						</span>
					</div>
					<div class="card-line-bottom"></div>
					<div class=" ms-4 me-4 p-3">
						<h5>배송지 정보</h5>
						<p><label>수령인&nbsp;</label>${firstDetail.member_name}</p>
						<p><label>우편번호&nbsp;&nbsp;</label>${firstDetail.member_addr1}</p>
						<p><label>주소&nbsp;&nbsp;</label>${firstDetail.member_addr2}&nbsp;&nbsp;${firstDetail.member_addr3}</p>
					</div>
					
					
				</div>
			</div>
			<a onclick="goodsList();" type="button" class="button btnFloat btnLightBlue ms-5"></a> 
			
	</body>
</html>