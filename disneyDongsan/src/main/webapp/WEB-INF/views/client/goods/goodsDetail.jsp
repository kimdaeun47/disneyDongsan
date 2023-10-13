<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>	

	<link rel="stylesheet" href="../resources/include/css/goods/client/goodsDetail.css">
		
		<script type="text/javascript">
		    $(document).ready(function() {
		    	
		    	let quantity = $(".quantity_input").val();
		    	$(".plus_btn").on("click", function(){
		    		$(".quantity_input").val(++quantity);
		    	});
		    	$(".minus_btn").on("click", function(){
		    		if(quantity > 1){
		    			$(".quantity_input").val(--quantity);	
		    		}
		    	});
		    	
		    	const form = {
			    		member_id : 'user01',
			    		g_id : '${detail.g_id}',
			    		g_count : ''
			    }
				    $(".btn_cart").on("click", function(e){
				    	form.g_count = $(".quantity_input").val();
						$.ajax({
							url: '/goods/basketInsert',
							type: 'POST',
							data: form,
							success: function(result){
								cartAlert(result);
							}
						})
		
					});
				    function cartAlert(result){
						if(result == '0'){
							alert("장바구니에 추가를 하지 못하였습니다.");
						} else if(result == '1'){
							alert("장바구니에 추가되었습니다.");
						} else if(result == '2'){
							alert("장바구니에 이미 추가되어져 있습니다.");
						} else if(result == '5'){
							location.href = "/member/loginForm";
						}
					}
				    
				    $(".btn_buy").on("click", function(){
				    	let g_count = $(".quantity_input").val();
						$(".order_form").find("input[name='orders[0].g_count']").val(g_count);
						$(".order_form").submit();
		
					});
		    	
		    	
		    });
		    

			
		</script>
	</head>
	<body>
	
			<div class="content_top">
				<div class="ct_left_area">
					<div class="form_section_content">
						<c:if test="${not empty detail.g_image}">
							<img class="d_image" src="/dongsanStorage/goods/${detail.g_image}" />
						</c:if>
                    </div>									
				</div>
				<div class="ct_right_area">
					<div class="item_name">
						<h1>
							${detail.g_name}
						</h1>
					</div>
					<div class="line">
					</div>
					<div class="item_detail">
						 ${detail.g_detail}
					</div>
					<div class="line">
					</div>	
					<div class="price">
						
						<div class="discount_price">
							판매가 : <span class="discount_price_number"><fmt:formatNumber value="${detail.g_price}" pattern="#,### 원" /></span> 
						</div>							
					</div>			
					<div class="line">
					</div>	
					
					<div class="item_detail">
						 원산지 : ${detail.g_origin}
					</div>
						
					<div class="line">
					</div>
						
					<div class="item_detail">
						제조사 : ${detail.g_company}
					</div>
						
					<div class="line">
					</div>
						
					<div class="item_detail">
						배송업체 : ${detail.g_delivery}
					</div>
					
					<div class="line">
					</div>
						
					<div class="button">						
						<div class="button_quantity">
							주문수량
							<input type="text" class="quantity_input" value="1">
							<span>
								<button class="plus_btn">+</button>
								<button class="minus_btn">-</button>
							</span>
						</div>
						
						<div class="button_set">
							<a class="btn_cart">장바구니 담기</a>
							<a class="btn_buy">바로구매</a>
						</div>
					</div>
				</div>
			</div>
			
			<div class="line">
			</div>			
				
			<div class="content_middle">
				<div class="form_section_content">
					<c:if test="${not empty detail.g_image_detail}">
						<img src="/dongsanStorage/goods/${detail.g_image_detail}" />
					</c:if>
                </div>
			</div>
			
			<div class="line">
			</div>
			
			<!-- <form action="/goods/goodsOrder/${member.member_id}" method="get" class="order_form">
				<input type="hidden" name="orders[0].g_id" value="${detail.g_id}">
				<input type="hidden" name="orders[0].g_count" value="">
			</form>	 -->
			<form action="/goods/goodsOrder" method="get" class="order_form">
				<input type="hidden" name="orders[0].g_id" value="${detail.g_id}">
				<input type="hidden" name="orders[0].g_count" value="">
			</form>			
			
			
			<div class="content_bottom">
				<div class="container">
					<jsp:include page="goodsReview.jsp"/>
				</div>
			</div>
			
		
	</body>
</html>