<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<style type="text/css">
		.contentContainer{margin-bottom: 60px; margin-top:150px;}
		.good img{width: 50px;}
		.good{position: relative;text-align: right;}
		td img{width: 400px;}
		#updateFormBtn, #deleteBtn,#listBtn{
			display: inline-block;
			height: 39px;
			width: 70px;
			font-weight: 600;
			font-size: 15px;
			line-height: 20px;
			margin-left: 10px;
			background-color: #3c3c8c;
			float: right;
			margin-bottom:30px; 
			color:white;
		}
		#updateFormBtn:hover, #deleteBtn:hover, #listBtn:hover {
			border: 2px solid #3c3c8c;
			background-color: white;
			color:black;
		}
		.idImg{width:70px;margin-bottom: 15px;}
		.routeTitle{margin: 50px 0px 50px 0px;}
		.idText{margin-left: 10px;}
	</style>

   
   <script type="text/javascript">
      //let buttonCheck = 0;   // 수정버튼과 삭제버튼을 구별하기 위한 변수

      $(function(){
    	  	let routeNo = ${detail.routeNo};
        	let idVelue = '${detail.memberId}';
          	let idSessen = '${Member.memberId}';
          	
          	console.log(idSessen);

             if(idSessen != idVelue){
            	 $("#deleteBtn").css("visibility","hidden");
            	 $("#updateFormBtn").css("visibility","hidden");
             }
         //$("#pwdChk").css("visibility","hidden"); // visibility: 화면에 보이지 않으나 공간을 그대로 유지
      
         /* 수정 버튼 클릭 시 처리 이벤트 */
         $("#updateFormBtn").click(function(){
        	 goUrl = "/route/routeUpdateForm";
        	 $("#f_data").attr("action",goUrl);
             $("#f_data").submit();
         });

         /* 삭제 버튼 클릭 시 처리 이벤트 */
         $("#deleteBtn").click(function(){
             $.ajax({
             	url:"/route/routeReplyCnt",
             	type: "post",
             	data: "routeNo="+$("#routeNo").val(),
             	dataType:"text",
             	error:function(){
             		alert('시스템 오류. 관리자에게 문의 하세요');
             	},
             	success:function(resultData){
             		if(resultData==="0"){//댓글이 존재하지 않을 경우
                        if(confirm("정말 삭제하시겠습니까?")){
                       	 actionProcess("post", "/route/routeDelete");
                        }
             		}else{//댓글이 존재 존재하는 경우
             			//alert("댓글 존재시 게시물 작성할 수가 없습니다.\n 댓글 삭제 후 다시 확인해 주세요.");
             			//return;	
             			deleteReply(routeNo);
             		}
            	 }
          	});
         });
        	

         /* 목록 버튼 클릭 시 처리 이벤트 */
         $("#listBtn").click(function(){
            location.href = "/route/routeList";
         });
             
      });   // $ 종료문
      function divBtn() {
    	    $.ajax({
    	        type: 'GET',  // 또는 'POST', 서버로 전송할 HTTP 메서드 선택
    	        url: '/route/routeGoodcntUpdate?routeNo=${detail.routeNo}', // 좋아요 업데이트를 처리하는 서버의 URL
    	        success: function(response) {
    	            alert('좋아요를 눌렀습니다.');
    	            location.href = "/route/routeDetail?routeNo=${detail.routeNo}";
    	        },
    	        error: function() {
    	            alert('좋아요 업데이트에 실패했습니다.');
    	        }
    	    });
    	}

      

      function actionProcess(method, goUrl){
    	  method==="get"? $("#routeImage").remove():"";
    	  $("#f_data").attr({
    		  "method":method,
    		  "action":goUrl
    	  });
    	  $("#f_data").submit();
      }
      function deleteReply(routeNo){
    	    if (confirm("정말 삭제하시겠습니까?")) {
    	        $.ajax({
    	            url: "/route/replies/all/" + routeNo,
    	            type: "delete",
    	            headers: {
    	                "X-HTTP-Method-Override": "DELETE"
    	            },
    	            dataType: "text",
    	            error: function () {
    	                alert("시스템 오류. 관리자에게 문의 하세요");
    	            },
    	            success: function (result) {
    	                if (result === "SUCCESS") {
    	                    alert("게시물 삭제가 완료되었습니다.");
    	                    actionProcess("post", "/route/routeDelete");
    	                    listAll(routeNo);
    	                }
    	            }
    	        });
    	    }
    	};
      

      
   </script>
   
   </head>
   <body>
      <div class="contentContainer container">
      <!-- <div class="contentTit page-header"><h3 class="text-center">게시판 상세보기</h3></div> -->
      
      <form name="f_data" id="f_data" method="get">
         <input type="hidden" name="routeNo" value="${detail.routeNo}" />
         <input type="hidden" name="routeImage" id="routeImage" value="${detail.routeImage}" />
      </form>
	      <%-- =============== 삭제 및 수정 버튼 추가 시작 =============== --%>
	      <div id="boardPwdBut" class="row test-center">
	         <div class="btnArea col-md-12 text-right">
	         	<input type="hidden" name="routeNo" id="routeNo" value="${detail.routeNo}" />
	         	<input type="button" value="목록" id="listBtn" class="btn" />
	            <input type="button" value="글수정" id="updateFormBtn" class="btn" />
	            <input type="button" value="글삭제" id="deleteBtn" class="btn" />
	            <%--<input type="button" value="글쓰기" id="insertFormBtn" class="btn btn-success" />--%>
	            
	         </div>
	      </div>
	      <%-- =============== 삭제 및 수정 버튼 추가 종료 =============== --%>
	      
	      <%-- =============== 상세 정보 보여주기 시작 =============== --%>
	      <div class="contentTB">
	         <ul>
	         	<li>
	         		<img class="idImg" alt="/" src="/resources/images/route/s.PNG">
		            <span class="fs-5 idText">${detail.memberId}</span>
		            <span style="color:#787878;"> /${detail.routeDate}/</span>
		            <span style="color:#787878; float: right; margin-right: 25px;">(조회수: ${detail.routeHits})</span>
	         	</li>
	         	<li class="text-center routeTitle fs-2">${detail.routeTitle}</li>
	         	<li class="text-center">${detail.routeContent}</li>
	         	<li class="text-center">
	         		<c:if test="${not empty detail.routeImage}">
	         			<img alt="이미지 파일" src="/dongsanStorage/route/${detail.routeImage}" />
	         		</c:if>
	         	</li>
	         </ul>
	      </div>
	    <div class="good">
      		<img onclick='divBtn()' alt="/" src="/resources/images/route/good.PNG" /><span id="goodBtn"  style="font-size: 20px">${detail.routeGood}</span>
      	</div>
      	<%--===================상세 정보 보여주기 종료 ==================== --%>
      	<jsp:include page="routeReply.jsp" />
      </div>
   </body>
</html>