<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		
		<title>Insert title here</title>
		<link rel="shortcut icon" href="/resources/image/icon.png"/>
		<link rel="apple-touch-icon" href="/resources/image/icon.png"/>
		<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]--><link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap-theme.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/include/css/mypage/mypage_bodyTable.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<link rel="stylesheet" type="text/css" href="/resources/include/css/mypage/reviewBtn.css"/>
		<style>
		
</style>

<script type="text/javascript">
$(function(){
	$(".reviewUpdate").click(function(){
		let detail_num = $(this).parent("td").parent("tr").attr("data-num");
		$("#detail_num").val(detail_num);
		
		let g_order_detail_id = $(this).parent("td").parent("tr").attr("data-num");
		$("#g_order_detail_id").val(g_order_detail_id);
		
		let member_id = $(this).parent("td").parent("tr").children().eq(6).text();
		$("#member_id").val(member_id);
		
		let g_name = $(this).parent("td").parent("tr").children().eq(2).text();
		$("#g_name").val(g_name);
		
		let imageSrc = $(this).closest("tr").find(".file").attr("src");
		console.log("imageSrc=" + imageSrc);
		$("#g_image").val(imageSrc);
		
		$("#resultForm").attr({
			"method" : "post",
			"action" : "/mypage/userReviewUpdateForm"
		});
		$("#resultForm").submit();
	});
	
	$(".reviewDelete").click(function(){
		
		deleteChk = confirm("정말 삭제하시겠습니까?");
		let formData = new FormData(); 
		let detail_num = $(this).parent("td").parent("tr").attr("data-num");
		$("#detail_num").val(detail_num);
		let re_image = $(this).parent("td").parent("tr").children().eq(7).text();
		$("#re_image").val(re_image);
		
		formData.append("detail_num",detail_num);
		formData.append("re_image",re_image);
		
		if(deleteChk === true){
			
			$.ajax({
				type: 'post',
				processData: false,
	            contentType: false,
	            url: '/mypage/userReviewDelete',
	            data: formData,
	            success: function(resultData) {
	                if (resultData == "성공") {
	                    alert('후기가 삭제되었습니다.');
	                    location.reload();
	                } else {
	                    alert('후기 삭제에 실패했습니다.');
	                    return;
	                }
	            },
	            error: function() {
	                alert('서버와 통신 중 오류가 발생했습니다.');
	            }
			});
		}else return;
	});
	
	 $("#reviewList").click(function(){
	    	location.href="/mypage/userReviewList";
		
	});
	
});

</script>
	</head>
	<body>
		<div class="container">
		<h3 class="fw-bold">작성한 리뷰</h3>
      	<hr>
		<div class="wrap">
			<button type="button" class="custom-btn btn-15" id="reviewList">리뷰 작성</button>
			<button type="button" class="custom-btn">작성한 리뷰</button>
		</div>
			<form name="resultForm" id="resultForm">
				<input type="hidden" name="detail_num" id="detail_num"/>
				<input type="hidden" name="g_order_detail_id" id="g_order_detail_id"/>
				<input type="hidden" name="member_id" id="member_id"/>
				<input type="hidden" name="g_name" id="g_name"/>
				<input type="hidden" name="g_image" id="g_image"/>
				<input type="hidden" name="re_image" id="re_image"/>
			</form>
    			
			<div id="reviewCompleteList table-responsive">
				<table summary="게시판 리스트" class = "table table align-middle">
					<thead>
						<tr>
							<th class="col-md-1 text-center">No</th>
							<th class="col-md-5 text-center" colspan="2">상품정보</th>
							<th class="col-md-2 text-center">구매날짜</th>
							<th class="col-md-2 text-center">주문상태</th>
							<th class="col-md-2 text-center">후기작성</th>
							<th class="col-md-1 text-center" style= display:none></th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
					<!-- 데이터 출력 -->
						<c:choose>
						
							<c:when test="${not empty ReviewCompleteList}">
								<c:forEach var="ReviewCompleteList" items="${ReviewCompleteList}" varStatus="status">
								
									<tr class="text-center" data-num="${ReviewCompleteList.g_order_detail_id}">
										<td><strong><c:out value="${(pageMaker.cvo.pageNum - 1) * pageMaker.cvo.amount + status.index +1}"/></strong></td>
										<td>
											<c:if test="${not empty ReviewCompleteList.g_image}">
												<img src="/dongsanStorage/goods/${ReviewCompleteList.g_image}"class="file"/>
											</c:if> 
										</td>
										<td><strong>${ReviewCompleteList.g_name}</strong></td>
										<td><strong>${ReviewCompleteList.g_order_date}</strong></td>
										<td><strong>${ReviewCompleteList.g_order_state}</strong></td>
										<td>
											<button id="reviewUpdate" class="reviewUpdate">수정하기</button><br/>
											<button id="reviewDelete" class="reviewDelete">삭제하기</button>
										</td>
										<td style= display:none>${ReviewCompleteList.member_id}</td>
										<td style= display:none>${ReviewCompleteList.re_image}</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
							<tr>
								<td colspan="7" class="text-center"><strong>리뷰를 작성한 상품이 없어요...</strong></td>
							</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				
			</div>
		</div>
	
	</body>
</html>