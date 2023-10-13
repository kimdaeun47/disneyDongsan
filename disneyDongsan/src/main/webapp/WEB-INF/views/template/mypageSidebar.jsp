<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<script type="text/javascript">
	$(function() {
		$(".nav-link").click(function() {
			console.log("click");
			$(".nav-link").removeClass("active");
			$(this).addClass("color");
		});
	});
</script>
</head>
	<body>
		<div class="mypage_side col-3">
				<div class="d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary"
					style="width: 280px; height: 100%;">
					<h4 class="fw-bold text-center mt-2">마이페이지</h4>
					<hr>
					<ul class="nav nav-pills flex-column mb-auto">
					
						<li class="nav-item">
							<a href="/member/updateMemberInfoForm" class="nav-link link-body-emphasis" aria-current="page"> 
							<svg class="bi pe-none me-2" width="16" height="16"></svg>나의 정보 수정</a></li>
									
						<li><a href="/mypage/userTicketList" class="nav-link link-body-emphasis"> 
							<svg class="bi pe-none me-2" width="16" height="16"></svg>티켓 예매내역</a></li>
									
						<li><a href="/mypage/userGoodsList" class="nav-link link-body-emphasis"> 
							<svg class="bi pe-none me-2" width="16" height="16"></svg>굿즈 주문내역</a></li>
									
						<li><a href="/mypage/userReviewList" class="nav-link link-body-emphasis"> 
							<svg class="bi pe-none me-2" width="16" height="16"></svg>굿즈 리뷰</a></li>
									
						<li><a href="/mypage/userQAList" class="nav-link link-body-emphasis"> 
							<svg class="bi pe-none me-2" width="16" height="16"></svg>1:1문의 내역</a></li>

						<li><a href="/member/withdrawalForm" class="nav-link link-body-emphasis"> 
							<svg class="bi pe-none me-2" width="16" height="16"></svg>회원 탈퇴</a></li>
					</ul>
					
				</div>
			</div>
	</body>
</html>