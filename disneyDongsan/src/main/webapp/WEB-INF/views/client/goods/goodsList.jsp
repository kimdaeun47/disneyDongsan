<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>

	<link rel="stylesheet" href="../resources/include/css/goods/client/goodsList.css">

		<script type="text/javascript">
			$(function(){
				
				let word="<c:out value='${goodsVO.keyword}'/>";
				let value="";
				
				if(word!=""){
					$("#keyword").val("<c:out value='${goodsVO.keyword}' />");
					$("#search").val("<c:out value='${goodsVO.search}' />");
					
					if($("#search").val()!='g_detail'){
						//:contains() 는 특정 텍스트를 포함한 요소반환
						if($("#search").val()=='g_name') value = "#list .item-card";
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
				
				/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */
				$(".item-card").click(function(){
					let g_id = $(this).parents("div").attr("data-num");
					$("#g_id").val(g_id);
					console.log("글번호 : "+g_id);
					// 상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
					$("#detailForm").attr({
						"method":"get",
						"action":"/goods/goodsDetail"
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
					"action":"/goods/goodsList"
				});
				$("#searchForm").submit();
			}
			
		</script>
	</head>
	<body>
	
			<article>
				<div class="goods_content_wrap">
					<form id="detailForm">
						<input type="hidden" id="g_id" name="g_id" />
					</form>
		            <div id="article">
		            	<h3>굿즈 판매 상품</h3>
		            </div>
		            	<div class="search_wrap">
	                		<form id="searchForm" class="searchForm" action="/goods/goodsList" method="get">
	                			<div class="search_input">
		                			<select id="search" name="search" class="form-control">
										<option value="all">전체</option>
										<option value="g_name">제목</option>
										<option value="g_detail">상품설명</option>
									</select>
	                    			<input type="text" name="keyword" id="keyword" value='<c:out value="${pageMaker.cvo.keyword}"></c:out>'>
	                    			<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cvo.pageNum }"></c:out>'>
	                    			<input type="hidden" name="amount" value='${pageMaker.cvo.amount}'>
	                    			<input type="hidden" name="type" value="G">
	                    			<button type="button" class='btn search_btn'>검 색</button>       				
	                			</div>
	                		</form>
	                	</div>
		                
		            <div id="list" class="table-striped" >
			            <div id="item-list">
									<!-- 데이터 출력 -->
							<c:choose>
								<c:when test="${not empty goodsList}">
									<c:forEach var="goods" items="${goodsList}" varStatus="status">
										<div class="text-center" data-num="${goods.g_id}">
															
											<div class="item-card">
												<div class="item-img">
													<c:if test="${not empty goods.g_image}">
														<img src="/dongsanStorage/goods/${goods.g_image}" class="file"/>
													</c:if>
													<c:if test="${empty goods.g_image}">
														<img src="/resources/images/noimage.png" class="file"/>
													</c:if>
												</div>
												<div class="item-contents">
													<div class="item-name">${goods.g_name}</div>
													<div class="item-price">${goods.g_price} 원</div>
												</div>
											</div>
																
										</div>
									</c:forEach>
								</c:when>
							</c:choose>
						</div>
					</div>
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
	                	
	                	<form id="moveForm" action="/admin/goodsList" method="get" >
	 						<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
							<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
							<input type="hidden" name="keyword" value="${pageMaker.cvo.keyword}">
	                	</form>
	            </div>  
            </article>
            
	</body>
</html>