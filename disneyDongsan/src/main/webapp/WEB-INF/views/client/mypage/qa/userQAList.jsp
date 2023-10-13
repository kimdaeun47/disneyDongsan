<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		
		<title>나의 문의 리스트</title>
		<link rel="shortcut icon" href="/resources/image/icon.png"/>
		<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
		<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap-theme.min.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<link rel="stylesheet" type="text/css" href="/resources/include/css/mypage/mypage_qa_list.css"/>
		
		<script type="text/javascript">
		/*글쓰기 버튼 클릭시 처리 이벤트 */
		 	$(function(){
		 		
		 		$("#insertFormBtn").click(function(){
		 			console.log("글쓰기 버튼 클릭"); //콘솔에 출력하는 이유는 이벤트가 정상적으로 실행되는지 확인하기 위해서
		 			location.href = "/mypage/userQAWriteForm";
		 		});
		 		
		 		$(".goDetail").click(function(){
		 			let qa_no = $(this).parents("tr").attr("data-num");
		 			$("#qa_no").val(qa_no);
		 			console.log("문의 번호:" + qa_no);
		 			
		 			$("#detailForm").attr({
		 				"method" : "get",
		 				"action":"/mypage/userQADetail"
		 			});
		 			$("#detailForm").submit();
		 		})
		 	});
		</script>
	</head>
	<body>
		<div class="container">
			
			<h3 class="fw-bold">QA</h3>
      		<hr>
			<form name="detailForm" id="detailForm">
				<input type="hidden" name="qa_no" id="qa_no"/>
			</form>
			<div class="contentBtn">
				<input type="button" id="insertFormBtn" class="qa_btn"value="등록하기"/>
			</div>
			<div id="qaList">
				<table summary="게시판 리스트" class = "table table align-middle">
					<thead>
						<tr>
							<th class="col-md-1 text-center" >문의 번호</th>
							<th class="col-md-2 text-center">회원 아이디</th>
							<th class="col-md-3 text-center">제목</th>
							<th class="col-md-2 text-center">작성일</th>
							<th class="col-md-2 text-center">답변일시</th>
							<th class="col-md-1 text-center">답변 유무</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
					<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty qaList}">
								<c:forEach var="qaList" items="${qaList}" varStatus="status">
									<tr class="text-center" data-num="${qaList.qa_no}">
										<td><strong><c:out value="${(pageMaker.cvo.pageNum - 1) * pageMaker.cvo.amount + status.index +1}"/></strong></td>
										<td><strong>${qaList.member_id}</strong></td>
										<td class="goDetail">${qaList.title}</td>
										<td><strong>${qaList.qa_date}</strong></td>
										<td ><strong class="ask_color">${qaList.ask_date}</strong></td>
										<td><strong>${qaList.askyn}</strong></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="7" class="text-center"><strong>문의하실 내용을 등록해주세요.</strong></td>
							</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			
		</div>
	</body>
</html>