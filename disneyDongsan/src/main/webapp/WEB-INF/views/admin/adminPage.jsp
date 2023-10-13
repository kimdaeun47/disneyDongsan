<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>
<style>
	.card{
		display: inline-block;
		width: 30%;
		margin: 0 10px;
		text-align: center;
		height :300px;
	}
	
	.btn-primary{
			   display: inline-block;
		     height: 32px;
		     width: 150px;
		     font-weight: 600;
		     font-size: 15px;
		     line-height: 20px;
		     margin-left: 10px;
		     background-color: #c3daf7;
		     color: black; 
		     border-color: #c3daf7;
		     
			}
	.btn-primary:hover{
			  border: 2px solid #c3daf7;
			  background-color: white;
			  color: black;
			}
	.card-title{
		font-size: x-large;
		margin-bottom: 50px;
	}
	.count{
		font-size: 30px;
		margin-bottom: 50px;
	}
	</style>
	</head>

<body>
	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>

	<main id="main" class="main">

		<div class="card">
            <div class="card-body">
              <h5 class="card-title">최근 굿즈 주문 내역</h5>
              <p class="count">🎁 : ${noneDelivery}</p>
              <p class="card-text"></p>
              <p class="card-text"><a href="/admin/deliveryList" class="btn btn-primary">바로가기</a></p>
              
            </div>
          </div>
          
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">오늘 티켓 예매 수</h5>
              <p class="count">🎫 : ${ticketListCnt}</p>
              <p class="card-text"></p>
              <p class="card-text"><a href="/admin/ticketOrderList" class="btn btn-primary">바로가기</a></p>
              
            </div>
          </div>
          
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">답변 안한 문의</h5>
              <p class="count">❓ : ${answerListCnt }</p>
              <p class="card-text"></p>
              <p class="card-text"><a href="/admin/answerList" class="btn btn-primary">바로가기</a></p>
              
            </div>
          </div>
	</main>
	<!-- End #main -->

	<%@ include file="/WEB-INF/views/admin-template/footer.jsp"%>

	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
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