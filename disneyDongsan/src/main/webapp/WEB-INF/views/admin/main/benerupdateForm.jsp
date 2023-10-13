<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>
<link rel="stylesheet" href="/resources/include/css/commonInsert.css"/>
		<script type="text/javascript">
			$(function(){
				let errorMsg = "${errorMsg}";
				if(errorMsg != '') {
					alert(errorMsg);
					errorMsg = '';
				};
				
				/*목록 클릭 처리 이벤트*/
				$("#mainEventListBtn").click(function(){
					location.href="/admin/mainList";
				});
				
				/*리셋 클릭 처리 이벤트*/
				$("#benerCancelBtn").click(function(){
					$("#bener_updateForm").each(function(){
						this.reset();
					});
				});
				
				$("#benerEventUpdateBtn").click(function(){
						if($("#file").val()!=""){//업로드할 이미지 파일이 존재한다면
							//확장자가 png, jpg, gif 외 파일을 업로드 할 수 없습니다.유효성 체크
							if(!chkFile($("#file"))) {
								return;//이미지 파일만 업로드 가능.
							}
						
						$("#bener_updateForm").attr({
							"method":"post",
							"enctype":"multipart/form-data",
							"action":"/admin/benerEventUpdate"
						});
							$("#bener_updateForm").submit();
						}
				});
			});
		</script>
	</head>
	<body>
	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>메인 이벤트 수정</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="contentTB text-center">									
								<div class="contentBtn text-right">
									<button type="button" id="benerEventUpdateBtn" class="btn sty_btn">수정</button>
									<button type="button" id="benerCancelBtn" class="btn sty_btn">취소</button>
									<button type="button" id="mainEventListBtn" class="btn sty_btn">목록</button>
								</div>
								<form id="bener_updateForm" name="bener_updateForm">
									<input type="hidden" id="main_bener_no" name="main_bener_no" value="${benerData.main_bener_no}" />
									<input type="hidden" id="main_event_bener_image" name="main_event_bener_image" value="${benerData.main_event_bener_image}" />
									
									<table class="table table-bordered">
										<colgroup>
											<col width="20%" />
											<col width="80%" />
										</colgroup>
										<tbody>
											<tr>
												<td class="col-md-3">No</td>
												<td class="text-left col-md-3">${benerData.main_bener_no}</td>
											</tr>
											<tr>
												<td>이벤트 이미지</td>
												<td class="text-left">
													<input type="file" name="file" id="file" />
												</td>
											</tr>
											
										</tbody>
									</table>
								</form>		
							</div>
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