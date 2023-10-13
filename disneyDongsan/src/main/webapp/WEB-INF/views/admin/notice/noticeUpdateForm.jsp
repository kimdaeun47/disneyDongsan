<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>
<link rel="stylesheet" href="/resources/include/css/commonInsert.css"/>

	    <!-- CKEditor 스크립트 URL 수정 -->
	    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
	
	    <style type="text/css">
	
	    </style>
	    
	    <script type="text/javascript">
	    	$(function(){
	    		$("#insertBtn").click(function(){
	    			if(!chkData1("#n_title", "제목을")) return;
		  			else if (fn_valiChk()) return;
		  			else{
		  				$("#f_updateForm").attr({
		  					"method":"post",
		  					"enctype":"multipart/form-data",
		  					"action":"/admin/notice/noticeUpdate"
		  				});
		  				$("#f_updateForm").submit();
		  			}
		  			
	    		});
	    		
	    		$("#listBtn").click(function(){
	    			location.href="/admin/notice/noticeList";
	    		});
	    		
	    		$("#cancelBtn").click(function(){
	    			location.reload();
	    		});
	    		
	    	});
	    	
	    	function fn_valiChk() {
	    		var n_content = CKEDITOR.instances.n_content.getData(); 

	    	    if (n_content == null || n_content.trim() === '') {
	    	        alert("공지 내용을 입력하세요."); 
	    	        CKEDITOR.instances.n_content.focus();
	    	        return true;
	    	    }
	    	    
	    	    return false;
	    	}

	    </script>
	
	</head>
	<body>
	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>공지 수정</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="contentTB">
								<div class="contentBtn text-right">
				                    <button type="button" id="cancelBtn" class="btn sty_btn">취소</button>
				                    <button type="button" id="insertBtn" class="btn sty_btn">확인</button>
				                	<button type="button" id="listBtn" class="btn sty_btn">목록</button>
				                </div>
								<form id="f_updateForm" name="f_updateForm" class="form-horizontal">
					                <input type="hidden" id="n_num" name="n_num" value="${updateData.n_num}" />    
					                <table class="table table-bordered">
					                    <colgroup>
					                        <col width="20%"/>
					                        <col width="80%"/>
					                    </colgroup>
				                        <tbody>
							                 <tr>
						                     	<td class="text-center">공지 제목</td>
						                        <td class="text-left"><input type="text" id="n_title" name="n_title" class="form-control" value="${updateData.n_title }" /></td>
						                     </tr>
						                     <tr>
						                     	<td class="text-center">공지 내용</td>
						                     	<td>
													<textarea name="n_content" id="n_content" >${updateData.n_content }</textarea>
													<script>
													    CKEDITOR.replace("n_content", {
													        resize_enabled: false,
												            enterMode: CKEDITOR.ENTER_BR,
												            shiftEnterMode: CKEDITOR.ENTER_P,
												            filebrowserUploadUrl: "/admin/notice/ckeditorUpload"
												        });
													</script>
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
