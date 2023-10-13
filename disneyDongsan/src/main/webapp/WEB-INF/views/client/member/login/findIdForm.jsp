<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
<link rel="stylesheet" href="/resources/include/css/login.css">

<script>
	let phoneVeriStatus = false;
	
	$(function(){
		$(".veriDiv").css("visibility","hidden");
		
		$("#memberPhone").keydown(function(){
			$("#phoneChkSpan").html('');
		});
		
		/* 전화번호 인증번호 보내기 버튼 클릭 시 이벤트 */
		$("#sendMsgBtn").click(function(){
			phoneVeriStatus = false;
			$("#veriNum").val('');
			$("#veriNum").focus();
			
			if(!chkData("#memberName", "이름을")) return;
			else if(!chkData("#memberPhone", "전화번호를"))	return;
			else if(!phoneValidation("#memberPhone", "#phoneChkSpan"))	return;
			else {
				$.ajax({
					url:"/member/findIdMemberExists",
					type:"post",
					data:$("#findIdForm").serialize(),
					dataType:"text",
					success: function(data){
						console.log(data);
						if(data == "success"){
							sendSms();
							return;
						} else {
							$("#phoneChkSpan").html("입력하신 정보가 회원정보와 일치하지 않습니다.").css({"color":"red", "font-size":"12px"});
							$("#memberName").val('');
							$("#memberPhone").val('');
							$("#memberName").focus();
						}
					},
					error: (xhr, textStatus, errorThrown) => {
			        	alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
			        }
				});
			};
			
		});
	});
	
	function sendSms(){
		let phone = $("#memberPhone").val();
		$("#to").val(phone);
		
		$.ajax({
			url:"/sms/send",
			type:"post",
			data:$("#sendSmsForm").serialize(),
			success: function(data){
				console.log(data.statusName);
				if(data.statusName == "success"){
					console.log(data.createSmsKey);
					$("#phoneChkSpan").html("인증번호를 발송했습니다.").css({"color":"green", "font-size":"12px"});
					$("#memberName").attr("readonly", "readonly");
					$("#memberPhone").attr("readonly", "readonly");
					$(".veriDiv").css("visibility","visible");
					$("#phoneCheckBtn").unbind("click").bind("click", function(){
						let veriNum = $("#veriNum").val();
						if(data.createSmsKey == veriNum){
							phoneVeriStatus = true;
							if(phoneVeriStatus == false) {
								alert("전화번호 인증을 해주세요.");
								return;
							} else {
								$("#findIdForm").attr({
									"method":"post",
									"action":"/member/findId"
								});
								$("#findIdForm").submit();
							}
							veriNum = '';
						} else {
							$("#veriChkSpan").html("인증번호를 틀렸습니다. 다시 확인해주세요.").css({"color":"red", "font-size":"12px"});
						}
					});
				} else {
					alert("잠시 오류가 발생하였습니다. 관리자에게 문의하세요.");
				}
			},
			error: (xhr, textStatus, errorThrown) => {
		        alert(textStatus + " (HTTP-" + xhr.status + " / " + errorThrown + ")");
		    }
		});
	};
	
</script>
</head>
<body>
	<div class="loginContainer">
		<form id="sendSmsForm">
			<input type="hidden" id="to" name="to" value="">
		</form>
		<h3 class="text-center">아이디 찾기</h3>
		<p class="text-center">등록된 회원정보로 아이디를 찾으실 수 있습니다.</p>
		<hr>
		<form id="findIdForm">
			<div class="loginDiv">
				<div class="form-group">
					<input type="text" id="memberName" name="memberName" placeholder="이름"/>
				</div>
				<div class="form-group">
					<input type="text" id="memberPhone" name="memberPhone" placeholder="전화번호('-'를 제외하고 입력해주세요)" />
					<span id="phoneChkSpan"></span>
					<input type="button" class="button" id="sendMsgBtn" value="인증번호 보내기"/>
				</div>
				<div class="form-group veriDiv">
					<input type="text" id="veriNum" placeholder="인증번호 입력">
					<span id="veriChkSpan"></span>
					<input type="button" class="button" id="phoneCheckBtn" value="찾기"/>
				</div>
			</div>
		</form>
	</div>
</body>
</html>