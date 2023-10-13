<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<style>
		#item-template{display:none;}
		#btn1, #replyInsertBtn{float: right; border: 1px solid gray; width: 40px; height: 22px; font-size: 12px; padding: 1px;
				background-color: #f6f5f4;margin: 2px;}
		.panel1{background-color: #f6f5f4; padding-top: 5px; margin: 5px;}
		.name{font-size: 20px; font-weight: 400;}
		.panel-body{font-size: 15px;}
		.date{font-size: 12px; color:#787878;}
		h3{  margin-block-start: 1px;
   				margin-block-end: 1px;
   				line-height: 0.8;}
   			
	</style>
	<script type="text/javascript">
	      $(function(){
	         // 기본 댓글 목록 불러오기
	         let routeNo = ${detail.routeNo};
	         listAll(routeNo);
	         

	         // 글입력을 위한 Ajax 연동 처리
	         //$("#replyInsertBtn").click(function(){
	         $(document).on("click", "#replyInsertBtn", function(){
	            let insertUrl = "/route/replies/replyInsert";
	            
	            // JSON.stringify(): javascript 값이나 객체를 json 문자열로 반환
	            let value = JSON.stringify({
	            	routeNo:routeNo,
	            	replyMemberId:$("#replyMemberId").text(),
	            	replyContent:$("#replyContent").val()
	            });
	            
	            $.ajax({
	               url : insertUrl,   // 전송 url
	               type: "post",
	               headers: {
	                  "Content-Type":"application/json"
	               },
	               dataType:"text",
	               data:value,
	               error:function(){
	                  alert("시스템 문제 발생");
	               },
	               beforeSend: function(){   // 전송 전 유효성 체크
	                  if(!checkForm("#replyContent", "댓글내용을")) return false;
	               },
	               success: function(result){   // 서버로부터 응답코드 200으로 정상 처리가 되었을 경우
	                  if(result == "SUCCESS"){
	                     alert("댓글 등록 완료");
	                     dataReset();
	                     listAll(routeNo);
	                  } else if(result == "NO_SESSION"){
	                	  location.href = "/member/loginForm";
	                  }
	               }
	            })
	         });
	         
	         
	         
	         
	         // 비밀번호 확인 없이 수정버튼 제어
 	         $(document).on("click", "button[data-btn='upBtn']", function() {
	        	let panel = $(this).parents("div.panel1");
	        	let replyNo = panel.attr("data-num");
	        	updateForm(replyNo, panel);
	        }); 
	         
	         /** 수정 폼 화면 구현 함수 */
	         function updateForm(replyNo, panel){
	            $("#replyForm .resetBtn").detach();
	   
	            $("#replyMemberId").val(panel.find(".panel-title .name").html());
	            $("#replyMemberId").prop("readonly", true);
	   
	            let content = panel.find(".panel-body").html();
	            content = content.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
	            $("#replyContent").val(content);
	   
	            $("#replyForm button[type='button']").attr("id", "replyUpdateBtn");
	            $("#replyForm button[type='button']").attr("data-rnum", replyNo);
	            $("#replyForm button[type='button']").html("수정");
	            
	            let resetButton = $("<button type='button' class='btn btn-success resetBtn'>");
	            resetButton.html("취소");
	            $("#replyForm .sendBtn").after(resetButton);
	         };
	         
	         // 수정하기 클릭시 동적으로 생성된 "취소" 버튼 이벤트 처리
	         $(document).on("click", ".resetBtn", function(){
	            dataReset();
	         })
	         
	         // 글 수정을 위한 ajax
	         $(document).on("click", "#replyUpdateBtn", function(){
	            let replyNo = $(this).attr("data-rnum");
	            
	            $.ajax({
	               url : '/route/replies/' + replyNo,   // 전송 url
	               type: "put",
	               headers: {
	                  "Content-Type":"application/json",
	                  "X-HTTP-Method-Override":"PUT"
	               },
	               data:JSON.stringify({
	            	   replyPasswd:$("#replyPasswd").val(),
	            	   replyContent:$("#replyContent").val()
	               }),
	               dataType:"text",
	               error:function(){
	                  alert("시스템 문제 발생");
	               },
	               beforeSend: function(){   // 전송 전 유효성 체크
	                  if(!checkForm("#replyContent", "댓글내용을")) return false;
	               },
	               success: function(result){   // 서버로부터 응답코드 200으로 정상 처리가 되었을 경우
	                  console.log("result: " + result);
	                  if(result == "SUCCESS"){
	                     alert("댓글 수정 완료");
	                     dataReset();
	                     listAll(routeNo);
	                  }
	               }
	            });
	         });
	         //비밀번호 확인 없이 삭제버튼 제어
 	         $(document).on("click", "button[data-btn='delBtn']", function() {
	        	 let replyNo = $(this).parents("div.panel1").attr("data-num");
	        	 deleteBtn(routeNo, replyNo);
	        	}); 
	      });//최상위 $ 종료.
	      
 	      
	      // 댓글 목록 보여주는 함수
	      function listAll(routeNo){
	         $(".reply").detach(); // 선택한 요소를 DOM 트리에서 삭제
	         let url = "/route/replies/all/" + routeNo;
	         $.getJSON(url, function(data) {
	        	 
	            $(data).each(function(index){
	               let replyNo = this.replyNo;
	               let replyMemberId = this.replyMemberId;
	               let replyContent = this.replyContent;
	               let replyDate = this.replyDate;
	               replyContent = replyContent.replace(/(\r\n|\r|\n)/g, "<br />");
	               
	               template(replyNo, replyMemberId, replyContent, replyDate);
	               
	               let idSessen = '${Member.memberId}';
	               if (idSessen != replyMemberId) {
	                   // 현재 사용자와 댓글 작성자가 다를 때
	                   let panel = $(".reply[data-num='" + replyNo + "']");
	                   panel.find("button[data-btn='upBtn']").css("visibility", "hidden");
	                   panel.find("button[data-btn='delBtn']").css("visibility", "hidden");
	               }
	            });
 
	         }).fail(function(){
	            alert("댓글 목록을 불러오는데 실패했습니다.");
	         });

	      }
	      
	      // 새로운 글을 화면에 추가하기(보여주기) 위한 함수
	      function template(replyNo, replyMemberId, replyContent, replyDate){
	         let $div = $('#reviewList');
	         
	         let $element = $('#item-template').clone().removeAttr('id');
	         $element.attr("data-num", replyNo);
	         $element.addClass("reply");
	         $element.find('.panel-div1 > .panel-div2 > .name').html(replyMemberId);
	         $element.find('.panel-div1 > .panel-div2 > .date').html(replyDate);
	         $element.find('.panel-body').html(replyContent);
	         
	         $div.append($element);
	      }
	      
	      // 입력 폼 초기화
	      function dataReset(){
	         $("#replyForm").each(function(){
	            this.reset();
	         });
	         
	         $("#replyMemberId").prop("readonly", false);
	         $("#replyForm button[type='button']").removeAttr("data-rnum");
	         $("#replyForm button[type='button']").attr("id", "replyInsertBtn");
	         $("#replyForm button[type='button'].sendBtn").html("저장");
	         $("#replyForm button[type='button'].resetBtn").detach();
	      }
	      
	      //글 삭제를 위한 Ajax 연동 처리
	      function deleteBtn(routeNo, replyNo){
	    	  if (confirm("선택하신 댓글을 삭제하시겠습니까?")){
	    		  $.ajax({
	    			url : '/route/replies/' + replyNo,
	    			type : 'delete',
	    			headers : {
	    				"X-HTTP-Method-Override" : "DELETE"
	    			},
	    			dataType : 'text',
	    			error:function(){
		                  alert("시스템 문제 발생");
		               },
		               success : function(result){
		            	   if(result == 'SUCCESS'){
		            		   alert("댓글 삭제가 완료되었습니다.");
		            		   listAll(routeNo);
		            	   }
		               }
	    		  
	    			});
	    	  }
	      }
	      
	      
	      
	   </script>

	</head>
	<body>
		<%-- 댓글 입력 화면 --%>
		<form id="replyForm" name="replyForm">
			<div class="panel panel-default">
				<table class="table">
					<tbody>
						<tr>
							<td class="col-md-8 text-left" id="replyMemberId" name="replyMemberId">${Member.memberId}</td>
							<!--<td class="col-md-2 text-left">
								<input type="text" id="replyMemberId" name="replyMemberId" maxlength="10" class="form-control" />
							</td>
							  <td class="col-md-1">비밀 번호</td>
							<td class="col-md-3 text-left">
								<input type="password" id="replyPasswd" name="replyPasswd" maxlength="18" class="form-control" />
							</td>-->
							<td class="col-md-6 btnArea text-right" >
								<button type="button" id="replyInsertBtn" class="btn">저장</button>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="col-md-11 text-left">
								<textarea class="form-control" id="replyContent" name="replyContent" rows="3" maxlength="333" placeholder="댓글을 입력해주세요"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
		<%-- 리스트 영역 --%>
		<div id="reviewList">
			<div id="item-template" class="panel1">
				<div class="panel-div1">
					<h3 class="panel-div2">
						<button type="button" id="btn1" data-btn="delBtn" class="btn ">삭제</button>
						<span class="name"></span><br />
						<span class="panel-body"></span><br />
						<span class="date"></span><hr />
					</h3>
				</div>
			</div>	
		</div>
	</body>
</html>