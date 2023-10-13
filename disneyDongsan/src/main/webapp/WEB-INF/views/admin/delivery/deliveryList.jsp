<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>

<link rel="stylesheet" href="../resources/include/css/goods/admin/deliveryList.css">


<script type="text/javascript">
    $(document).ready(function() {
        $("#deliveryStatus").on("change", function() {
            var selectedState = $(this).val();
            $(".orderList li").hide(); // 모든 주문 목록 숨김
            if (selectedState === "") {
                // "전체"가 선택된 경우 모든 주문 목록을 보여줍니다.
                $(".orderList li").show();
            } else {
                // 선택한 배송 상태를 가진 주문 목록만 표시합니다.
                $(".orderList li").each(function() {
                    var orderState = $(this).find(".delivery_state").text().trim();
                    if (orderState === selectedState) {
                        $(this).show();
                    }
                });
            }
        });
    });
</script>
</head>
<body>
 	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>배송 목록</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="container_box">
								<form id="deliveryStatusForm">
                                    <label for="deliveryStatus">배송 상태로 필터링:</label>
                                    <select id="deliveryStatus" name="deliveryStatus">
                                        <option value="">전체</option>
                                        <option value="배송준비">배송준비</option>
                                        <option value="배송중">배송중</option>
                                        <option value="배송완료">배송완료</option>
                                        <option value="배송취소">배송취소</option>
                                        <!-- 필요한 경우 다른 배송 상태 옵션을 추가하세요 -->
                                    </select>
                                </form>
                                <ul class="orderList">
                                    <c:forEach items="${orderList}" var="orderList">
                                        <li>
                                            <div>
                                                <p><span>주문번호</span><a href="/admin/deliveryListDetail?n=${orderList.g_order_id}">${orderList.g_order_id}</a></p>
                                                <p><span>주문자</span>${orderList.member_id}</p>
                                                <p><span>수령인</span>${orderList.member_name}</p>
                                                <p><span>주소</span>(${orderList.member_addr1}) ${orderList.member_addr2} ${orderList.member_addr3}</p>
                                                <p class="delivery_state">${orderList.g_order_state}</p>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                        	</div>
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