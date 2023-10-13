<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<link rel="stylesheet" href="../resources/include/css/goods/admin/deliveryDetail.css">
<link rel="stylesheet" href="/resources/include/css/commonDetail.css"/>

<style type="text/css">
	.sty_btn{
		width: 100px;
	}
</style>

<script type="text/javascript">
	$(function(){
		
		$(".delivery1_btn").click(function(){
			$(".g_order_state").val("배송중");
			run();
		});
		   
		$(".delivery2_btn").click(function(){
			$(".g_order_state").val("배송완료");
			run();
													    
		});
		
		$(".delivery3_btn").click(function(){
			$(".g_order_state").val("배송취소");
			
			ask=confirm("정말 취소할래?");
			if(ask === true){
			}else{
				return;
			}
			run();
													    
		});
													   
		function run(){
					
			$(".deliveryForm").submit();
		}
		
		
	});
											  
</script>
</head>
<body>
 <%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>배송 상세 목록</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="orderInfo">
								  <c:forEach items="${orderView}" var="orderView" varStatus="status">
								  
									  <c:if test="${status.first}">
									  		<p><span>주문번호</span>${orderView.g_order_id}</p>
											<p><span>주문자</span>${orderView.member_id}</p>
											<p><span>수령인</span>${orderView.member_name}</p>
											<p><span>주소</span>(${orderView.member_addr1}) ${orderView.member_addr2} ${orderView.member_addr3}</p>
											<p><span>배송상태</span>${orderView.g_order_state}</p>
											
											<div class="deliveryChange">
											 <form role="form" method="post" class="deliveryForm">
											 
											  <input type="hidden" name="g_order_id" value="${orderView.g_order_id}" />
											  <input type="hidden" name="g_order_state" class="g_order_state" value="" />
											  
											  <button type="button" class="delivery1_btn btn sty_btn">배송 중</button>
											  <button type="button" class="delivery2_btn btn sty_btn">배송 완료</button>
											  <button type="button" class="delivery3_btn btn sty_btn">배송 취소</button>
											  
											  
											 </form>
											</div>
									  </c:if>
								  
								 </c:forEach>
							</div>
							
							
							<ul class="orderView">
							 <c:forEach items="${orderView}" var="orderView">     
							 <li>
							 <div class="g_image">
							   <c:if test="${not empty orderView.g_image}">
									<img src="/dongsanStorage/goods/${orderView.g_image}" class="file"/>
								</c:if>
								<c:if test="${empty orderView.g_image}">
									<img src="/resources/images/noimage.png" />
								</c:if>
							  </div>
							  <div class="gdsInfo">
							   <p>
							    <span>상품명</span>${orderView.g_name}<br />
							    <span>개당 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.g_price}" /> 원<br />
							    <span>구입 수량</span>${orderView.g_count} 개<br />
							    <span>최종 가격</span><fmt:formatNumber pattern="###,###,###" value="${orderView.g_price * orderView.g_count}" /> 원                  
							   </p>
							  </div>
							 </li>     
							 </c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
     
 
  <%@ include file="/WEB-INF/views/admin-template/footer.jsp"%>

	<script type="text/javascript"
		src="/resources/include/js/jquery-3.7.0.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script
		src="/resources/include/assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script
		src="/resources/include/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/include/assets/vendor/chart.js/chart.umd.js"></script>
	<script src="/resources/include/assets/vendor/echarts/echarts.min.js"></script>
	<script src="/resources/include/assets/vendor/quill/quill.min.js"></script>
	<script
		src="/resources/include/assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="/resources/include/assets/vendor/tinymce/tinymce.min.js"></script>
	<script
		src="/resources/include/assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="/resources/include/assets/js/main.js"></script>
</body>
</html>