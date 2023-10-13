<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		
		<title>문의 상세정보</title>
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
		$(function(){
			let ask = $("#ask").val();
			console.log(ask);
			$("#answer").css("visibility","hidden");
			
			if( ask != ""){
			$("#answer").css("visibility","visible");
			}
			/*목록 버튼 클릭 시 처리 이벤트*/
			$('#qaListBtn').click(function(){
				location.href="/mypage/userQAList"
			});
			
		
			
			$("#qaDeleteBtn").click(function(){
				if(confirm("삭제하시겠습니까?") === true){
				$("#f_data").attr({
					"method":"post",
					"action":"/mypage/qaDelete"
				});
				$("#f_data").submit();
				}
			});
			
			
		});
		</script>
	</head>
	<body>
	<div class="contentContainer container">
	<h3 class="fw-bold">상세 문의</h3>
	<hr>
	<form name="f_data" id="f_data" method="post">
	<input type="hidden" name="qa_no" value="${detail.qa_no}">
	</form>
	<form>
		<input type="hidden" name="ask" id="ask" value="${detail.ask}">
	</form>
		<button type="button" id="qaDeleteBtn" class="qaDeleteBtn">삭제</button>
		<button type="button" id="qaListBtn" class="qaListBtn">목록</button>
		<div class="contentTB text-center">
			<table class=" detail_table table table-bordered align-middle">
				<tbody class="detail_body">
					<tr class="">
						<td class="col-2 qaTitle">&nbsp;&nbsp;제목</td>
						<td class="text">
						<c:choose>
								<c:when test="${detail.askyn eq 'n'}">
									<p class="askck">미답변</p>
								</c:when>
						</c:choose>
						<c:choose>
								<c:when test="${detail.askyn eq 'Y'}">
									<p class="askck">답변완료</p>
								</c:when>
						</c:choose><br/><strong>${detail.title}</strong></td>
					</tr>
					<tr>
						<td class="col-md-1 qaTitle"" style="text-align:left;">&nbsp;&nbsp;작성아이디</td>
						<td class="text"><strong>${detail.member_id}</strong></td>
					</tr>
				</tbody>
			</table>
		
				<div>
					<p class="text"><span>작성일&nbsp;</span><span class="qa_date">${detail.qa_date}</span></p>
				</div>
				
				<div class="ask_title"><strong>문의내용</strong></div>
				<div class="content_div">
					<p class="text">${detail.qa_content}</p>
				</div>
				<div class="answer_title"><strong>답변</strong></div>
					<c:choose>
						<c:when test="${detail.ask eq ''}">
						<div class="answer_div">
							<p class="ask"><strong>아직 답변이 도착하지 않았어요..</strong></p>
						</div>
						</c:when>
					</c:choose>
				
				<div id="answer" class="answer_div">
					<c:choose>
							<c:when test="${detail.ask ne ''}">
								<p class="asky">${detail.ask}</p>
							</c:when>
					</c:choose>
				</div>
		</div>
	</div>
</body>
</html>