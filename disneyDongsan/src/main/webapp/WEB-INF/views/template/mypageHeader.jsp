<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page trimDirectiveWhitespaces="true"%>
</head>
<body>
	<div id="container">
		<div class="row">
			<div class="col"></div>
			<div class="col-8 text-center">
				<a href="/"><img src="/resources/img/disneyLogo5.png"
					height="80px"></a>
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
</body>
</html>