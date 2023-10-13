<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<link rel="stylesheet" href="../resources/include/css/goods/client/pay.css">
		<link rel="stylesheet" type="text/css" href="/resources/css/header.css" />
		<link rel="stylesheet" type="text/css" href="/resources/include/dist/css/bootstrap.min.css" />
				
		<script type="text/javascript" src="/resources/include/js/common.js"></script>
		<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
		
		<!-- 주소 API -->
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<!-- 결제 API -->
  		<!-- iamport.payment.js -->
  		<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
  		 
		
		
		<script type="text/javascript">
			
			$(document).ready(function(){
				
				/* 주문 조합정보란 최신화 */
				setTotalInfo();
				
			});
		
			//주소
			function showAdress(className){
	    		/* 컨텐츠 동작 */
	    		/* 모두 숨기기 */
	    		$(".addressInfo_input_div").css('display', 'none');
	    		/* 컨텐츠 보이기 */
	    		$(".addressInfo_input_div_" + className).css('display', 'block');		
	    	
	    	/* 버튼 색상 변경 */
	    		/* 모든 색상 동일 */
	    			$(".address_btn").css('backgroundColor', '#555');
	    		/* 지정 색상 변경 */
	    			$(".address_btn_"+className).css('backgroundColor', '#3c3838');
	    			/* selectAddress T/F */
	    			/* 모든 selectAddress F만들기 */
	    				$(".addressInfo_input_div").each(function(i, obj){
	    					$(obj).find(".selectAddress").val("F");
	    				});
	    			/* 선택한 selectAdress T만들기 */
	    				$(".addressInfo_input_div_" + className).find(".selectAddress").val("T");
	    		
	    	}
			
			//주소
			function execution_daum_address(){
		 		console.log("동작");
			   new daum.Postcode({
			        oncomplete: function(data) {
			            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
			            
			        	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수
		 
		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }
		 
		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                 	// 추가해야할 코드
		                    // 주소변수 문자열과 참고항목 문자열 합치기
		                      addr += extraAddr;
		                
		                } else {
		                	addr += ' ';
		                }
		 
		             	// 제거해야할 코드
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                $(".address1_input").val(data.zonecode);
		                $(".address2_input").val(addr);				
		                // 커서를 상세주소 필드로 이동한다.
		                $(".address3_input").attr("readonly", false);
		                $(".address3_input").focus();	 
			            
			            
			        }
			    }).open();  	
			
			}
			
			
			function setTotalInfo(){

				let totalPrice = 0;				// 총 가격
				let totalCount = 0;				// 총 갯수
				let deliveryPrice = 0;			// 배송비
				let finalTotalPrice = 0; 		// 최종 가격(총 가격 + 배송비)	
				
				$(".goods_table_price_td").each(function(index, element){
					// 총 가격
					totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
					// 총 갯수
					totalCount += parseInt($(element).find(".individual_g_count_input").val());
					// 총 종류
				});	

				/* 배송비 결정 */
				if(totalPrice >= 30000){
					deliveryPrice = 0;
				} else if(totalPrice == 0){
					deliveryPrice = 0;
				} else {
					deliveryPrice = 0;	
				}
				
				finalTotalPrice = totalPrice + deliveryPrice;	
				
				/* 값 삽입 */
				// 총 가격
				$(".totalPrice_span").text(totalPrice.toLocaleString());
				// 총 갯수
				$(".goods_kind_div_count").text(totalCount);
				// 배송비
				$(".delivery_price_span").text(deliveryPrice.toLocaleString());	
				// 최종 가격(총 가격 + 배송비)
				$(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());	
				
			}

			

			
			$(document).ready(function(){ 
				$(".order_btn").click(function(){ 
			    	payment(); //버튼 클릭하면 호출 
			    }); 
			})
			

			//버튼 클릭하면 실행
			
			function payment(data) {
				
				// 다시 가격
				let totalPrice = 0;				// 총 가격
				let totalCount = 0;				// 총 갯수
				let deliveryPrice = 0;			// 배송비
				let finalTotalPrice = 0; 		// 최종 가격(총 가격 + 배송비)
				
				$(".goods_table_price_td").each(function(index, element){
					// 총 가격
					totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
					// 총 갯수
					totalCount += parseInt($(element).find(".individual_g_count_input").val());
					// 총 종류
				});	
				
				

				/* 배송비 결정 */
				if(totalPrice >= 30000){
					deliveryPrice = 0;
				} else if(totalPrice == 0){
					deliveryPrice = 0;
				} else {
					deliveryPrice = 3000;	
				}
				
				finalTotalPrice = totalPrice + deliveryPrice;
				
				
				let gname = $(".individual_g_name_input").val();
				console.log(gname);
				
				
				
				
				//여기서 부터 결제
				IMP.init('imp02353400');
			  	//결제시 전달되는 정보
			  	
				IMP.request_pay({
							pg : 'html5_inicis.INIpayTest' , 
						    pay_method : 'card',
						    merchant_uid : 'merchant_' + new Date().getTime(),
						    
						    name : gname/*상품명*/,
						    amount : finalTotalPrice  /*상품 가격*/, 
						    
						    buyer_email : '${memberInfo.memberEmail}'/*구매자 이메일*/,
						    buyer_name : '${memberInfo.memberName}',
						    buyer_tel : '${memberInfo.memberPhone}'/*구매자 연락처*/,
						    buyer_addr : '${memberInfo.memberAddr2}'/*구매자 주소*/,
						    buyer_postcode : '${memberInfo.memberAddr1}'/*구매자 우편번호*/
						}, function(rsp) {
							
							//결제완료시
							var result = '';
						    if ( rsp.success ) {
						        var msg = '결제가 완료되었습니다.';
						        msg += '고유ID : ' + rsp.imp_uid;
						        msg += '상점 거래ID : ' + rsp.merchant_uid;
						        msg += '결제 금액 : ' + rsp.paid_amount;
						        
						        result ='0';
						        
						        alert(msg);				
						        
						      //주소 정보 & 받는이
								$(".addressInfo_input_div").each(function(i, obj){
									if($(obj).find(".selectAddress").val() === 'T'){
										$("input[name='member_name']").val($(obj).find(".member_name_input").val());
										$("input[name='member_addr1']").val($(obj).find(".address1_input").val());
										$("input[name='member_addr2']").val($(obj).find(".address2_input").val());
										$("input[name='member_addr3']").val($(obj).find(".address3_input").val());
									}
								});
								
								let form_contents = ''; 
								$(".goods_table_price_td").each(function(index, element){
									let g_id = $(element).find(".individual_g_id_input").val();
									let g_count = $(element).find(".individual_g_count_input").val();
									let g_id_input = "<input name='orders[" + index + "].g_id' type='hidden' value='" + g_id + "'>";
									form_contents += g_id_input;
									let g_count_input = "<input name='orders[" + index + "].g_count' type='hidden' value='" + g_count + "'>";
									form_contents += g_count_input;
								});	
								
								// imp_uid, merchant_uid, paid_amount 추가
						        form_contents += "<input name='imp_uid' type='hidden' value='" + rsp.imp_uid + "'>";
						        form_contents += "<input name='merchant_uid' type='hidden' value='" + rsp.merchant_uid + "'>";
						        form_contents += "<input name='paid_amount' type='hidden' value='" + rsp.paid_amount + "'>";
								
								$(".order_form").append(form_contents);	
								
								//서버 전송
								$(".order_form").submit();

								
						        
						    } else {
						        var msg = '결제에 실패하였습니다.';
						        msg += '에러내용 : ' + rsp.error_msg;
						        result ='1';
						    }
						});
			  	
					}

			
			

			
		</script>
	</head>
	<body>
				<section class="cart">
					<div class="orderForm" id="orderForm">
						<div class="orderGoods_div">
	
							<!-- 상품 테이블 -->
							<table class="goods_subject_table">
								<colgroup>
									<col width="15%">
									<col width="45%">
									<col width="40%">
								</colgroup>
								<tbody>
									<tr>
										<th>이미지</th>
										<th>상품 정보</th>
										<th>판매가</th>
									</tr>
								</tbody>
							</table>
							<table class="goods_table">
								<colgroup>
									<col width="15%">
									<col width="45%">
									<col width="40%">
								</colgroup>					
								<tbody>
									<c:forEach items="${orderList}" var="ol">
										<tr>
											<td>
												<c:if test="${not empty ol.g_image}">
													<img src="/dongsanStorage/goods/${ol.g_image}" class="file"/>
												</c:if>
												<c:if test="${empty ol.g_image}">
													<img src="/resources/images/noimage.png" class="file"/>
												</c:if>
											</td>
											<td>
												${ol.g_name}
												<input type="hidden" class="individual_g_name_input" value="${ol.g_name}">
											</td>
											
											<td class="goods_table_price_td">
												<fmt:formatNumber value="${ol.g_price}" pattern="#,### 원" /> | 수량 ${ol.g_count}개
												<br><fmt:formatNumber value="${ol.g_total_price}" pattern="#,### 원" />
												<input type="hidden" class="individual_g_price_input" value="${ol.g_price}">
												<input type="hidden" class="individual_g_count_input" value="${ol.g_count}">
												<input type="hidden" class="individual_totalPrice_input" value="${ol.g_price * ol.g_count}">
												<input type="hidden" class="individual_g_id_input" value="${ol.g_id}">
											</td>
										</tr>							
									</c:forEach>
					
								</tbody>
							</table>
						</div>
	            
	
	                    <div>
	                    <fieldset>
	                        <legend>개인 정보</legend>
	                        <ul>
	                            <li>
		                            <label for="uname" class="title">이름</label>
		                            <input type="text" id="uname" value="${memberInfo.memberName}" readonly/>
		                        </li>
		                        <li>
		                            <label for="tel1" class="title">연락처</label>
		                            <input type="tel" id="tel1" value="${memberInfo.memberPhone}" readonly/>
		                        </li>
		                        <li>
		                            <label for="tel1" class="title">이메일</label>
		                            <input type="tel" id="tel1" value="${memberInfo.memberEmail}" readonly/>
		                        </li>
	                        </ul>
	                    </fieldset>
	                    <fieldset>
	                        <legend>배송지 정보</legend>
	                        <div class="addressInfo_div">
								<div class="addressInfo_button_div">
									<button class="address_btn address_btn_1" onclick="showAdress('1')" style="background-color: #3c3838;">사용자 정보 주소록</button>
									<button class="address_btn address_btn_2" onclick="showAdress('2')">직접 입력</button>
								</div>
								<div class="addressInfo_input_div_wrap">
									<div class="addressInfo_input_div addressInfo_input_div_1" style="display: block">
										<table>
											<colgroup>
												<col width="25%">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th>이름</th>
													<td>
														${memberInfo.memberName}
													</td>
												</tr>
												<tr>
													<th>주소</th>
													<td>
														${memberInfo.memberAddr1} ${memberInfo.memberAddr2}<br>${memberInfo.memberAddr3}
														<input class="selectAddress" value="T" type="hidden">
														<input class="member_name_input" value="${memberInfo.memberName}" type="hidden">
														<input class="address1_input" type="hidden" value="${memberInfo.memberAddr1}">
														<input class="address2_input" type="hidden" value="${memberInfo.memberAddr2}">
														<input class="address3_input" type="hidden" value="${memberInfo.memberAddr3}">										
													</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="addressInfo_input_div addressInfo_input_div_2">
										<table>
											<colgroup>
												<col width="25%">
												<col width="*">
											</colgroup>
											<tbody>
												<tr>
													<th>이름</th>
													<td>
														<input class="member_name_input">
													</td>
												</tr>
												<tr>
													<th>주소</th>
													<td>
														<input class="selectAddress" value="F" type="hidden">
														<input class="address1_input" readonly="readonly"> <a class="address_search_btn" onclick="execution_daum_address()">주소 찾기</a><br>
														<input class="address2_input" readonly="readonly"><br>
														<input class="address3_input" readonly="readonly">
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
	                    </fieldset>
	                    </div>
	
	                   <fieldset>
	                        <legend>최종 결제 정보</legend>
	                        <div class="total_info_div">
								<!-- 가격 종합 정보 -->
								<div class="total_info_price_div">
									<ul>
										<li>
											<span class="price_span_label">상품 금액</span>
											<span class="totalPrice_span"></span>원
										</li>
										<li>
											<span class="price_span_label">배송비</span>
											<span class="delivery_price_span"></span>원
										</li>
										<li class="price_total_li">
											<strong class="price_span_label total_price_label">최종 결제 금액</strong>
											<strong class="strong_red">
												<span class="total_price_red finalTotalPrice_span">
													
												</span>원
											</strong>
										</li>
									</ul>
								</div>
							</div>
	                   </fieldset>
	
						<!-- 결제 버튼 -->
	                    <div class="total_info_btn_div">
	                       <!--  <button class="order_btn right" onClick="proceedPay()">결제하기</button> -->
	                        <button class="order_btn right">결제하기</button> 
	                    </div>
	            	</div>
                </section>
                <!-- 주문 요청 form -->
				<form class="order_form" action="/goods/goodsPay" method="post">
					<!-- 주문자 회원번호 -->
					<input name="member_id" value="${memberInfo.memberId}" type="hidden">
					<!-- 주소록 & 받는이-->
					<input name="member_name" type="hidden">
					<input name="member_addr1" type="hidden">
					<input name="member_addr2" type="hidden">
					<input name="member_addr3" type="hidden">
					<!-- 상품 정보 -->
				</form>
		
	</body>
</html>