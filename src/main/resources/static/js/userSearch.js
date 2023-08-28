$(function(){
	$("#searchBtn").click(function(){
	 	if($("#userNo").val().replace(/\s/g, "") == ""){
			alert("일련번호를 입력해주세요.");
			$("#userNo").val("");
			$("#userNo").focus();
			return;
		}else if($("#userNo").val().search(/^\d+$/g)){
			alert("숫자로 입력하세요.");
			$("#userNo").val("");
			$("#userNo").focus();
			return;
		}else{
			$("#form1").attr({
		  	"method":"get",
		  	"action":"/Test1/selectUser"
		  	});
		  	$("#form1").submit();
		}
		
	});
});