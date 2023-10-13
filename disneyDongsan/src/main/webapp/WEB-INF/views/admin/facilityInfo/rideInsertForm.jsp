<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>
<link rel="stylesheet" href="/resources/include/css/commonInsert.css"/>
		<script type="text/javascript">
		$(function(){
			//저장 버튼 클릭 시 처리 이벤트
			$("#riedInsertBtn").click(function() {
				if(!chkData("#rideTitle", "기구이름을")) return;
				else if(!chkData("#rideSubTitle", "서브 제목을")) return;
				else if(!chkData("#rideContent", "작성할 내용을")) return;
				else if(!chkData("#file", "파일을")) return;
				else{
					if($("#file").val()!=""){//업로드할 이미지 파일이 존재한다면
						//확장자가 png, jpg, gif 외 파일을 업로드 할 수 없습니다.유효성 체크
						if(!chkFile($("#file"))) return;//이미지 파일만 업로드 가능.
					}
					// enctype 속성의 기본 값은 "application/x-www-form-urlcencoded". POST방식 폼 전송에 기본 값으로 사용
					$("#f_writeForm").attr({
						"method":"post",
						"enctype":"multipart/form-data",
						"action":"/admin/rideInsert"
						//"action":"/rideInsert"
					});
					$("#f_writeForm").submit();
				}
			});
			//취소 버튼 클릭 시 처리 이벤트
			$("#rideCancelBtn").click(function(){
				$("#f_writeForm").each(function(){
					this.reset();
				});
			});
			
			//목록 버튼 클릭 시 처리 이벤트
			$("#rideListBtn").click(function(){
				location.href="/admin/rideList";
			});
			
		});
	
		</script>
	</head>
	<body>
	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>어트랙션 추가</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="contentTB">
								<div class="contentBtn text-right">
									<button type="button" id="riedInsertBtn" class="btn sty_btn">등록</button>
									<button type="button" id="rideCancelBtn" class="btn sty_btn">취소</button>
									<button type="button" id="rideListBtn" class="btn sty_btn">목록</button>
								</div>
								<form class="form-horizontal" id="f_writeForm" name="f_writeForm">
									<table class="table table-bordered">
										<colgroup>
											<col width="20%" />
											<col width="80%" />
										</colgroup>
										<tbody>
											<tr>
												<td class="text-center">기구 이름</td>
												<td><input type="text"
													class="form-control" id="rideTitle" name="rideTitle"
													placeholder="기구 이름 입력" maxlength="15" /></td>
											</tr>
											<tr>
												<td class="text-center">서브 제목</td>
												<td><input type="text"
													class="form-control" id="rideSubTitle" name="rideSubTitle"
													placeholder="서브 제목 입력" maxlength="66" /></td>
											</tr>
											<tr>
												<td class="text-center">글내용</td>
												<td><textarea name="rideContent"
														id="rideContent" class="form-control" rows="8" maxlength="333" placeholder="글 내용 입력"></textarea></td>
											</tr>
											<tr>
												<td class="text-center">파일 업로드</td>
												<td>
													<!-- <label for="file" class="btn search_btn" >파일 선택</label> -->
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