<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>

<link rel="stylesheet" href="/resources/include/css/commonList.css">

		<style type="text/css">
		.file{
			  width: 100px;
			  height: 100px;
		}
		.benerFile{
			width: 1000px;
			height: 200px;
		}
		</style>
		<script type="text/javascript">
			$(function(){
				
				$(".goUpdate").click(function(){
					main_event_no = $(this).parent().attr("data-num");
					$("#main_event_no").val(main_event_no);
					
					main_event_title = $(this).text();
					$("#main_event_title").val(main_event_title);
					
					main_event_image = $(this).closest("tr").find(".file").attr("src");
					$("#main_event_image").val(main_event_image);
					console.log("main_event_image=" + main_event_image);
					
					$("#updateForm").attr({
						"method" : "post",
						"action" : "/admin/mainEventUpdateForm"
					});
					$("#updateForm").submit();
				});
				
				
				$(".benerGo").click(function(){
					main_bener_no = $(this).parent().attr("data-num");
					$("#main_bener_no").val(main_bener_no);
					
					main_event_bener_image = $(this).children().attr("src");
					$("#main_event_bener_image").val(main_event_bener_image);
					
					console.log("main_event_bener_image=" + main_event_bener_image);
					
					$("#benerupdateForm").attr({
						"method" : "post",
						"action" : "/admin/benerupdateForm"
					});
					$("#benerupdateForm").submit();
				});
			});
		</script>
	</head>
	<body>
	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	<main id="main" class="main">
		<form name="updateForm" id="updateForm">
				<input type="hidden" name="main_event_no" id="main_event_no" /> 
				<input type="hidden" name="main_event_title" id="main_event_title" />
				<input type="hidden" name="main_event_image" id="main_event_image" />
			</form>
		<div class="pagetitle">
			<h1>이벤트&배너 수정</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<h3> 이벤트 수정 </h3>
				<table summary="게시판 리스트" class="table table-hover admin_table">
					<thead>
						<tr>
							<th data-value="b_num" class="order text-center col-md-1">No</th>
							<th class="col-md-2 text-center">이벤트 제목</th>
							<th class="col-md-2 text-center">이벤트 이미지</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty mainList}">
								<c:forEach var="mainList" items="${mainList}" varStatus="status">
									<tr class="text-center" data-num="${mainList.main_event_no}">
										<td>${mainList.main_event_no}번이미지</td>
										<td class="goUpdate">${mainList.main_event_title}</td>
										<td class="rideListImg">${mainList.main_event_image}"</td>
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
				<br/>
				<br/>
				<br/>
				<br/>
				<h3> 배너 수정 </h3>

				<form name="benerupdateForm" id="benerupdateForm">
				<input type="hidden" name="main_bener_no" id="main_bener_no" /> 
				<input type="hidden" name="main_event_bener_image" id="main_event_bener_image" />
				</form>
				<table summary="게시판 리스트" class="table table-hover admin_table">
					<thead>
						<tr>
							<th data-value="b_num" class="order text-center col-md-1">No</th>
							<th class="col-md-2 text-center">이벤트 배너</th>
							
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty benerList}">
								<c:forEach var="benerList" items="${benerList}" varStatus="status">
									<tr class="text-center" data-num="${benerList.main_bener_no}">
										<td>${benerList.main_bener_no}번이미지</td>
										<td class="benerGo">${benerList.main_event_bener_image}</td>
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