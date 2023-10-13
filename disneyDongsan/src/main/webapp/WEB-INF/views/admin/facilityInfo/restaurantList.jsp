<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>

<link rel="stylesheet" href="../resources/include/css/commonList.css">

 		<style type="text/css">
			.restaurant{
			  text-align: center;
			  margin: auto;
			  width: 1000px;
			}
			
			.restImage img{
			  width: 170px;
			  height: 120px;
			  
			}
			.required{color:red;}
			textarea{resize:none;}
			.text-center{text-align: center;}
			.text-left{text-align: left;}
			.text-right{text-align: right;}
			
			
		</style>
		<script type="text/javascript">
			$(function(){
				//검색 후 검색 대상과 검색 단어 출력
				let word="<c:out value='${restaurantVO.keyword}' />";
				let value="";
				if(word!=""){
					$("#keyword").val("<c:out value='${restaurantVO.keyword}' />");
					$("#search").val("<c:out value='${restaurantVO.search}' />");
					
						//:contains()는 텍스트를 포함한 요소반환
						if($("#search").val() == 'restTitle') value = "#list tr td.goUpdate";
						console.log($(value+":contains('"+word+"')").html());
						
						//$("#list tr td.doDetail:contains('노력')").html()=><span class='required'>노력</span>에 대한 명언
						$(value+":contains('"+word+"')").each(function(){
							let regex = new RegExp(word,'gi');
							$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
						});				
				}
				//입력 양식 enter 제거
				$("#keyword").bind("keydown", function(event){
					if(event.keyCode == 13){
						event.preventDefault();
					}
				});
				
				//검색 대상이 변경될 때마다 처리 이벤트
				$("#search").change(function(){
					if($("#search").val() == "all"){
						$("#keyword").val("전체 목록 조회 합니다.");
						$("#keyword").attr("readonly", true);
					}else if($("#search").val() !="all"){
						$("#keyword").val("");
						$("#keyword").focus();
						$("#keyword").removeAttr("readonly");
					}
				});
				
				//검색 버튼 클릭 시 처리 이벤트
				$("#searchData").click(function(){
					if($("#search").val() !="all"){ //제목/내용/작성자 선택시 검색어 유효성 체크
						if(!chkData("#keyword", "검색어를")) return;
					}
					$("#pageNum").val(1);//페이지 초기화
					goPage();
				});
				
				
				
				//글쓰기 버튼 클릭 시 처리 이벤트
				$("#InsertBtn").click(function() {
					//console.log("글쓰기 버튼 클릭");//콘솔에 출력하는 이유는 이벤트가 정상적으로 실행되는지 확인하기 위해서
					//location.href = "/rideInsertForm";
					location.href = "/admin/restaurantInsertForm";
				});
				//제목 클릭시 수정 페이지 이동을 위한 처리 이벤트
				$(".goUpdate").click(function(){
					let restNo = $(this).parents("tr").attr("data-num");
					$("#restNo").val(restNo);
					goUpdatePage();
		
				});
				//이미지 클릭시 수정 페이지 이동을 위한 처리 이벤트
				$(".restImage").click(function(){
					let restNo = $(this).parents("tr").attr("data-num");
					$("#restNo").val(restNo);
					goUpdatePage();
				});
				
				$(".page-item a").click(function(e){
					e.preventDefault();
					$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				})
		         /* 삭제 버튼 클릭 시 처리 이벤트 */
		         $(".delete_btn").click(function(){
		        	 if(confirm("정말 삭제하시겠습니까?")){
			        	let restNo = $(this).parents("tr").attr("data-num");
						$("#restNo").val(restNo);
						let restImage = $(this).parents("tr").find("#imgV").val();
						$("#restImage").val(restImage); 
						//console.log(rideImage);
							
						$("#updateForm").attr({
							"method": "post",
							"enctype":"multipart/form-data",
							"action": "/admin/restaurantDelete"
						});
						$("#updateForm").submit();
		        	 }
		         });
			});
			
			//검색을 위한 실질적인 처리 함수
			function goPage(){
				if($("#search").val()=="all"){
					$("#keyword").val("");
				}
				$("#f_search").attr({
					"method":"get",
					"action":"/admin/restaurantList"
				});
				$("#f_search").submit();
			}
			//수정 페이지로 넘어가는 함수
			function goUpdatePage(){
				//수정 페이지로 이동하기 위한 form 추가(id: updateForm)
				$("#updateForm").attr({
					"method": "get",
					"action": "/admin/restaurantUpdateForm"
				});
				$("#updateForm").submit();
			}

		</script>		

	</head>
	<body>
	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>레스토랑 관리</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<form name="updateForm" id="updateForm">
				<input type="hidden" name="restNo" id="restNo" /> <input
					type="hidden" name="restImage" id="restImage" />
			</form>
			<%-- ========================검색 폼 태그================================== --%>
 			<div id="boardSearch" class="search_wrap">
				<form id="f_search" name="f_search" class="form-inline">
					<input type="hidden" name="pageNum" id="pageNum"
						value="${pageMaker.cvo.pageNum}" /> <input type="hidden"
						name="amount" id="amount" value="${pageMaker.cvo.amount}" />
					<div class="search_input">
						<label>검색조건</label> <select id="search" name="search" class="form-control">
							<option value="all">전체조회</option>
							<option value="restTitle">기구이름</option>
						</select> <input type="text" name=keyword id="keyword" value="검색어를 입력하세요"
							class="form-control" />
						<button type="button" id="searchData" class="btn search_btn">검색</button>
						<button type="button" id="InsertBtn" class='btn insert_btn'>추가</button>
	
					</div>
				</form>
			</div>
			<%-- ======================== 리스트 시작 ============================== --%>
			<div id="boardList" class="table-heigh">
				<table summary="게시판 리스트" class="table table-hover admin_table">
					<thead>
						<tr>
							<th data-value="b_num" class="order text-center col-md-1">기구번호</th>
							<th class="col-md-2 text-center">레스토랑제목</th>
							<th class="col-md-2 text-center">이미지</th>
							<th class="col-md-2 text-center">서브제목</th>
							<th class="col-md-4 text-center">글내용</th>
							<th class="col-md-1 text-center">삭제여부</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty restaurantList}">
								<c:forEach var="rest" items="${restaurantList}" varStatus="status">
									<tr class="text-center" data-num="${rest.restNo}">
										<td><c:out value="${(pageMaker.cvo.pageNum - 1) * pageMaker.cvo.amount + status.index +1}"/></td>
										<%-- <td>${rest.restNo}</td> --%>
										<td class="goUpdate">${rest.restTitle}</td>
										<td class="restImage"><c:if test="${not empty rest.restImage}">
												<img src="/dongsanStorage/facilityInfo/${rest.restImage}"
													alt="/" />
												<input type="hidden" id="imgV" value="${rest.restImage}" />
											</c:if>
										</td>
										<td class="text-center">${rest.restSubTitle}</td>
										<td class="text-left">${rest.restContent}</td>
										<td class="text-center"><input type="button"
											class="btn delete_btn" value="X" /></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="5" class="text-center">등록된 게시물이 존재하지 않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<%--=================== 리스트 종료 ================ --%>
	
			<%--=================== 페이징 출력 시작 ================ --%>
			<div class="text-center">
				<ul class="pagination justify-content-center">
					<!-- 이전 바로가기 10개 존재 여부를 prew 팔드의 값으로 확인 -->
					<c:if test="${pageMaker.prev}">
						<li class="page-item previous"><a class="page-link" 
							href="${pageMaker.startPage -1}">Previous</a></li>
					</c:if>
	
					<!-- 바로가기 번호 출력 -->
					<c:forEach var="num" begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}">
						<li
							class="page-item ${pageMaker.cvo.pageNum == num ? 'active':''}">
							<a class="page-link" href="${num}">${num}</a>
						</li>
					</c:forEach>
	
					<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인. -->
					<c:if test="${pageMaker.next}">
						<li class="page-item next"><a class="page-link" 
							href="${pageMaker.endPage +1}">Next</a></li>
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