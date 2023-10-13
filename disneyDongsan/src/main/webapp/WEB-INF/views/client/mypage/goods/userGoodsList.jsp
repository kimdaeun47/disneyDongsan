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
		<![endif]-->
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/dist/css/bootstrap-theme.min.css"/>
		<link rel="stylesheet" type="text/css" href="/resources/include/css/mypage/mypageListBody.css"/>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
		<script type="text/javascript">
		$(function() {
			let chkObj = document.getElementsByName("RowCheck");
			let rowCnt = chkObj.length;

			$("input[name='allCheck']").click(function() {
				let chk_listArr = $("input[name='RowCheck']");
				for (let i = 0; i < chk_listArr.length; i++) {
					chk_listArr[i].checked = this.checked;
				}
			})

			$("input[name='RowCheck']").click(function() {
				if ($("input[name='Rowcheck']:checked").length == rowCnt) {
					$("input[name='allCheck']")[0].checked = true;
				} else {
					$("input[name='allCheck']")[0].checked = false;
				}
			});
			
			$(".goDetail").click(function(){
				let g_order_id = $(this).parent("div").attr("data-num");
				$("#g_order_id").val(g_order_id); 
				$("#detailForm").attr({
				"method" : "post",
				"action" : "/mypage/userGoodsDetail"
				});
				$("#detailForm").submit();
			});
			
			
			
			if($(".state-color").text() === '배송완료'){
				console.log($(".state-color").text());
				$(".state-color").css("color","gray");
			}else{
				
			}
		});
		
		function updateValue(){
		
			let goodsArr = new Array();
			let list = $("input[name='RowCheck']");
			hasChecked = false; //체크 여부 변수
			
			for (let i = 0; i < list.length; i++) { //체크된 갯수 추출
				if (list[i].checked) { // 선택이 되어있으면 배열에 값을 넣는다.
					hasChecked = true; //체크된 값이 있으면 true 설정
					//console.log(list[i].value);
					let stateCk = $(list[i]).parent().parent().children(".card-body").children().eq(0).text(); //배열의 있는 값의 부모요소를 찾아가 답변여부를 text로 가져온다.
					console.log("stateCk:" + stateCk);
					//답변 여부 체크
					if (stateCk === "배송중") {  alert("배송중인 상품은 취소가 불가능합니다."); return;}
					else if(stateCk === "배송취소"){alert("이미 취소된 상품이 포함되어있습니다."); return; }
					else if(stateCk === "배송취소요청"){alert("취소 요청처리가된 상품이 포함되어있습니다."); return; }
					else if(stateCk === "배송완료"){alert("배송이 이미 완료된 상품이 포함되어있습니다."); return;}
					else {
						goodsArr.push(list[i].value); //push함수를 이용해 valueArr에 값을 추가
						console.log("goodsArr:" + goodsArr);
					}
				}
			}
			if (!hasChecked) {
				alert("선택된 항목이 없습니다.");
				return;
			}
			if (confirm("정말로 배송취소를 하시겠습니까?")) {
				$.ajax({
					url : "/mypage/deliveryUpdate",
					type : 'post',
					traditional : true,//traditional은 배열을 넘겨주는 옵션이다.
					dataType : "text", //가져올 값의 타입을 텍스트로 설정
					data : {
						goodsArr : goodsArr
					//보내려는 데이터 변수 선언
					},success : function(resultData) { //통신이 성공정으로 이루어졌을때 실행
						if (resultData == "성공") {
							alert("배송취소가 완료되었습니다.");
							location.reload(); //페이지 새로고침
						} else {
							alert("배송취소가 실패되었습니다.");
							return;
						}
					}
				});
			} else return;
			
			
		}
		</script>
	</head>
<body>
	<div class="container">
		<h3 class="fw-bold">굿즈 주문내역</h3>
      	<hr>
		
		<form name="detailForm" id="detailForm">
			<input   class="m-25" type="hidden" name="g_order_id" id="g_order_id" />
		</form>
		
			<div class="allDiv">
				<input class="all-button"type="checkbox" id="allCheck" name="allCheck"/>
			</div>
		
		<div id="tketList">
			<c:choose>
				<c:when test="${not empty goodsList}">
					<c:forEach var="goodsList" items="${goodsList}" varStatus="status">
					<div class="card w-70 m-3">
						<div class="card-body" data-num="${goodsList.g_order_id}">
							<h5 class="card-title"><strong class="state-color" id="state-color">${goodsList.g_order_state}</strong></h5>
							<p class="card-title">주문번호&nbsp;&nbsp;&nbsp;${goodsList.g_order_id}</p>
							<p class="card-text">주문일시&nbsp;&nbsp;&nbsp;${goodsList.g_order_date}</p>
							<label class="goDetail">상세내역></label>
						</div>
						<div class="RowCheck_div">
							<input class="m-25" name="RowCheck" type="checkbox" value="${goodsList.g_order_id}" />
						</div>
					</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<div>
						<p class="text-center">결제된 상품이 존재하지 않습니다.</p>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="deleteline">
				<input type="button" id="deleteFormBtn"
					class="deleteFormBtn float-right" value="주문취소"
					onclick="updateValue();" />
			</div>
		</div>
	</div>

</body>
</html>