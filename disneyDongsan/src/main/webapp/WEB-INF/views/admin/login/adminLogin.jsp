<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>
<script>
	$(function(){
		let errorMsg = "${errorMsg}";
		if(errorMsg != ''){
			alert(errorMsg);
			errorMsg = '';
		};
		
		$("#adminLoginBtn").click(function(){
			if(!chkData("#adminId", "아이디를")) return;
			else if(!chkData("#adminPwd", "비밀번호를")) return;
			else {
				$("#adminLoginForm").attr({
					"method":"post",
					"action":"/admin/adminLogin"
				});
				$("#adminLoginForm").submit();
			}
		});
	});
</script>
</head>
<body>
	<main>
		<div class="container">
			<section
				class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
				<div class="container">
					<div class="row justify-content-center">
						<div
							class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

							<div class="d-flex justify-content-center py-4">
								<a href="index.html" class="logo d-flex align-items-center w-auto"> 
									<!-- <img src="assets/img/logo.png" alt="">  -->
									<span class="d-none d-lg-block">Disney동산</span>
								</a>
							</div>
							<!-- End Logo -->

							<div class="card mb-3">

								<div class="card-body">

									<div class="pt-4 pb-2">
										<h5 class="card-title text-center pb-0 fs-4">관리자 로그인</h5>
										<p class="text-center small">Enter your Id & password to login</p>
									</div>

									<form class="row g-3 needs-validation" id="adminLoginForm" novalidate>

										<div class="col-12">
											<label for="yourUsername" class="form-label">Id</label>
											<div class="input-group has-validation">
												<input type="text" name="adminId" class="form-control" id="adminId" required>
												<div class="invalid-feedback">Please enter your id.</div>
											</div>
										</div>

										<div class="col-12">
											<label for="yourPassword" class="form-label">Password</label>
											<input type="password" name="adminPwd" class="form-control" id="adminPwd" required>
											<div class="invalid-feedback">Please enter your password!</div>
										</div>

										<div class="col-12">
											<button class="btn btn-primary w-100" id="adminLoginBtn" type="button">로그인</button>
										</div>
									</form>

								</div>
							</div>

						</div>
					</div>
				</div>

			</section>

		</div>
	</main>
	<!-- End #main -->
</body>
</html>