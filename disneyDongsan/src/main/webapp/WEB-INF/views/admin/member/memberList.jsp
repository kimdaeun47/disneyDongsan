<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>

<link rel="stylesheet" href="/resources/include/css/commonList.css">

<script>
	$(function() {
		/* 페이지 버튼 클릭 시 이벤트*/
		$(".page-item a").click(function(e) {
			e.preventDefault();
			$("#m_search").find("input[name='pageNum']").val($(this).attr("href"));
			goPage();
		});
	});

	/* 검색을 위한 실질적인 처리 함수 */
	function goPage() {
		$("#m_search").attr({
			"method" : "get",
			"action" : "/admin/member/memberList"
		});
		$("#m_search").submit();
	}
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>회원 리스트</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<form id="m_search" name="m_search">
								<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}"> 
								<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}">
							</form>
							<table class="table table-hover admin_table">
								<thead>
									<tr>
										<th scope="col" class="text-center">번호</th>
										<th scope="col" class="text-center">아이디</th>
										<th scope="col" class="text-center">이름</th>
										<th scope="col" class="text-center">전화번호</th>
										<th scope="col" class="text-center">이메일</th>
										<th scope="col" class="text-center">주소</th>
										<th scope="col" class="text-center">가입일</th>
										<th scope="col" class="text-center">탈퇴</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty memberList}">
											<c:forEach var="member" items="${memberList}" varStatus="status">
												<tr class="text-center" data-num="${member.memberNo}">
													<td scope="row" class="text-center">${member.memberNo}</td>
													<td class="text-center">${member.memberId}</td>
													<td class="text-center">${member.memberName}</td>
													<td class="text-center">${member.memberPhone}</td>
													<td class="text-center">${member.memberEmail}</td>
													<td class="text-center">(${member.memberAddr1})
														${member.memberAddr2}&nbsp; ${member.memberAddr3}</td>
													<td class="text-center">${member.memberRegdate}</td>
													<td class="text-center">${member.memberState}</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="5" class="tac text-center">등록된 회원 정보가 존재하지
													않습니다.</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>

							<%-- ===================== 페이징 출력 시작 ===================== --%>
							<div class="text-center">
								<ul class="pagination justify-content-center">
									<c:if test="${pageMaker.prev}">
										<li class="page-item previous">
											<a class="page-link" href="${pageMaker.startPage - 1}">Previous</a>
										</li>
									</c:if>

									<!-- 바로가기 번호 출력 -->
									<c:forEach var="num" begin="${pageMaker.startPage}"
										end="${pageMaker.endPage}">
										<li class="page-item ${pageMaker.cvo.pageNum == num ? 'active' : ''}">
											<a class="page-link" href="${num}">${num}</a>
										</li>
									</c:forEach>

									<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인 -->
									<c:if test="${pageMaker.next}">
										<li class="page-item next">
											<a class="page-link" href="${pageMaker.endPage + 1}">Next</a>
										</li>
									</c:if>
								</ul>
							</div>
							<%-- ===================== 페이징 출력 종료 ===================== --%>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<%@ include file="/WEB-INF/views/admin-template/footer.jsp"%>

	<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script src="/resources/include/assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script src="/resources/include/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/include/assets/vendor/chart.js/chart.umd.js"></script>
	<script src="/resources/include/assets/vendor/echarts/echarts.min.js"></script>
	<script src="/resources/include/assets/vendor/quill/quill.min.js"></script>
	<script src="/resources/include/assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="/resources/include/assets/vendor/tinymce/tinymce.min.js"></script>
	<script src="/resources/include/assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="/resources/include/assets/js/main.js"></script>
</body>
</html>