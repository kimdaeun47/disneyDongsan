<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>

<!-- <link rel="stylesheet" href="../resources/include/css/goods/admin/goodsDetail.css"> -->
<link rel="stylesheet" href="/resources/include/css/commonDetail.css"/>


<script type="text/javascript">
	$(function(){
		
		//수정 버튼
		$("#goodsUpdateBtn").click(function(){
			actionProcess("get", "/admin/goodsUpdateForm");
		});
		
		//삭제 버튼
		$("#goodsDeleteBtn").click(function(){
			if(confirm("정말 삭제하시겠습니까?")){
				actionProcess("post", "/admin/goodsDelete");
			}
		});

		// 목록 버튼 클릭 시 처리 이벤트
		$("#goodsListBtn").click(function(){
			location.href="/admin/goodsList";
		});
	});
	
	
	function actionProcess(method, goUrl){	
		method==="get"? $("#g_image").remove(): "";
		$("#f_data").attr({
			"method":method,
			"action":goUrl
		});
		method==="get"? $("#g_image_detail").remove(): "";
		$("#f_data").attr({
			"method":method,
			"action":goUrl
		});
		$("#f_data").submit();
	}

</script>
</head>
<body>
 	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	
	<main id="main" class="main">
		<form name="f_data" id="f_data" method="get">
			<input type="hidden" name="g_id" value="${detail.g_id}"/>
			<input type="hidden" name="g_image" id="g_image" value="${detail.g_image}"/>
			<input type="hidden" name="g_image_detail" id="g_image_detail" value="${detail.g_image_detail}"/>
		</form>
		<div class="pagetitle">
			<h1>굿즈 상세 정보</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							 
	                    	<div class="contentTB">
	                    		<div class="btn_section text-right contentBtn">
		                    		<button type="button" id="goodsUpdateBtn" class="btn sty_btn">수정</button>
									<!-- <button type="button" id="goodsDeleteBtn" class="btn delete_btn">삭제</button> -->
									<button type="button" id="goodsListBtn" class="btn sty_btn">목록</button>
	                    		</div>
								<form action="/admin/goodsDetail" id="goodsDetail">
		                    		 <table class="table table-bordered">
		                    		 <colgroup>
					                   <col width="20%" />
					                   <col width="80%" />
					                </colgroup>
		                    		 
		                              <tr>
		                                 <td class="text-center">상품 이름</td>
		                                 <td>${detail.g_name}</td>
		                              </tr>
		                              <tr>
		                                 <td class="text-center">상품 상세 정보</td>
		                                 <td>${detail.g_detail}</td>
		                              </tr>
		                              <tr>
		                                 <td class="text-center">상품 가격</td>
		                                 <td>${detail.g_price}</td>
		                              </tr>
		                              <tr>
		                                 <td class="text-center">원산지</td>
		                                 <td>${detail.g_origin}</td>
		                              </tr>
		                              <tr>
		                                 <td class="text-center">제조사</td>
		                                 <td>${detail.g_company}</td>
		                              </tr>
		                              <tr>
		                                 <td class="text-center">배송업체</td>
		                                 <td>${detail.g_delivery}</td>
		                              </tr>
		                              <tr>
		                                 <td class="text-center">상품 이미지</td>
		                                 <td><img src="/dongsanStorage/goods/${detail.g_image}" /></td>
		                              </tr>
		                              <tr>
		                                 <td class="text-center">상품 상세 이미지</td>
		                                 <td><img src="/dongsanStorage/goods/${detail.g_image_detail}" /></td>
		                              </tr>
		                           </table>          		
	                   			</form>
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