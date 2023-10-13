<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page trimDirectiveWhitespaces="true"%>

<%@ include file="/WEB-INF/views/common/common.jspf"%>

<title>티켓 예매하기</title>

<link rel="shortcut icon" href="/resources/images/icon.png" />
<link rel="apple-touch-icon" href="/resources/images/icon.png" />

<link rel="stylesheet" type="text/css" href="/resources/include/css/ticket/ticket.css" />

<script type="text/javascript">
	$(function() {
		/* 종일권 이동 */
		$("#to_alldayTicketView").click(function() {
			location.href = "/ticket/allDayTicketView";
		});
		/* 오후권 이동 */
		$("#to_afternoonTicketView").click(function() {
			location.href = "/ticket/afternoonTicketView";
		});
		/* 패키지 이동 */
		$("#to_packageTicketView").click(function() {
			location.href = "/ticket/packageTicketView";
		});
	});
</script>

</head>
<body>
	<div class="container">
			<div class="row">
				
					<div id="to_alldayTicketView" class="col-md-4 text-center toTicket">
						<div class="toTicketdiv">
						<input type="image" src="/resources/images/day.jpg" id="toTicketimg" alt="놀이공원종일권" />
						<h4>종일권 예매하기</h4>
						</div>
					</div>
					
					<div id="to_afternoonTicketView" class="col-md-4 text-center toTicket">
						<div class="toTicketdiv">
						<input type="image" src="/resources/images/after.jpg" id="toTicketimg" alt="놀이공원오후권" />
						<h4>오후권 예매하기</h4>
						</div>
					</div>
					
					<div id="to_packageTicketView" class="col-md-4 text-center toTicket">
						<div class="toTicketdiv">
						<input type="image" src="/resources/images/234.jpg" id="toTicketimg" alt="놀이공원패키지" />
						<h4>2/3/4인권 예매하기</h4>
						</div>
					</div>
				
			</div>
		</div>

	<!-- <div class="reserveTicket" id="reserveTicket">
		<div id="to_alldayTicketView" class="toTicket">
			<input type="image" src="/resources/images/day.jpg" id="toTicketimg" alt="놀이공원종일권" />
			<h2>종일권 예매하기</h2>
		</div>

		<div id="to_afternoonTicketView" class="toTicket">
			<input type="image" src="/resources/images/after.jpg" id="toTicketimg" alt="놀이공원오후권" />
			<h2>오후권 예매하기</h2>
		</div>

		<div id="to_packageTicketView" class="toTicket">
			<input type="image" src="/resources/images/234.jpg" id="toTicketimg" alt="놀이공원패키지" />
			<h2>2/3/4인권 예매하기</h2>
		</div>
	</div> -->
</body>
</html>