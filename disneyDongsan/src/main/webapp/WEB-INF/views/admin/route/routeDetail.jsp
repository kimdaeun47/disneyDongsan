<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>
	<style type="text/css">
		.contentContainer{margin-bottom: 60px;}
		.good img{

			width: 50px;
		}
		.good{
			position: relative;
			text-align: right;
		}
		td img{
			width: 400px;
		}
		
		.contentTB{margin: auto; padding:50px 30px 30px 30px;}
		
		.text-left{text-align: left;}
      	.text-right{text-align: right;}
      	.text-center{text-align: center;}
      	
      	#deleteBtn, #listBtn{
            display: inline-block;
            height: 32px;
            width: 70px;
            font-weight: 600;
            font-size: 15px;
            line-height: 20px;
            margin-left: 10px;
            background-color: #c3daf7;  
         }
         
         #deleteBtn:hover, #listBtn:hover{
           border: 2px solid #c3daf7;
           background-color: white;
         }
         
	</style>

   
   <script type="text/javascript">

      $(function(){
    	  	let routeNo = ${detail.routeNo};

         $("#deleteBtn").click(function(){
             $.ajax({
             	url:"/admin/adminRouteReplyCnt",
             	type: "post",
             	data: "routeNo="+$("#routeNo").val(),
             	dataType:"text",
             	error:function(){
             		alert('시스템 오류. 관리자에게 문의 하세요');
             	},
             	success:function(resultData){
             		if(resultData==="0"){//댓글이 존재하지 않을 경우
                        if(confirm("정말 삭제하시겠습니까?")){
                       	 actionProcess("post", "/admin/routeDelete");
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
            location.href = "/admin/routeList";
         });
             
      });   // $ 종료문

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
  	            url: "/admin/replies/all/" + routeNo,
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
  	                    actionProcess("post", "/admin/routeDelete");
  	                    listAll(routeNo);
  	                }
  	            }
  	        });
  	    }
  	}; 
   </script>
   
   </head>
   <body>
    <%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
            					
	
	<main id="main" class="main">
	
		<div class="pagetitle">
			<h1>추천 코스 게시물 상세</h1> 
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">  
      						<form name="f_data" id="f_data" method="get">
						         <input type="hidden" name="routeNo" value="${detail.routeNo}" />
						         <input type="hidden" name="routeImage" id="routeImage" value="${detail.routeImage}" />
					      </form>
					      
					      <%-- =============== 삭제 버튼 추가 시작 =============== --%>
					      <div >
					         <div class="col-md-12 text-right">
					         	<input type="hidden" name="routeNo" id="routeNo" value="${detail.routeNo}" />
					            <input type="button" value="삭제" id="deleteBtn" class="btn sty_btn" />
					            <input type="button" value="목록" id="listBtn" class="btn sty_btn" />
					         </div>
					      </div>
					      <%-- =============== 삭제 버튼 및 버튼 추가 종료 =============== --%>
      
					      <%-- =============== 상세 정보 보여주기 시작 =============== --%>
					      <div class="contentTB text-center">
					         <table class="table table-bordered">
					            <tbody>
					               <tr>
					                  <td class="col-md-2">작성자</td>
					                  <td class="col-md-2 text-left" id="id">${detail.memberId}</td>
					                  <td class="col-md-2">작성일</td>
					                  <td class="col-md-2 text-left">${detail.routeDate}</td>
					                  <td>(조회수: ${detail.routeHits})</td>
					               </tr>
					               <tr>
					                  <td class="col-md-2">글제목</td>
					                  <td colspan="4" class="col-md-8 text-left">${detail.routeTitle}</td>
					               </tr>
					               <tr class="table-tr-height">
					                  <td class="col-md-2">글내용</td>
					                  <td colspan="4" class="col-md-8 text-left">${detail.routeContent}</td>
					               </tr>
					               <c:if test="${not empty detail.routeImage}">
						               <tr>
						                  <td class="col-md-2">이미지</td>
						                  <td colspan="4" class="col-md-8 text-left">
						                  	<img src="/dongsanStorage/route/${detail.routeImage}" />
						                  </td>
						               </tr>
					               </c:if>
					            </tbody>
					         </table>
					      </div>
					    <div class="good">
				      		<img alt="/" src="/resources/images/route/good.PNG" /><span id="goodBtn"  style="font-size: 20px">${detail.routeGood}</span>
				      	</div>
				      	<%--===================상세 정보 보여주기 종료 ==================== --%>
				      	<jsp:include page="routeReply.jsp" />
				      						</div>
									</div>
								</div>
							</div>
						</section>
					</main>
	
	
<%@ include file="/WEB-INF/views/admin-template/footer.jsp"%>

	<script type="text/javascript"
		src="/resources/include/js/jquery-3.7.0.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
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