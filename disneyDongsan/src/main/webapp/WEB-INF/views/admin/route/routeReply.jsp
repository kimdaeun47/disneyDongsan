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
	         
	         //비밀번호 확인 없이 삭제버튼 제어
 	         $(document).on("click", "button[data-btn='delBtn']", function() {
	        	 let replyNo = $(this).parents("div.panel1").attr("data-num");
	        	 deleteBtn(routeNo, replyNo);
	        	}); 
	      });//최상위 $ 종료.
	      
 	      
	      // 댓글 목록 보여주는 함수
	      function listAll(routeNo){
	         $(".reply").detach(); // 선택한 요소를 DOM 트리에서 삭제
	         let url = "/admin/replies/all/" + routeNo;
	         $.getJSON(url, function(data) {
	        	 
	            $(data).each(function(index){
	               let replyNo = this.replyNo;
	               let replyMemberId = this.replyMemberId;
	               let replyContent = this.replyContent;
	               let replyDate = this.replyDate;
	               replyContent = replyContent.replace(/(\r\n|\r|\n)/g, "<br />");
	               
	               template(replyNo, replyMemberId, replyContent, replyDate);
	               
	            });
 
	         }).fail(function(){
	            alert("댓글 목록을 불러오는데 실패했습니다.");
	         });

	      }
	      
	      
	      //글 삭제를 위한 Ajax 연동 처리
	      function deleteBtn(routeNo, replyNo){
	    	  if (confirm("선택하신 댓글을 삭제하시겠습니까?")){
	    		  $.ajax({
	    			url : '/admin/replies/' + replyNo,
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
	   </script>

	</head>
	<body>

		<%-- 리스트 영역 --%>
		<div id="reviewList">
			<div id="item-template" class="panel1">
				<div class="panel-div1">
					<h3 class="panel-div2">
						<button type="button" id="btn1" data-btn="delBtn" class="btn ">삭제</button>
						<span class="name"></span>
						<span class="panel-body"></span>
						<span class="date"></span><hr />
					</h3>
				</div>
			</div>	
		</div>
	</body>
</html>