<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page trimDirectiveWhitespaces="true"%>

<%@ include file="/WEB-INF/views/common/common.jspf"%>

<title>제휴카드 안내</title>

<link rel="stylesheet" type="text/css" href="/resources/include/css/ticket/card.css" />

</head>
<body>
	<div class="container">
	<h3>제휴카드 안내</h3>
    <div class="row">
    	<c:choose>
    		<c:when test="${not empty cardInfo}">
    			<c:forEach var="card" items="${cardInfo}" varStatus="status">
				<div class="col-md-4 text-center" id="cardList">
					<div id="carddetail">
					<h4>${card.card_company}</h4>
					<div id="img_back">
						<c:if test="${not empty card.card_image}">
							<img src="/resources/images/card/${card.card_image}" id="card_img" class="file" />
						</c:if>
						<c:if test="${empty card.card_image}">
							<img src="/resources/images/card/maru2.jpg" id="card_img" />
						</c:if>
					</div>
						${card.card_name}&nbsp;
						<strong id="cardText">&nbsp;💰${card.card_discount}%&nbsp;</strong>
					</div>
				</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="text-center">
					등록된 게시물이 존재하지 않습니다.
				</div>
			</c:otherwise>
		</c:choose>
		
    </div>
	</div>
</body>
</html>