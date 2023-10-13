<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title><tiles:getAsString name="title" /></title>
<link rel="stylesheet" href="/resources/include/css/main.css" />
<link href="/resources/include/css/styles.css" rel="stylesheet" />
<link rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/include/css/carousel.css">
<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		let infoMsg = "${infoMsg}";
		if (infoMsg != '') {
			alert(infoMsg);
			infoMsg = '';
		};

		
		$("#goAttr").click(function(){
			location.href="/facilityInfo/rideList";
		});
	});
</script>
<script src="/resources/include/dist/js/bootstrap.bundle.min.js"></script>
<script defer src="/resources/include/js/carousel.js"></script>
</head>

<body>

	<div>
		<!-- 헤더 -->
		<div class="header">
			<tiles:insertAttribute name="header" />
		</div>


		<!-- 배너 -->
		<div id="myCarousel" class="carousel slide mb-6"
			data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">

				<c:choose>
					<c:when test="${not empty benerList}">
						<c:forEach var="benerList" items="${benerList}" varStatus="status">
							<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
								<a href="/page${status.index + 1}"> <img
									src="/dongsanStorage/benerEvent/${benerList.main_event_bener_image}"
									width="100%" height="500px" />
								</a>

								<div class="container"></div>
							</div>

						</c:forEach>
					</c:when>
				</c:choose>
			</div>

			<button class="carousel-control-prev" type="button"
				data-bs-target="#myCarousel" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#myCarousel" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>


		<!-- 사용자 정의 클래스보다 부트스트랩 클래스의 우선 순위가 더 높다. !important를 이용하여 우선순위 높일 수 있다.(남용 금지) -->
		<!--  바디  -->
		<div class="peDiv">
			<div class='bodyDiv'>
				<div class="division-line">
					<h2>
						다양한 패키지 및 이벤트 <strong>정보를 한눈에!</strong>
					</h2>
				</div>
				<div class="row m-0 p-0">
					<c:choose>
						<c:when test="${not empty mainList}">
							<c:forEach var="mainList" items="${mainList}" varStatus="status">

								<div class="card col-4 m-4 w-25 h-10 p-0 ">
									<img
										src="/dongsanStorage/mainEvent/${mainList.main_event_image}"
										class=" float-start" />
									<div class="card-body">
										<h5 class="bi bi-collection">${mainList.main_event_title}</h5>
									</div>
								</div>

							</c:forEach>
						</c:when>
					</c:choose>
				</div>

			</div>
		</div>

		<div class="caroselBody">
			<p style="font-size: 40px; color: white;">
				<label style="font-weight: border">재미있고 즐거운 <strong>다양한
						어트랙션!</strong></label>
			</p>
			<br />
			<div class="carosel"></div>
			<div>
				<button type="button" id="goAttr" class="goAttr btn w-20">더 많은 어트랙션 보기</button>
			</div>
		</div>

		<!-- 풋터 -->
		<div class="container">
			<footer
				class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
				<tiles:insertAttribute name="footer" />
			</footer>
		</div>
	</div>
</body>
</html>