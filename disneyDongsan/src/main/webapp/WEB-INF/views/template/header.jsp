<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page trimDirectiveWhitespaces="true"%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
<link rel="stylesheet" href="/resources/include/css/header.css">

<script src="/resources/include/jquery/jquery-3.7.1.min.js"></script>
<script src="/resources/include/jquery/jquery.test.js"></script>

</head>
<body>
	<header>
	   <div id="container">
	      <div class="row">
	         <div class="col"></div>
	         <div class="col-8 text-center">
	            <a href="/"><img src="/resources/img/disneyLogo5.png" height="80px"></a>
	         </div>
	         <div class="col">
	           <c:if test="${empty Member}">
                  <a class="nav-icon-user" href="/member/loginForm"><img src="/resources/img/user.png" height="20px"></a> 
               </c:if>
               <c:if test="${not empty Member}">
                  <a class="nav-icon-user" href="/mypage/mypage"><img src="/resources/img/user.png" height="20px"></a> 
               </c:if>
               
               <a class="nav-icon" href="/goods/basketList"><img src="/resources/img/basket.png" height="20px"></a>
               
               <c:if test="${not empty Member}">
                  <a class="nav-icon-logout" href="/member/logout"><img src="/resources/img/logout.png" height="20px"></a>
               </c:if>
	         </div>
	      </div>
	      
	   </div>
	   <div class="header">
	      <div class="topMenu">
	         <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0 menu01">
	            <li><span>&nbsp;</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>
	            <li><span>티켓예매</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="/ticket/reserveTicket" class="nav-link px-2">예매하기</a></li>
	                  <li class="nop"><a href="/ticket/cardInfo" class="nav-link px-2">제휴카드</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>
	            <li><span>굿즈몰</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="/goods/goodsList" class="nav-link px-2">굿즈판매</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>               
	            <li><span>시설안내</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="/route/routeList" class="nav-link px-2">추천동선</a></li>
	                  <li class="nop"><a href="/facilityInfo/rideList" class="nav-link px-2">어트랙션</a></li>
	                  <li class="nop"><a href="/facilityInfo/restaurantList" class="nav-link px-2">레스토랑</a></li>
	               </ul></li>
	            <li><span>이벤트</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="/event/eventView" class="nav-link px-2">이벤트</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>
	            <li><span>이용정보</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="/facilityInfo/waytocome" class="nav-link px-2">오시는길</a></li>
	                  <li class="nop"><a href="/facilityInfo/operatingHours" class="nav-link px-2">이용시간</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>
	            <li><span>고객센터</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="/mypage/userQAList" class="nav-link px-2">1:1문의</a></li>
	                  <li class="nop"><a href="/notice/noticeView" class="nav-link px-2">공지사항</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>
	            <li><span>&nbsp;</span>
	               <ul class="dept01">
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	                  <li class="nop"><a href="#" class="nav-link px-2">&nbsp;</a></li>
	               </ul></li>
	         </ul>
	      </div>
	   </div>
	</header>

</body>
</html>
