<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width-device-width, initial-scale=1.0 maximum-scale=1.0, minimum-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>Insert title here</title>
<link rel="shortcut icon" href="/resources/image/icon.png" />
<link rel="apple-touch-icon" href="/resources/image/icon.png" />
<!--[if lt IE 9]>
		<script src="/resources/js/html5shiv.js"></script>
		<![endif]-->
<link rel="stylesheet" href="/resources/include/dist/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/include/css/main.css" />
<link rel="stylesheet" href="/resources/include/css/header.css" />
<link rel="stylesheet" href="/resources/include/css/Remypage.css" />
<link rel="stylesheet" href="/resources/include/css/mypageUserInfo.css">

<script type="text/javascript" src="/resources/include/js/common.js"></script>
<script type="text/javascript" src="/resources/include/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	
	let phoneCheckStatus = false;
	let emailCheckStatus = false;
	let pwdCheckStatus = false;
	
	$(function(){
		$(".nav-link").click(function() {
			$(".nav-link").removeClass("active");
			$(this).addClass("color");
		});
		
		let errorMsg = "${errorMsg}";
		if(errorMsg != ''){
			alert(errorMsg);
			errorMsg = '';
		};
		
		/* 전화번호 모달창 벗어났을 때 값 초기화 */
		$("#pwdModal").on("hidden.bs.modal", function(e){
			$("#memberPasswd").val('');
			$("#new_password").val('');
			$("#chk_password").html('');
		});
		
		$("#memberPasswd").keydown(function(){
			$("#pwdChkSpan").text("");
		});
		
		$("#new_password").keydown(function(){
			pwdCheckStatus = false;
			$("#chkmsg").text("");
		});
		
		$("#chk_password").keyup(function() {
			let new_password = $("#new_password").val();
			let chk_password = $("#chk_password").val();

			if (new_password !== chk_password) {
				if(new_password != ''){
					pwdCheckStatus = false;
					$('#chkmsg').text("비밀번호가 일치하지 않습니다.").css({"color":"red", "font-size":"13px"});
				}
			} else{ 
				if(new_password != ''){
					pwdCheckStatus = true;
					$('#chkmsg').text("비밀번호가 일치합니다.").css({"color":"green", "font-size":"13px"});
				}	
			}
		});
								
			$("#pwdUpdate").click(function() {
				if (!chkData("#memberPasswd", "현재 비밀번호를")) return;
				else if (!chkData("#new_password", "새 비밀번호를")) return;
				else if (!pwdValidation("#new_password")) return;
				else if (!chkData("#chk_password", "새 비밀번호 확인을")) return;
				else if (pwdCheckStatus == false) {alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다."); $("#new_password").focus(); return;}
				else {
					$.ajax({
						url : "/mypage/pwdChk",
						type : "post",
						data : $("#f_updateForm").serialize(),
						dataType : "text",
						error : function() {
							alert('시스템 오류 입니다. 관리자에 문의하세요');
						},
						success : function(resultData) {
							if (resultData == "실패") {
								$("#pwdChkSpan").html("현재 비밀번호가 정확하지 않습니다.").css({"color":"red", "font-size":"13px"});
								$("#memberPasswd").select();
							} else if(resultData == "성공") {
								alert("비밀번호가 변경되었습니다. 다시 로그인해주세요.")	
								$("#f_updateForm").attr({
									"method" : "post",
									"action" : "/mypage/userPwChange"
								});
								$("#f_updateForm").submit();
							}	
						}
					});
				}
				
				
			});
		
		/* 전화번호 모달 : 전화번호 input keydown 이벤트 */
		$("#memberPhone").keydown(function(){
			$("#phoneChkSpan").html('');
		});
		
		/* 전화번호 모달 : 인증번호 보내기 클릭 시 이벤트 */
		$("#sendSmsBtn").click(function(){
			phoneCheckStatus = false;

			let memberPhone = $("#phone").val();
			let inputPhone = $("#memberPhone").val();

			$("#to").val(inputPhone);
			
			if (!chkData("#memberPhone","전화번호를"))		return;
			else if (!phoneValidation("#memberPhone", "#phoneChkSpan"))		return;
			else if("${Member.memberPhone}" == inputPhone){
				$("#phoneChkSpan").html("현재 등록된 휴대전화 정보와 동일합니다.").css({"color":"red", "font-size":"13px"});
				$("#memberPhone").select();
			} else {
				$("#veriNum").focus();
				$.ajax({
					url:"/sms/send",
					type:"post",
					data:$("#sendSmsForm").serialize(),
					success: function(data){
						phoneCheckStatus = false;
						console.log(data.statusName);
						if(data.statusName == "success"){
							/* 인증번호 확인 버튼 클릭 시 이벤트 */
							$("#phoneChkSpan").html('인증번호를 전송했습니다.').css({"color":"green", "font-size":"13px"});
							$("#phoneCheckBtn").unbind("click").bind("click", function(){
								let veriNum = $("#veriNum").val();
								if(data.createSmsKey == veriNum){
									phoneCheckStatus = true;
									$("#phoneChkSpan").html('인증을 성공하였습니다.').css({"color":"green", "font-size":"13px"});
									
									$("#updatePhoneForm").attr({
										"method":"post",
										"action":"/member/updateInfoPhone"
									});
									$("#updatePhoneForm").submit();
								
								} else {
									phoneCheckStatus = false;
									$("#phoneChkSpan").html('인증번호가 올바르지 않습니다. 확인 후 다시 입력해 주세요.').css({"color":"red", "font-size":"13px"});
								}
							});
						}
					},
					error: (xhr, textStatus, errorThrown) => {
						phoneCheckStatus = false;
			        	alert("시스템 오류입니다. 관리자에게 문의하세요.");
			        }
				});
			}
		});
		
		/* 전화번호 모달창 벗어났을 때 값 초기화 */
		$("#phoneModal").on("hidden.bs.modal", function(e){
			$("#memberPhone").val('');
			$("#veriNum").val('');
			$("#phoneChkSpan").html('');
		});
		
		
		/* 이메일 인증번호 보내기 버튼 클릭 시 이벤트*/		
		$("#emailtestBtn").click(function(){
			if(!chkData("#memberEmail", "이메일을")) return;
			else if (!emailValidation("#memberEmail", "#emailConfirm"))		return;
			else {
				const memberEmail = $("#memberEmail").val(); // 사용자가 입력한 이메일을 가져옴
	 	        $.post("/mail/process", { memberEmail: memberEmail }, function(response){
	 	        	//서버로부터 받은 응답을 처리
	 	        	randomString = response;
	 	        	console.log(response);
	 	        	$("#emailConfirm").html('인증번호가 발송되었습니다').css({"color":"green", "font-size":"13px"});
	 	        	$("#emailtest").focus();
	 	        	emailCheckStatus = false;
	 	        	
	 	        	/* 이메일 인증번호 확인 버튼 클릭 시 이벤트 */
	 	        	$("#emailtestBtn2").click(function() {
	 	    	    	if(!chkData("#emailtest", "인증번호를")) return;
	 	    	         
	 	    	    	//인증번호 일치하는지 확인
	 	    	    	if($("#emailtest").val()==randomString){
	 	    	        	$('#emailConfirm').html('인증되었습니다').css({"color":"green", "font-size":"13px"});
	 	    	    		emailCheckStatus = true;
	 	    	    		
	 	    	    		$("#updateEmailForm").attr({
								"method":"post",
								"action":"/member/updateInfoEmail"
							});
							$("#updateEmailForm").submit();
	 	    	    	} else {
	 	    	        	$('#emailConfirm').html('인증번호가 일치하지 않습니다').css({"color":"red", "font-size":"13px"});
	 	    	    	}
	 	    	    	console.log("randomString:"+randomString);
	 	    	    	console.log("사용자 입력값:"+$("#emailtest").val());
	 	    	   	});
	 	        });
			}
 	        
 	    });
		
		/* 이메일 모달창 벗어났을 때 값 초기화 */
		$("#emailModal").on("hidden.bs.modal", function(e){
			$("#memberEmail").val('');
			$("#emailtest").val('');
			$("#emailConfirm").html('');
		});
		
		/* 주소 찾기 버튼 클릭 시 이벤트 */
		$("#findAddrBtn").click(function(){
			findAddr();
		});
		
		/* 주소 변경 버튼 클릭 시 이벤트 */
		$("#updateAddr").click(function(){
			if (!chkData("#memberAddr1","주소를")){ findAddr();	return;}
			else if (!chkData("#memberAddr3","상세 주소를"))	return;
			else {
				$("#updateAddrForm").attr({
					"method":"post",
					"action":"/member/updateInfoAddr"
				});
				$("#updateAddrForm").submit();
			}
		});
		
		/* 주소 모달창 벗어났을 때 값 초기화 */
		$("#addrModal").on("hidden.bs.modal", function(e){
			$("#memberAddr1").val('');
			$("#memberAddr2").val('');
			$("#memberAddr3").val('');
		});
	});
	
	/* 주소 API 함수 */
	function findAddr(){
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
                 $("#memberAddr1").val(data.zonecode);
                 $("#memberAddr2").val(addr);            
                 // 커서를 상세주소 필드로 이동한다.
                 $("#memberAddr3").attr("readonly", false);
                 $("#memberAddr3").focus();    
            }
        }).open();     
    }
</script>
</head>
<body>
	<div class="divBody">

		<!-- 헤더 -->
		<div id="header">
			<tiles:insertAttribute name="mypage_header" />
		</div>



		<div class="mypage-body">
			<tiles:insertAttribute name="mypage_sidebar" />
			<!-- 바디 -->
			<div class="mypage_div col-9">
				<div class="container">
					<h3 class="fw-bold">나의 정보 수정</h3>
					<hr>
					<form id="sendSmsForm">
						<input type="hidden" id="to" name="to">
					</form>
					<div id="userInfoDiv">
						<form id="updateInfoForm">
							<ul>
								<li>
									<div class="row-item align-middle">
										<label><img src="/resources/img/id.png"></label> <span>${Member.memberId}</span>
									</div>
								</li>
								<li>
									<div class="row-item">
										<label><img src="/resources/img/user.png"></label> <span>${Member.memberName}</span>
									</div>
								</li>
								<li>
									<div class="row-item">
										<label><img src="/resources/img/password.png"></label> <span>비밀번호</span>
										<button type="button" class="button" data-bs-toggle="modal"
											data-bs-target="#pwdModal">수정</button>
									</div>
								</li>
								<li>
									<div class="row-item">
										<label><img src="/resources/img/phone.png"></label> <span>${Member.memberPhone}</span>
										<button type="button" class="button" data-bs-toggle="modal"
											data-bs-target="#phoneModal">수정</button>
									</div>
								</li>
								<li>
									<div class="row-item">
										<label><img src="/resources/img/email.png"></label> <span>${Member.memberEmail}</span>
										<button type="button" class="button" data-bs-toggle="modal"
											data-bs-target="#emailModal">수정</button>
									</div>
								</li>
								<li>
									<div class="row-item">
										<label><img src="/resources/img/address.png"></label> <span>${Member.memberAddr2}
											&nbsp;${Member.memberAddr3}&nbsp;(${Member.memberAddr1})</span>
										<button type="button" class="button" data-bs-toggle="modal"
											data-bs-target="#addrModal">수정</button>
									</div>
								</li>
							</ul>
						</form>
					</div>
				</div>


				<%-- ===================== 모달창 - 비밀번호 ===================== --%>
				<div class="modal fade" id="pwdModal" aria-hidden="true"
					aria-labelledby="exampleModalToggleLabel" tabindex="-1">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title fw-bold" id="exampleModalToggleLabel">
									<img src="/resources/img/mickeymouse.png">비밀번호 수정
								</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<form id="f_updateForm" name="f_updateForm" method="post">
									<input type="hidden" name="memberId" id="memberId"
										value="${Member.memberId}">
									<div>
										<input type="password" id="memberPasswd" name="memberPasswd"
											placeholder="현재 비밀번호" class="modal-input" /> <br>
										<span id="pwdChkSpan"></span> <input type="password"
											id="new_password" name="new_password" placeholder="새 비밀번호"
											class="modal-input" /> <input type="password"
											id="chk_password" name="chk_password" placeholder="새 비밀번호 확인"
											class="modal-input" /> <br>
										<span id="chkmsg"></span>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" id="pwdUpdate" class="modal-button">변경</button>
							</div>
						</div>
					</div>
				</div>

				<%-- ===================== 모달창 - 전화번호 ===================== --%>
				<div class="modal fade" id="phoneModal" aria-hidden="true"
					aria-labelledby="exampleModalToggleLabel" tabindex="-1">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title fw-bold" id="exampleModalToggleLabel">
									<img src="/resources/img/mickeymouse.png">전화번호 수정
								</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<strong class="fs-5">${Member.memberName}</strong>님의 회원정보 중 <span
									class="modal-span">전화번호</span>를 수정하기 위해 인증절차가 필요합니다.
								<hr color="black">
								<form id="updatePhoneForm">
									<input type="hidden" id="memberId" name="memberId"
										value="${Member.memberId}">
									<p>
										<img src="/resources/img/phone.png">${Member.memberPhone}</p>
									<div></div>
									<input type="text" id="memberPhone" name="memberPhone"
										placeholder="전화번호" class="modal-input">
									<button type="button" id="sendSmsBtn" class="modal-button">인증번호
										보내기</button>
									<input type="text" id="veriNum" placeholder="인증번호 입력"
										class="modal-input"> <br>
									<span id="phoneChkSpan"></span>
								</form>

							</div>
							<div class="modal-footer">
								<button type="button" id="phoneCheckBtn" class="modal-button">변경</button>
							</div>
						</div>
					</div>
				</div>

				<%-- ===================== 모달창 - 이메일 ===================== --%>
				<div class="modal fade" id="emailModal" aria-hidden="true"
					aria-labelledby="exampleModalToggleLabel" tabindex="-1">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title fw-bold" id="exampleModalToggleLabel">
									<img src="/resources/img/mickeymouse.png">이메일 수정
								</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<strong class="fs-5">${Member.memberName}</strong>님의 회원정보 중 <span
									class="modal-span">이메일</span>을 수정하기 위해 인증절차가 필요합니다.
								<hr>
								<form id="updateEmailForm">
									<input type="hidden" id="memberId" name="memberId"
										value="${Member.memberId}">
									<p>
										<img src="/resources/img/email.png">${Member.memberEmail}</p>
									<input type="text" id="memberEmail" name="memberEmail"
										placeholder="이메일" class="modal-input">
									<button type="button" id="emailtestBtn" class="modal-button">인증번호
										보내기</button>
									<input type="text" id="emailtest" name="emailtest"
										placeholder="인증번호 입력" class="modal-input" /> <br>
									<span id="emailConfirm"></span>
								</form>

							</div>
							<div class="modal-footer">
								<button class="modal-button" id="emailtestBtn2">변경</button>
							</div>
						</div>
					</div>
				</div>

				<%-- ===================== 모달창 - 주소 ===================== --%>
				<div class="modal fade" id="addrModal" aria-hidden="true"
					aria-labelledby="exampleModalToggleLabel" tabindex="-1">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title fw-bold" id="exampleModalToggleLabel">
									<img src="/resources/img/mickeymouse.png">주소 수정
								</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<form id="updateAddrForm">
									<input type="hidden" id="memberId" name="memberId"
										value="${Member.memberId}">
									<p>
										<img src="/resources/img/address.png">${Member.memberAddr2}
										&nbsp;${Member.memberAddr3}&nbsp;(${Member.memberAddr1})
									</p>
									<input class="selectAddress" value="F" type="hidden"> <input
										type="text" readonly="readonly" id="memberAddr1"
										name="memberAddr1" placeholder="우편번호" class="modal-input" />
									<button type="button" id="findAddrBtn" class="modal-button">주소
										찾기</button>
									<br> <input type="text" readonly="readonly"
										id="memberAddr2" name="memberAddr2" placeholder="주소"
										class="modal-input" /> <input type="text" readonly="readonly"
										id="memberAddr3" name="memberAddr3" placeholder="상세주소"
										class="modal-input" />
								</form>
							</div>
							<div class="modal-footer">
								<button class="modal-button" id="updateAddr">저장</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 바디 끝 -->

		</div>

		<div>
			<footer
				class="d-flex flex-wrap justify-content-between align-items-center py-3  border-top">
				<tiles:insertAttribute name="footer" />
			</footer>
		</div>
	</div>
	
</body>
</html>