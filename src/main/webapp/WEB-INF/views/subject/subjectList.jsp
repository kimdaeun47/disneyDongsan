<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
		<title>학과 정보</title>
		
		<link rel="shortcut icon" href="/resources/image/icon.png" />
		<link rel="apple-touch-icon" href="/resources/image/icon.png" />
		<script type="text/javascript" src="/resources/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/js/common.js"></script>
		<script type="text/javascript" src="/resources/dist/js/bootstrap.min.js"></script>
		<script type="text/javascript" >
			let s_number = 0;
			$(function(){
				$.ajax({
					url:"/subject/subjectNumber",
					type: "get",
					dataType: "text",
					error: function(){
						alert('시스템 오류 입니다. 관리자에게 문의 하세요');
					},
					success : function(resultData){
						s_number = resultData;
						$("#s_num").val(resultData);
					}
				});
				$("#insertBtn").click(function(){
					if(!chkData("#s_name", "학과명을")) return;
					else{
						$("#insertForm").attr("method", "post");
						
						if($("#sno").val()=="0"){
							$("#insertForm").attr("action", "/subject/subjectInsert");
						}else{
							$("#insertForm").attr("action", "/subject/subjectUpdate");
						}
						
						$("#insertForm").submit();
					}
				});
				
				$("#cencelBtn").click(function(){
					$("#s_name").val("");
					$("#s_num").val(s_number);
					
					$("#insertBtn").html("학과정보등록");
					$("#sno").val("0");
				});
				
				$(".updateBtn").click(function(){
					$("#insertBtn").html("학과정보수정");
					
					let no = $(this).parents("tr").attr("data-no");
					console.log(no);
					$("#sno").val(no);
					let s_num = $(this).parents("tr").children().eq(1).html();
					$("#s_num").val(s_num);
					
					let s_name = $(this).parents("tr").children().eq(2).html();
					console.log(s_name);
					$("#s_name").val(s_name);						
				});
				
				$(".deleteBtn").click(function(){
					let no = $(this).parents("tr").attr("data-no");
					$("#no").val(no);
					if(confirm("학과정보 삭제하시겠습니까?")){
						$.ajax({
							url:"/subject/deleteCheck",
							type:"post",
							data: "no="+no,
							dataType:"text",
							error:function(){
								alert('시스템 오류 입니다. 관리자에게 문의 하세요');
							},
							success:function(resultData){
								if(resultData === "삭제불가능"){
									alert("소속된 학생이 존재하기 떄문에 학과 정보를 삭제할 수 없습니다");
									return;
								}else{
									$("#dataForm").attr({
										"method": "post",
										"action": "/subject/subjectDelete"
									});
									$("#dataForm").submit();
								}
							}
						});
					};
				});
				
			});
		</script>
		<style type="text/css">
			table{
				border-collapse: collapse;
			}
			th, td{
				border: 1px solid black;
				padding: 3px;
			}
		</style>
	</head>
	<body>
		<form id="dataForm">
			<input type="hidden" id="no" name="no"/>
		</form>
		<div class="row">
			<div class="col-xs-6">
				<table class="table table-striped">
					<thead>
						<tr> 
							<th class="text-center">일련 번호</th>
							<th class="text-center">학과 번호</th>
							<th class="text-center">학과 이름</th>
							<th class="text-center">수정여부</th>
							<th class="text-center">삭제여부</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty subjectList}">
								<c:forEach var="list" items="${subjectList}">
									<tr class="text-center" data-no="${list.no}">
										<td>${list.no}</td>
										<td>${list.s_num}</td>
										<td>${list.s_name}</td>
										<td><button type="button" class="updateBtn" >학과정보수정</button></td>
										<td><button type="button" class="deleteBtn" >학과정보삭제</button></td>
										
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="3">등록된 학과 정보가 존재하지 않습니다</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div class="col-xs-6">
				<%@ include file="insertForm.jsp" %>
			</div>
		</div>
	</body>
</html>