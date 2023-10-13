<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>
 <link rel="stylesheet" href="/resources/include/css/commonInsert.css"/> 
      <script type="text/javascript">
      	$(function(){
      		// 취소 버튼 클릭 처리 이벤트
    		$("#cancelBtn").click(function(){
    			$("#f_updateForm").each(function(){
    				this.reset();
    			})
    		})
    		
    		// 목록 버튼 클릭 처리 이벤트
    		$("#listBtn").click(function(){
    			location.href="/admin/event/eventList";
    		})
    		
    		// 확인(수정) 버튼 클릭 처리 이벤트
   			$("#updateBtn").click(function(){
	    		    if(!chkData1("#e_title", "제목을")) return;
	    		    else if (!chkData1("#e_start", "시작일을")) return;
	    		    else if (!chkData1("#e_end", "종료일을")) return;
	    		    else if (!chkData1("#e_content", "내용을")) return;

	    		    // 상시 체크박스가 체크되었을 때 e_time 값을 설정
	    		    if ($("#allDay").is(":checked")) {
	    		        $("#e_time").val("상시");
	    		    } else {
	    		        var startDate = new Date($("#e_start").val());
	    		        var endDate = new Date($("#e_end").val());

	    		        // 종료일이 시작일보다 이전인 경우
	    		        if (endDate < startDate) {
	    		            alert("종료일은 시작일보다 이후여야 합니다.");
	    		            return;
	    		        }

	    		        // e_time 유효성 체크
	    		        if (!chkData1("#e_time", "시간을")) return;
	    		    }

	    		    if($("#fileT").val() != ""){
	    		        if(!chkFile($("#fileT"))) return; 
	    		    } else if($("#file1").val() != ""){
	    		        if(!chkFile($("#file1"))) return; 
	    		    } else if($("#file2").val() != ""){
	    		        if(!chkFile($("#file2"))) return; 
	    		    }

	    		    if ($("#allDay").is(":checked")) {
	    		        $("#e_time").val("상시");
	    		    }

	    		    $("#f_updateForm").attr({
	    		        "method":"post",
	    		        "enctype":"multipart/form-data",
	    		        "action":"/admin/event/eventUpdate"
	    		    });
	    		    $("#f_updateForm").submit();
	    		});
      		
    		var eventData = { e_time: "상시" };

		    if (eventData.e_time === "상시") {
		        $("#allDay").prop("checked", true);
		        $("#e_time").prop("disabled", true); 
		    }
      		
      		
    		$("#allDay").change(function(){
    	        if ($(this).is(":checked")) {
    	            // 체크
    	            $("#e_time").prop("disabled", true); 
    	            $("#e_time").val("상시"); 
    	        } else {
    	            // 체크 해제
    	            $("#e_time").prop("disabled", false); 
    	            $("#e_time").val(""); 
    	        }
    	    });
      		
      	})
      
   		 
      
      </script>
      
   </head>
   <body>
   
   <%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>이벤트 수정</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">

							<div class="contentTB">
								<div class="contentBtn text-right">
			                        <button type="button" id="cancelBtn" class="btn sty_btn">취소</button>
			                        <button type="button" id="updateBtn" class="btn sty_btn">확인</button>
			                        <button type="button" id="listBtn" class="btn sty_btn">목록</button>
			                    </div>
								<form id="f_updateForm" name="f_updateForm" class="form-horizontal">
						    		<input type="hidden" id="e_no" name="e_no" value="${updateData.e_no}" />
						    		<input type="hidden" id="e_thum" name="e_thum" value="${updateData.e_thum}" />
						    		<input type="hidden" id="e_img1" name="e_img1" value="${updateData.e_img1}" />
						    		<input type="hidden" id="e_img2" name="e_img2" value="${updateData.e_img2}" />
						
				                    <table class="table table-bordered">
				                        <colgroup>
				                            <col width="20%"/>
				                            <col width="80%"/>
				                        </colgroup>
				                        <tbody>
				                            <tr>
				                                <td class="text-center">이벤트 제목</td>
				                                <td class="text-left"><input type="text" id="e_title" name="e_title" class="form-control" value="${updateData.e_title }"/></td>
				                            </tr>
				                            <tr>
				                                <td class="text-center">이벤트 일정</td>
				                                <td class="text-left">
				                                	<input type="date" style="width:300px;" id="e_start" name="e_start" value="${updateData.e_start }"/> - 
				                   		 			<input type="date" style="width:300px;" id="e_end" name="e_end" class="form" value="${updateData.e_end }"/>
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="text-center">이벤트 시간</td>
				                                <td class="text-left">
				                                	<input type="time" style="width:300px;" id="e_time" name="e_time" value="${updateData.e_time }"/> 
				                                	<input type="checkbox" name="e_time" id="allDay"> 상시
				                                </td>
				                            </tr>
				                            <tr>
				                                <td class="text-center">이벤트 내용</td>
				                                <td class="text-left"><textarea rows="10" cols="22" id="e_content" name="e_content" class="form-control" >${updateData.e_content }</textarea></td>
				                            </tr>
				                            
				                             <!-- 이미지 업로드 필드 -->
									        <tr>
									            <td class="text-center">섬네일 이미지:</td>
									            <td><input type="file" name="fileT" id="fileT"></td>
									        </tr>
									        <tr>
									            <td class="text-center">상세 이미지 1:</td>
									            <td><input type="file" name="file1" id="file1"></td>
									        </tr>
									        <tr>
									            <td class="text-center">상세 이미지 2:</td>
									            <td><input type="file" name="file2" id="file2"></td>
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