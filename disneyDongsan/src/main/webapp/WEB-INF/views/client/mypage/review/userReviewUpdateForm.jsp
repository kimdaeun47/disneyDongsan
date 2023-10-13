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
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap-theme.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/include/css/mypage/mypage_bodyTable.css"/>
		<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		$(function(){
			$("#reviewUpdatetBtn").click(function(){
				
				if(!chkData("#re_content","작성할 내용을")) return;
				if($("#file").val()!=""){//업로드할 이미지 파일이 존재한다면
					//확장자가 png, jpg, gif 외 파일을 업로드 할 수 없습니다.유효성 체크
					if(!chkFile($("#file"))) {
						return;//이미지 파일만 업로드 가능.
					}
				}
				updateChk = confirm("수정하시겠습니까?")
				if(updateChk == true){
					alert("수정이 완료되었습니다.");
					$("#updateForm").attr({
						"method" : "post",
						"enctype":"multipart/form-data",
						"action" : "/mypage/userReviewUpdate"
					});
					$("#updateForm").submit();
				}else{
					return;
				}
					
			});
			
			 $("#reviewListBtn").click(function(){
					location.href="/mypage/userReviewList";
				});
			    
			    $("#reviewResetBtn").click(function(){
			         $("#updateForm").each(function(){
			            this.reset();
			         });
			      });
		});
	</script>
	</head>
	<body>
		 <h3 class="fw-bold">리뷰 수정</h3>
	     <hr>
		<div class="top">
			<div class="exction"><strong>유의사항</strong></div>
			<ul>
	    		<li>작성하신 후기는 디즈니동산 이용자에게 공개됩니다. 댓글은 디즈니동산에서 확인하지 않습니다.</li>
	    	</ul>
    	</div>
		<div class="card">
			<div class="card-body">
				<div class="top_menu">
					<div class="goods_name"><strong>굿즈 상품</strong></div>
					<div class="goods_div">
						<div class="goods_img_div">
							<img class="goods_img" src="/dongsanStorage/goods/${UpdateResultData.g_image}"/>
						</div>	
						<div class="goods_price">
							<span>${UpdateResultData.g_name}</span><p class="price"><fmt:formatNumber type="number" value="${UpdateResultData.g_price}" pattern="#,##0" />원</p>
						</div>
					</div>
					
				</div>
				<div class="middle_menu">
					<div class="re_img_title">
						<span>현재 사진</span>
					</div>
					<div class="re_image_div">
						<c:if test="${not empty UpdateResultData.re_image}">
							<img  class="re_image" src="/dongsanStorage/goods/${UpdateResultData.re_image}"/>
						</c:if>
						<c:if test="${empty UpdateResultData.re_image}">
							<img  class="re_image" src="/dongsanStorage/goods/no_img.png"/>
						</c:if>
					</div>
				</div>
			
				<form name="updateForm" id="updateForm">
					<input type="hidden" name="detail_num" id="detail_num" value="${UpdateResultData.detail_num}"/>
					<input type="hidden" name="re_image" id="re_image"   value="${UpdateResultData.re_image}"/>
					<div class="table table-bordered">
						<div class="review_div">
							<span>내용</span>
							<textarea name="re_content" id="re_content" class="form-control" rows="8">${UpdateResultData.re_content}</textarea>
						</div>
					
						<div class="img_file">
							<strong class="img">사진</strong>
							<span  class="text-left">
								<input type="file" class="form-file" id="file" name="file" />
							</span>
						</div>
					</div>
				</form>	
				</div>
			</div>


	<div class="contentBtn text-right">
		<button type="button" id="reviewUpdatetBtn" class="Btn">수정하기</button>
		<button type="button" id="reviewResetBtn" class="Btn">다시쓰기</button>
		<button type="button" id="reviewListBtn" class="Btn">후기목록</button>
	</div>
	</body>
</html>