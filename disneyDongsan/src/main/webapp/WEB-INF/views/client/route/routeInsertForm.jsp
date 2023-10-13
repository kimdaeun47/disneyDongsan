<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
    <!-- CKEditor 스크립트 URL 수정 -->
    <style type="text/css">
		.container{width: 1020px;}
		#insertBtn, #cancelBtn,#listBtn{
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
		#insertBtn:hover, #cancelBtn:hover, #listBtn:hover {
			border: 2px solid #3c3c8c;
			background-color: white;
			color:black;
		}
		.idImg{width:100px;margin-bottom: 25px;}
		.boardTilte{margin: 70px 0px 10px 0px;}
		.idText{margin-left: 10px;}
		.table{width: 1000px;}
	</style>
    <script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>
		<script type="text/javascript">
		$(function(){
			//저장 버튼 클릭 시 처리 이벤트
			$("#insertBtn").click(function() {
				if(!chkData("#routeTitle", "제목을")) return;
				else if (fn_valiChk()) return;
				else{
 					if($("#file").val()!=""){//업로드할 이미지 파일이 존재한다면
						//확장자가 png, jpg, gif 외 파일을 업로드 할 수 없습니다.유효성 체크
						if(!chkFile($("#file"))) return;//이미지 파일만 업로드 가능.
					} 
					// enctype 속성의 기본 값은 "application/x-www-form-urlcencoded". POST방식 폼 전송에 기본 값으로 사용
					$("#f_writeForm").attr({
						"method":"post",
						"enctype":"multipart/form-data",
						"action":"/route/routeInsert"
					});
					$("#f_writeForm").submit();
				}
			});
			//취소 버튼 클릭 시 처리 이벤트
			$("#cancelBtn").click(function(){
				$("#f_writeForm").each(function(){
					this.reset();
				});
				CKEDITOR.instances.routeContent.setData("");
			});
			
			//목록 버튼 클릭 시 처리 이벤트
			$("#listBtn").click(function(){
				location.href="/route/routeList";
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
			<div>
				<h1 class="boardTilte text-center">
				<img class="idImg" alt="/" src="/resources/images/route/s.PNG">
					추천코스 글쓰기
				</h1>
				<div class="text-right">
					<button type="button" id="listBtn" class="btn">목록</button>
					<button type="button" id="insertBtn" class="btn">저장</button>
					<button type="button" id="cancelBtn" class="btn">취소</button>
					
				</div>
				<form class="form-horizontal" id="f_writeForm" name="f_writeForm">
					<table class="table table-bordered ">
						<tbody>
							<tr>
								<!-- <td>작성자</td> -->
								<td class="text-left" id="memberId" name="memberId">${Member.memberId}
							</tr>
							<tr>
								<!-- <td>글제목</td> -->
								<td class="text-left"><input type="text" class="form-control" id="routeTitle" name="routeTitle"
									placeholder="제목을 입력해 주세요." maxlength="33" /></td>
							</tr>
							<tr>
								<!-- <td>글내용</td> -->
								<td class="text-left">
									<textarea name="routeContent" id="routeContent" ></textarea>
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
 							<tr>
								<td class="text-left">
									<label for="formFile" class="form-label"></label>
									<input class="form-control" type="file" name="file" id="file" />
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
		</div>
	</body>
</html>