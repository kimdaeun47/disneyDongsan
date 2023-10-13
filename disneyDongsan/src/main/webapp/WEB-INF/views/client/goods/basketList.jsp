<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<title>Insert title here</title>

		<!--[if It IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
		<link rel="stylesheet" href="../resources/include/css/goods/client/basket.css">
		<link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap.min.css" />
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		<script type="text/javascript">
			$(function(){
				$(document).ready(function() {
					
					setTotalInfo();
					
				});
				
				$(".individual_basket_checkbox").on("change", function(){
					
					setTotalInfo($(".basket_info_td"));
	
				});
				
				$(".all_check_input").on("click", function(){

					/* 체크박스 체크/해제 */
					if($(".all_check_input").prop("checked")){
						$(".individual_basket_checkbox").attr("checked", true);
					} else{
						$(".individual_basket_checkbox").attr("checked", false);
					}
					
					setTotalInfo($(".basket_info_td"));
					
				});
				
				$(".all_check_input").on("click", function(){
	
					if($(".all_check_input").prop("checked")){
						$(".individual_basket_checkbox").attr("checked", true);
					} else{
						$(".individual_basket_checkbox").attr("checked", false);
					}
					
					setTotalInfo($(".basket_info_td"));
					
				});
				
				function setTotalInfo(){
					
					let totalPrice = 0;
					let totalCount = 0;
					let deliveryPrice = 0;
					let finalTotalPrice = 0;
					
					$(".basket_info_td").each(function(index, element){
						
						if($(element).find(".individual_basket_checkbox").is(":checked") === true){	//체크여부
							
							totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
							totalCount += parseInt($(element).find(".individual_g_count_input").val());
							
						}
						
						
					});
					
					//배송비 계산
					if(totalPrice >= 50000){
						deliveryPrice = 0;
					} else if(totalPrice == 0){
						deliveryPrice = 0;
					} else {
						deliveryPrice = 3000;	
					}
					
					
					finalTotalPrice = totalPrice + deliveryPrice;
					
					$(".totalPrice_span").text(totalPrice.toLocaleString());
					$(".delivery_price").text(deliveryPrice);
					$(".totalCount_span").text(totalCount);
					$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());
					
				}
				
				$(".plus_btn").on("click", function(){
					let quantity = $(this).parent("div").find("input").val();
					$(this).parent("div").find("input").val(++quantity);
				});
				$(".minus_btn").on("click", function(){
					let quantity = $(this).parent("div").find("input").val();
					if(quantity > 1){
						$(this).parent("div").find("input").val(--quantity);		
					}
				});
				
				/* 수량 수정 버튼 */
				$(".quantity_modify_btn").on("click", function(){
					let basket_id = $(this).data("basket_id");
					let g_count = $(this).parent("td").find("input").val();
					$(".update_basket_id").val(basket_id);
					$(".update_g_count").val(g_count);
					$(".quantity_update_form").submit();
					
				});
				//삭제버튼
				$(".delete_btn").on("click", function(e){
					e.preventDefault();
					const basket_id = $(this).data("basket_id");
					$(".delete_basket_id").val(basket_id);
					$(".quantity_delete_form").submit();
				});
				//쇼핑 계속하기
				$(".cart__bigorderbtn").on("click", function(){
					location.href = "/goods/goodsList";
				})
				
				//주문하기버튼
				$(".order_btn").on("click", function(){
					let form_contents ='';
					let orderNumber = 0;
					let state = false;	
					$(".basket_info_td").each(function(index, element){
						if($('input:checkbox[name=basket_checkbox]:checked').length > 0){
							if($(element).find(".individual_basket_checkbox").is(":checked") === true){
								
								let g_id = $(element).find(".individual_g_id_input").val();
								let g_count = $(element).find(".individual_g_count_input").val();
								
								let g_id_input = "<input name='orders[" + orderNumber + "].g_id' type='hidden' value='" + g_id + "'>";
								form_contents += g_id_input;
								
								let g_count_input = "<input name='orders[" + orderNumber + "].g_count' type='hidden' value='" + g_count + "'>";
								form_contents += g_count_input;
								
								orderNumber += 1;
									
								state = true;
								
							}
						}else {
							state = false;
						}
						
					
						
						
						/* if($(element).find(".individual_basket_checkbox").is(":checked") === true){
							
							let g_id = $(element).find(".individual_g_id_input").val();
							let g_count = $(element).find(".individual_g_count_input").val();
							
							let g_id_input = "<input name='orders[" + orderNumber + "].g_id' type='hidden' value='" + g_id + "'>";
							form_contents += g_id_input;
							
							let g_count_input = "<input name='orders[" + orderNumber + "].g_count' type='hidden' value='" + g_count + "'>";
							form_contents += g_count_input;
							
							orderNumber += 1;
								
							$(".order_form").html(form_contents);
							$(".order_form").submit();
						}else {
							alert("주문할 상품이 없습니다.")
						} */
					});
					
					if(state == true){
						$(".order_form").html(form_contents);
						$(".order_form").submit();
					} else {
						alert("주문할 상품이 없습니다.");
					}
					
					
				});
				
			}); //최상위 종료
		</script>
	</head>
	
	
	<body>
			<section class="cart">
                    <div class="cart__information">
                        <ul>
                            <li>장바구니 상품은 최대 30일간 저장됩니다.</li>
                            <li>가격, 옵션 등 정보가 변경된 경우 주문이 불가할 수 있습니다.</li>
                            <li>오늘출발 상품은 판매자 설정 시점에 따라 오늘출발 여부가 변경될 수 있으니 주문 시 꼭 다시 확인해 주시기 바랍니다.</li>
                        </ul>
                    </div>
                    <table class="cart__list text-center">
                    		<colgroup>
						    	<col width="5%" />
						        <col width="15%" />
						        <col width="30%" />
						        <col width="10%" />
						        <col width="5%" />
						        <col width="15%" />
						        <col width="20%" />
						    </colgroup>
                    
                       
                            <thead>
                                <tr>
                                    <td class="all_check_input_div">
										<input type="checkbox" class="all_check_input input_size_20" checked="checked"><span class="all_chcek_span"></span>
									</td>
                                    <td>상품 이미지</td>
                                    <td class="goods_name_table">상품명</td>
                                    <td>상품금액</td>
                                    <td>수량</td>
                                    <td>합계</td>
                                    <td>삭제</td>
                                </tr>
                            </thead>

                            <tbody>
                            	<c:forEach items="${basketInfo}" var="basket">
	                                <tr class="cart__list__detail">
	                                	<td class="td_width_1 basket_info_td">
	                                		<input type="checkbox" class="individual_basket_checkbox input_size_20"  name="basket_checkbox" checked="checked">
	                                		<input type="hidden" class="individual_g_price_input" value="${basket.g_price}">
	                                		<input type="hidden" class="individual_g_count_input" value="${basket.g_count}">
	                                		<input type="hidden" class="individual_totalPrice_input" value="${basket.g_price * basket.g_count}">
	                                		<input type="hidden" class="individual_g_id_input" value="${basket.g_id}">
	                                	</td>
	                                	
	                                    <td>
	                                    	<div class="item-img">
												<c:if test="${not empty basket.g_image}">
													<img class="g_image" src="/dongsanStorage/goods/${basket.g_image}" />
												</c:if>
												<c:if test="${empty basket.g_image}">
													<img src="/resources/images/noimage.png" class="g_image"/>
												</c:if>
											</div>
	                                    </td>
	                                    <td class="table_text_align_center">${basket.g_name}</td>
	                                    <td><span class="discount_price_number"><fmt:formatNumber value="${basket.g_price}" pattern="#,### 원" /></span><br/>
	                                    </td>
	                                    <td class="td_width_4 table_text_align_center">
											<div class="table_text_align_center quantity_div">
												<input type="text" value="${basket.g_count}" class="quantity_input">	
												<button class="quantity_btn plus_btn">+</button>
												<button class="quantity_btn minus_btn">-</button>
											</div>
											<a class="quantity_modify_btn" data-basket_id="${basket.basket_id}">변경</a>
										</td>
	                                    <td class="td_width_4 table_text_align_center">
											<fmt:formatNumber value="${basket.g_price * basket.g_count}" pattern="#,### 원" />
										</td>
										<td class="td_width_4 table_text_align_center">
											<button class="delete_btn" data-basket_id="${basket.basket_id}">삭제</button>
										</td>
	                                </tr>
	                        	</c:forEach>
                            </tbody>
                            
                            

                            <tfoot>
                                <tr>
                                		<td></td><td></td><td></td>
                                		<td>
											배송비 : <span class="delivery_price"></span>원
										</td>
										<td>상품개수 : <span class="totalCount_span"></span>개</td>
										<td>
											총 가격 : <span class="totalPrice_span"></span> 원
										</td>
										<td>총 결제 할 금액<span class="finalTotalPrice_span"></span> 원</td>

                                </tr>
                            </tfoot>
        
                    </table>
                    <!-- 수량 조정 form -->
                    <form action="/goods/basketUpdate" method="post" class="quantity_update_form">
						<input type="hidden" name="basket_id" class="update_basket_id">
						<input type="hidden" name="g_count" class="update_g_count">
						<input type="hidden" name="member_id" value="${member.member_id}">
					</form>
					
					<!-- 삭제 form -->
					<form action="/goods/basketDelete" method="post" class="quantity_delete_form">
						<input type="hidden" name="basket_id" class="delete_basket_id">
						<input type="hidden" name="member_id" value="${member.member_id}">
					</form>
					
					<!-- 주문 form -->
					<!-- <form action="/goods/goodsOrder/${member.membe_id}" method="get" class="order_form">  -->
					 <form action="/goods/goodsOrder" method="get" class="order_form">
		
					</form>
					
                    <div class="cart__mainbtns">
                        <button class="cart__bigorderbtn left">쇼핑 계속하기</button>
                        <button class="order_btn right">주문하기</button>
                    </div>
                </section>
            
	</body>
</html>