// 빈칸 유효성 검사
// 함수명: chkData(유효성 체크 대상, 메시지 내용)
function chkData(item, msg) {
	if ($(item).val().replace(/\s/g, "") == "") {
		alert(msg + " 입력해주세요.");
		$(item).val("");
		$(item).focus();
		return false;
	} else {
		return true;
	}
};

function checkForm(item, msgArea, msg){
	if ($(item).val().replace(/\s/g, "") == "") {
		$(msgArea).text(msg + " 입력해주세요.").css("color","red");
		$(item).val("");
		$(item).focus();
		return false;
	} else {
		return true;
	}
};

function checkPrice(item, msg) {
	let reg = /^[0-9]+$/;;
	if (!reg.test($(item).val())) {
		alert(msg + " 입력해주세요.");
		$(item).val("");
		$(item).focus();
		return false;
	} else {
		return true;
	}
};

function idValidation(item){
	if($(item).val().length < 5 || $(item).val().length > 12){
		alert("아이디는 5자 이상 12자 이하로 작성해주세요");
		$(item).val('');
		$(item).focus();
		return false;
	} else {
		return true;
	}
}

function pwdValidation(item){
	let reg = /^(?=.*[a-zA-Z])((?=.*\d)(?=.*\W)).{8,16}$/;
	if(!reg.test($(item).val())){
		alert("비밀번호는 영문/숫자/특수문자(!@#$%^&*)를 포함하여 8~16자로 입력해야합니다.");
		$(item).select();
		return false;
	} else {
		return true;
	}
}

function emailValidation(item, span){
	let reg = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/;
	if(!reg.test($(item).val())){
		$(span).html("정확한 이메일 주소를 입력해주세요").css({"color":"red", "font-size":"13px"});
		$(item).select();
		return false;
	} else {
		return true;
	}
}

function phoneValidation(item, span){
	let reg = /^(?:(010\d{4})|(01[1|6|7|8|9]\d{3,4}))(\d{4})$/;
	if(!reg.test($(item).val())){
		//alert("정확한 전화번호를 입력해주세요");
		$(span).html("정확한 전화번호를 입력해주세요").css({"color":"red", "font-size":"13px"});
		$(item).select();
		return false;
	} else {
		return true;
	}
}

//함수명: chkFile(파일명 객체)
//설명: 이미지 파일 여부를 확인하기 위해 확장자 확인 함수.
//if (!chkFile($("#file"))) return;
function chkFile(item){
   //참고사항
   //(jQuery.inArray(찾을 값, 검색 대상의 배열): 배열매의 값을 찾아서 인덱스를 반환(요소가 없을 경우 -1반환)
   //pop():배열의 마지막 요소를 제거한 후, 제거한 요소를 반환
   let ext = item.val().split('.').pop().toLowerCase();
   if(jQuery.inArray(ext, ['gif', 'png', 'jpg']) == -1){
      alert('gif, png, jpg 파일만 업로드 할 수 있습니다.');
      item.val("");
      return false;
   }else{
      return true;
   }
}

function chkData1(item, msg){
    var value = $(item).val();
    if (!value || value.replace(/\s/g, "") === "") {
        alert(msg + " 입력해 주세요");
        $(item).val("");
        $(item).focus();
        return false;
    } else {
        return true;
    }
}