<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<link rel="stylesheet" type="text/css"
	href="/resources/include/css/ticket/modal.css" />

<script type="text/javascript">
		$(function(){

			//동의 모두선택 / 해제
			const agreeChkAll = document.querySelector('input[name=agree_all]');
			    agreeChkAll.addEventListener('change', (e) => {
			    let agreeChk = document.querySelectorAll('input[name=agree]');
			    for(let i = 0; i < agreeChk.length; i++){
			      agreeChk[i].checked = e.target.checked;
			    }
			});	
		
			// 약관 모두선택
			$("input[name=agree]").click(function(){
			    let total = $("input[name=agree]").length;
			    let checked = $("input[name=agree]:checked").length;
			         
			    if(total != checked)
			        $("#agree_all").prop("checked", false);
			    else 
			        $("#agree_all").prop("checked", true);
			});
			
			// 취소 클릭 시 입력값 초기화
			$(document).on("click", ".modal_close", function(){
				$(".check").prop("checked", false);
			})
			
		});
		</script>
<!-- ---------------모달------------------ -->

<div class="modal fade" id="myModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
			<h4 class="modal-title">약관동의</h4>
			<h6>아래 사항을 꼭 읽어보신 후 동의해 주세요!</h6>
	      </div>
	      <div class="modal-body">
	        <label for="agree_all"> <input type="checkbox"
						name="agree_all" id="agree_all" class="check"> <span>모두
							동의합니다</span>
					</label>
					<hr />
					<label for="agree"> <input type="checkbox" name="agree"
						value="1" id="check_1" class="check"> <span>이용약관 동의<strong>(필수)</strong></span>
					</label><br /> <label for="agree"> <input type="checkbox"
						name="agree" value="2" id="check_2" class="check"> <span>개인정보
							수집, 이용 동의<strong>(필수)</strong>
					</span>
					</label><br /> <label for="agree"> <input type="checkbox"
						name="agree" value="3" id="check_3" class="check"> <span>개인정보
							이용 동의<strong>(필수)</strong>
					</span>
					</label>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" id="ticketCancelBtn" class="btn-secondary" data-bs-dismiss="modal">취소</button>
			<input type="button" value="예약하기" id="ticketInsertBtn" class="btn-success" />
	      </div>
	    </div>
	  </div>
	</div>



<!-- <div class="modal fade" id="myModal" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-xl modal-dialog-centered">
		<div class="modal-content">

			Modal Header
			<div class="modal-header">
				<h4 class="modal-title">약관동의</h4>
				<h7>아래 사항을 꼭 읽어보신 후 동의해 주세요!</h7>
			</div>

			Modal body
			<div class="modal-body">
				<label for="agree_all"> <input type="checkbox"
					name="agree_all" id="agree_all" class="check"> <span>모두
						동의합니다</span>
				</label>
				<hr />
				<label for="agree"> <input type="checkbox" name="agree"
					value="1" id="check_1" class="check"> <span>이용약관 동의<strong>(필수)</strong></span>
				</label><br /> <label for="agree"> <input type="checkbox"
					name="agree" value="2" id="check_2" class="check"> <span>개인정보
						수집, 이용 동의<strong>(필수)</strong>
				</span>
				</label><br /> <label for="agree"> <input type="checkbox"
					name="agree" value="3" id="check_3" class="check"> <span>개인정보
						이용 동의<strong>(필수)</strong>
				</span>
				</label>
			</div>

			Modal footer
			<div class="modal-footer">
				<button type="button" class="modal_close btn btn-secondary"
					data-dismiss="modal">취소</button>
				<input type="button" value="예약하기" id="ticketInsertBtn"
					class="btn btn-success" />
			</div>

		</div>
	</div>
</div> -->
<!-- ---------------모달------------------ -->
