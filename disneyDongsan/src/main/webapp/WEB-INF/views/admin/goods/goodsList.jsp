<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>

<link rel="stylesheet" href="../resources/include/css/commonList.css">

<script type="text/javascript">
	$(function(){
		
		let word="<c:out value='${goodsVO.keyword}'/>";
		let value="";
		
		if(word!=""){
			$("#keyword").val("<c:out value='${goodsVO.keyword}' />");
			$("#search").val("<c:out value='${goodsVO.search}' />");
			
			if($("#search").val()!='g_detail'){
				//:contains() 는 특정 텍스트를 포함한 요소반환
				if($("#search").val()=='g_name') value = "#list tr td.goDetail";
				console.log($(value+":contains('"+word+"')").html());
				
				$(value+":contains('"+word+"')").each(function(){
					let regex = new RegExp(word,'gi');
					$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
				});
			}
		}
		
		/* 입력 양식 enter 제거 */
		$("#keyword").bind("keydown", function(event){
			if (event.keyCode == 13){
				event.preventDefault();
			}
		});
		/* 검색 대상이 변경될 때마다 처리 이벤트 */
		$("#search").change(function(){
			if($("#search").val()=="all"){
				$("#keyword").val("전체 목록 조회합니다.");
			}else if($("#search").val()!="all"){
				$("#keyword").val("");
				$("#keyword").focus();
			}
		});
		
		/* 검색 버튼 클릭 시 처리 이벤트 */
		$(".search_btn").click(function(){
			if(!chkData("#keyword","검색어를")) return;
			$("#pageNum").val(1);
			goPage();
		});
			
		/* 글쓰기 버튼 클릭 시 처리 이벤트 */
		$(".insert_btn").click(function(){
			location.href="/admin/goodsInsertForm";
		});
		
		/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */
		$(".goDetail").click(function(){
			let g_id = $(this).parents("tr").attr("data-num");
			$("#g_id").val(g_id);
			console.log("글번호 : "+g_id);
			// 상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
			$("#detailForm").attr({
				"method":"get",
				"action":"/admin/goodsDetail"
			});
			$("#detailForm").submit();
		});
		
		$(".page-item a").click(function(e){
			e.preventDefault();
			$("#searchForm").find("input[name='pageNum']").val($(this).attr("href"));
			goPage();
		});
		
	});	//$ 함수 종료문
	
	function goPage(){
		if($("#search").val()=="all"){
			$("#keyword").val("");
		}
		
		$("#searchForm").attr({
			"method":"get",
			"action":"/admin/goodsList"
		});
		$("#searchForm").submit();
	}

</script>
</head>
<body>
 	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	
	<main id="main" class="main">
		<form id="detailForm">
			<input type="hidden" id="g_id" name="g_id" />
		</form>
		<form id="moveForm" action="/admin/goodsList" method="get" >
	 		<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
			<input type="hidden" name="keyword" value="${pageMaker.cvo.keyword}">
	    </form>
		<div class="pagetitle">
			<h1>굿즈 목록</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
					
						<!-- 검색 영역 -->
					    <div class="search_wrap">
						    <form id="searchForm" class="searchForm" action="/admin/goodsList" method="get">
							    <div class="search_input">
									<select id="search" name="search" class="form-control">
										<option value="all">전체 조회</option>
										<option value="g_name">제목</option>
										<option value="g_detail">상품설명</option>
									</select>
								    <input type="text" name="keyword" id="keyword" placeholder="검색어를 입력해 주세요" class="form-control" value='<c:out value="${pageMaker.cvo.keyword}"></c:out>'>
								    <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cvo.pageNum }"></c:out>'>
								    <input type="hidden" name="amount" value='${pageMaker.cvo.amount}'>
								    <input type="hidden" name="type" value="G">
								    <button type="button" class='btn search_btn'>검 색</button>
								    <button  type="button" class='btn insert_btn'>등 록</button>                				
							    </div>
						    </form>
					    </div>
					
					
					
					
					
						<div class="card-body">
							<table class="table table-hover admin_table">
		                    		<thead>
		                    			<tr>
											<td class="th_column_1">상품 번호</td>
											<td class="th_column_2">상품 이미지</td>
		                    				<td class="th_column_3">상품 이름</td>
		                    				<td class="th_column_4">상품 설명</td>
		                    				<td class="th_column_5">가격</td>
		                    				<td class="th_column_6">등록날짜</td>
		                    			</tr>
		                    		</thead>	
							        <tbody id="list" class="table-striped" >
										<!-- 데이터 출력 -->
										<c:choose>
											<c:when test="${not empty goodsList}">
												<c:forEach var="goods" items="${goodsList}" varStatus="status">
													<tr class="text-center" data-num="${goods.g_id}">
														<td>${goods.g_id}</td>
														<td class="goDetail">
															<c:if test="${not empty goods.g_image}">
																<img src="/dongsanStorage/goods/${goods.g_image}" class="file"/>
															</c:if>
															<c:if test="${empty goods.g_image}">
																<img src="/resources/images/noimage.png" />
															</c:if>
														</td>
														<td class="goDetail">${goods.g_name}</td>
														<td class="goDetail">${goods.g_detail}</td>
														<td>${goods.g_price}</td>
														<td>${goods.g_date}</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="5" class="table_empty">등록된 게시글이 존재하지 않습니다.</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
		                    	</table>
						
	                	
	                	<!-- 페이지 이름 인터페이스 영역 -->
	                	<div class="pageMaker_wrap">
	                		<ul class="pagination justify-content-center">
	                			
	                			<!-- 이전 버튼 -->
	                			<c:if test="${pageMaker.prev }">
	                				<li class="page-item prev">
	                					<a class="page-link" href="${pageMaker.startPage -1}">이전</a>
	                				</li>
	                			</c:if>
	                			
	                			<!-- 페이지 번호 -->
	                			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
	                				<li class="page-item ${pageMaker.cvo.pageNum == num ? 'active':''}">
	                					<a class="page-link" href="${num}">${num}</a>
	                				</li>	
	                			</c:forEach>
	                		
		                    	<!-- 다음 버튼 -->
		                    	<c:if test="${pageMaker.next}">
		                    		<li class="page-item next">
		                    			<a class="page-link" href="${pageMaker.endPage + 1 }">다음</a>
		                    		</li>
		                    	</c:if>
		                    </ul>
	                	</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
        
 <%@ include file="/WEB-INF/views/admin-template/footer.jsp"%>

	<script type="text/javascript"
		src="/resources/include/js/jquery-3.7.0.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script
		src="/resources/include/assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script
		src="/resources/include/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/include/assets/vendor/chart.js/chart.umd.js"></script>
	<script src="/resources/include/assets/vendor/echarts/echarts.min.js"></script>
	<script src="/resources/include/assets/vendor/quill/quill.min.js"></script>
	<script
		src="/resources/include/assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="/resources/include/assets/vendor/tinymce/tinymce.min.js"></script>
	<script
		src="/resources/include/assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="/resources/include/assets/js/main.js"></script>

</body>
</html>