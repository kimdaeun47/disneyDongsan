<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>
<link rel="stylesheet" href="/resources/include/css/commonInsert.css"/>
		<script type="text/javascript">
			$(function(){
				
				$("#answerListBtn").click(function(){
					console.log("목록 버튼 클릭");
					location.href="/admin/answerList"
				});
				
				//답변하기 버튼 클릭시 실행
				$("#answerUpdateBtn").click(function(){
					if (!chkData("#ask","제목을")) return;
					else{
						$("#an_updateForm").attr({
							"method":"post",
				            "action":"/admin/answerUpdate"
						});
						$("#an_updateForm").submit();
					}
				});
				
				$("#answerResetBtn").click(function(){
			         $("#an_updateForm").each(function(){
			            this.reset();
			         });
			      });
			});
		</script>
		<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
	</head>
<body>
<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>문의 수정</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="contentTB text-center">
								<div class="contentBtn text-right">
									<button type="button" id="answerUpdateBtn" class="btn sty_btn">답변</button>
									<button type="button" id="answerResetBtn" class="btn sty_btn">취소</button>
									<button type="button" id="answerListBtn" class="btn sty_btn">목록</button>
								</div>
								<form id="an_updateForm" name="an_updateForm">
									<input type="hidden" name="qa_no" id="qa_no" value="${updateData.qa_no}">
									<table class="table table-bordered">
										<tr>
											<td class="text-center">아이디</td>
											<td class="text-left">${updateData.member_id}</td>
										</tr>
										<tr>
											<td class="text-center">제목</td>
											<td class="text-left">${updateData.title}</td>
										</tr>
										<tr>
											<td class="text-center">내용</td>
											<td class="text-left">${updateData.qa_content}</td>
										</tr>
										<tr class="text-tr-height">
											<td>답변</td>
											<td colspan="1" class="text-left"><textarea name="ask"
												id="ask" class="form-control" rows="8" placeholder="답변 내용 입력">${updateData.ask}</textarea>
											</td>
										</tr>
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