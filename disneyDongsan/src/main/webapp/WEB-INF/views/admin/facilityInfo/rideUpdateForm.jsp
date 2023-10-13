<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>
<link rel="stylesheet" href="/resources/include/css/commonInsert.css"/>
		<script type="text/javascript">
			$(function(){
				
				//수정 버튼 클릭 시 처리 이벤트
				$("#rideUpdateBtn").click(function(){
					//입력값 체크
					if(!chkData("#rideSubTitle", "서브제목을")) return;
					else if(!chkData("#rideContent", "작성할 내용을")) return;
					else{
						if($("#file").val()!=""){//업로드할 이미지 파일이 존재한다면
							//확장자가 png, jpg, gif 외 파일을 업로드 할 수 없습니다.유효성 체크
							if(!chkFile($("#file"))) return;//이미지 파일만 업로드 가능.
						}
						$("#f_updateForm").attr({
							"method":"post",
							"enctype":"multipart/form-data",
							"action":"/admin/rideUpdate"
						});
						$("#f_updateForm").submit();
					}
				});
				//취소 버튼 클릭 시 처리 이벤트
				$("#rideCancelBtn").click(function(){
					$("#f_updateForm").each(function(){
						this.reset();
					});
				});
				//목록 버튼 클릭 시 처리 이벤트
				$("#rideListBtn").click(function(){
					location.href="/admin/rideList";
				});
				//파일 버튼 클릭 시 처리 이벤트
				$("#file").click(function(){
					$("#fileNeme").text("");
				})
			});
		
		</script>
	</head>
	<body>
	
	 	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>어트랙션 수정</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="contentTB">
								<div class="contentBtn text-right">
									<button type="button" id="rideUpdateBtn" class="btn sty_btn">수정</button>
									<button type="button" id="rideCancelBtn" class="btn sty_btn">취소</button>
									<button type="button" id="rideListBtn" class="btn sty_btn">목록</button>
								</div>	
								<form id="f_updateForm" name="f_updateForm">
									<input type="hidden" id="rideNo" name="rideNo" value="${updateData.rideNo}" />
									<input type="hidden" id="rideImage" name="rideImage" value="${updateData.rideImage}" />
									<table class="table table-bordered">
										<colgroup>
											<col width="20%" />
											<col width="80%" />
										</colgroup>
										<tbody>
											<tr>
												<td class="text-center">기구이름</td>
												<td colspan="3" class="text-left" >${updateData.rideTitle}</td>
											</tr>
											<tr>
												<td class="text-center">서브제목</td>
												<td colspan="3" class="text-left">
													<input type="text" name="rideSubTitle" id="rideSubTitle" value="${updateData.rideSubTitle}" class="form-control" maxlength="66" />
												</td>
											</tr>
											<tr class="table-tr-height">
												<td class="text-center">내용</td>
												<td colspan="3" class="text-left">
													<textarea name="rideContent" id="rideContent" class="form-control" rows="8" maxlength="333">${updateData.rideContent}</textarea>
												</td>
											</tr>
											<tr>
												<td class="text-center">이미지 파일 첨부</td>
												<td class="text-left">
													<input type="file" name="file" id="file" /><br />
													<span id="fileNeme">${updateData.rideImage}</span>
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