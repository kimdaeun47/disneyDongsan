<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
  		<!-- CKEditor 스크립트 URL 수정 -->
       <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
			<style type="text/css">
				.container{width: 1020px;}
				#updateBtn, #cancelBtn,#listBtn{
					display: inline-block;
					height: 39px;
					width: 70px;
					font-weight: 600;
					font-size: 15px;
					line-height: 20px;
					margin-left: 10px;
					background-color: #3c3c8c;
					float: right;
					margin-bottom:30px; 
					color:white;
				}
				#updateBtn:hover, #cancelBtn:hover, #listBtn:hover {
					border: 2px solid #3c3c8c;
					background-color: white;
					color:black;
				}
				.idImg{width:200px;}
				.boardTilte{margin: 70px 0px 0px 0px;}
				.idText{margin-left: 10px;}
				.table{width: 1000px;}
				.routeDate{float: right; padding-right: 20px;}
			</style>
		<script type="text/javascript">
			$(function(){
				
				//수정 버튼 클릭 시 처리 이벤트
				$("#updateBtn").click(function(){
					//입력값 체크
					if(!chkData("#routeTitle", "제목을")) return;
					 else if (fn_valiChk()) return;
					else{
						if($("#file").val()!=""){//업로드할 이미지 파일이 존재한다면
							//확장자가 png, jpg, gif 외 파일을 업로드 할 수 없습니다.유효성 체크
							if(!chkFile($("#file"))) return;//이미지 파일만 업로드 가능.
						}
						$("#f_updateForm").attr({
							"method":"post",
							"enctype":"multipart/form-data",
							"action":"/route/routeUpdate"
						});
						$("#f_updateForm").submit();
					}
				});
				//취소 버튼 클릭 시 처리 이벤트
				$("#cancelBtn").click(function(){
					$("#f_updateForm").each(function(){
						this.reset();
					});
				});
				//목록 버튼 클릭 시 처리 이벤트
				$("#listBtn").click(function(){
					location.href="/route/routeList";
				});
				//파일 버튼 클릭 시 처리 이벤트
				$("#file").click(function(){
					$("#fileNeme").text("");
				});
			});
	          function fn_valiChk() {
	              var routeContent = CKEDITOR.instances.routeContent.getData(); 

	               if (routeContent == null || routeContent.trim() === '') {
	                   alert("내용을 입력하세요."); 
	                   CKEDITOR.instances.routeContent.focus();
	                   return true;
	               }
	               
	               return false;
	           }

		</script>
	</head>
	<body>
		<div class="container">
			<div class="contentTB">
				<h1 class="boardTilte text-center">
					<img class="idImg" alt="/" src="/resources/images/route/s.PNG">
				</h1>
				<div class="contectBtn text-right">
					<button type="button" id="updateBtn" class="btn">수정</button>
					<button type="button" id="cancelBtn" class="btn">취소</button>
					<button type="button" id="listBtn" class="btn">목록</button><br/>
				</div>
				<form id="f_updateForm" name="f_updateForm">
					<input type="hidden" id="routeNo" name="routeNo" value="${updateData.routeNo}" />
					<input type="hidden" id="routeImage" name="routeImage" value="${updateData.routeImage}" />				
					<br/><br/><p class="routeDate">( ${updateData.routeDate} )</p>
					<table class="table table-bordered">
						<tbody>
<%-- 							<tr>
								<td class="col-md-3">글번호</td>
								<td class="text-left col-md-3">${updateData.routeNo}</td>
								<!-- <td class="col-md-3">작성일</td> -->
								<td class="text-left col-md-3">${updateData.routeDate}</td>
							</tr> --%>
 							<tr>
								<!-- <td>작성자</td> -->
								<td colspan="3" class="text-left">${updateData.memberId}</td>
							</tr>
							<tr>
								<!-- <td>글제목</td> -->
								<td colspan="3" class="text-left">
									<input type="text" name="routeTitle" id="routeTitle" value="${updateData.routeTitle}" class="form-control" maxlength="33"/>
								</td>
							</tr>
							<tr class="table-tr-height">
								<!-- <td>내용</td> -->
								<td colspan="3" class="text-left">
									<textarea name="routeContent" id="routeContent" class="form-control" rows="8" maxlength="1000">${updateData.routeContent}</textarea>
									<script>
		                                CKEDITOR.replace("routeContent", {
		                                    resize_enabled: false,
		                                    enterMode: CKEDITOR.ENTER_BR,
		                                    shiftEnterMode: CKEDITOR.ENTER_P,
		                                    filebrowserUploadUrl: "/route/ckeditorUpload"
		                                });
		                            </script>
								</td>
							</tr>
<!-- 							<tr class="form-inline">
								<td>비밀번호</td>
								<td colspan="3" class="text-left">
									<input type="password" name="routePasswd" id="routePasswd" class="form-control" maxlength="20" />
									<label>수정할 비밀번호를 입력해 주세요.</label>
								</td>
							</tr> -->
							<tr>
								<!-- <td>이미지 파일 첨부</td> -->
								<td class="text-left">
									<label for="formFile" class="form-label"></label>
									<input class="form-control" type="file" name="file" id="file" />
									<span id="fileNeme">${updateData.routeImage}</span>
								</td>
							</tr>
						</tbody>
					</table>
				</form>		
			</div>
		</div>

	</body>
</html>