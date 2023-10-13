<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>

<link rel="stylesheet" href="/resources/include/css/commonList.css">
<style type="text/css">
	.notice_quantity{
		float: left;
		padding: 10px;
	}

</style>

   
		<!-- 삭제 버튼을 눌렀을 때 실행될 JavaScript 함수 추가 -->
		<script type="text/javascript">
		    $(function(){
		    	// 상단 '공지 등록' 클릭 시 새로고침
		    	$(".page").click(function(){
		    		location.href="/admin/notice/noticeList";
		    	});
		    	
		    	// 등록 버튼 클릭 이벤트
		    	$("#insertBtn").click(function(){
		    		location.href = "/admin/notice/noticeInsertForm";
		    	});
		    	
		    	// 전체 체크
		    	$(".select-all-checkbox").click(function(){
	            	var chk = $(this).prop("checked");
	            	if(chk) {
	            	 $(".select-checkbox").prop("checked", true);
	                } else {
	            	 $(".select-checkbox").prop("checked", false);
	            	}
	            });
		    	
		    	
		    	// 상세 페이지 이벤트
		    	$(".goDetail").click(function(){
	            	let n_num = $(this).closest("tr").data("num");
	                
	                if (n_num !== "") {
	                    $.ajax({
	                        type: "get",
	                        url: "/admin/notice/noticeDetail",
	                        data: { n_num: n_num },
	                        success: function(data){
	                        	
	                            $("#detailInfo").html(data);
	                        },
	                        error: function(){
	                            alert("상세 정보를 불러오는 데 실패했습니다.");
	                        }
	                    });
	                } else {
	                    alert("유효하지 않은 번호입니다.");
	                }
	            });
		    	
		    	
		    	
		    	// 삭제 버튼 이벤트
		    	/*
		    	$("#deleteBtn").click(function(){
            		var selectedItems = [];
	            	
	            	$("input:checkbox:checked").each(function(){
	                    selectedItems.push($(this).closest("tr").data("num"));
	                });
	            	
	            	if(selectedItems.length === 0){
	                    alert("삭제할 항목을 선택하세요.");
	                }else{
	                	if(confirm("선택한 항목을 삭제하시겠습니까?")){
	                		$.ajax({
	                            type: "post",
	                            url: "/admin/notice/noticeDelete",
	                            data: { e_nos: selectedItems },
	                            success: function (data) {
	                                for (var i = 0; i < selectedItems.length; i++) {
	                                    $("tr[data-num='" + selectedItems[i] + "']").remove();
	                                }
	                                alert("선택한 항목이 삭제되었습니다.");
	                            },
	                            error: function () {
	                                alert("항목 삭제 중 오류가 발생했습니다.");
	                            }
	                        });
	                	}
	                }
		        }); */
		    	
		    	// 검색 및 페이징
		    	// 검색 후 검색 대상과 검색 단어 출력
				let word = "<c:out value='${noticeVO.keyword}'/>";
				let value = "";
				if(word!=""){
					$("#keyword").val("<c:out value='${noticeVO.keyword}' />");
					$("#search").val("<c:out value='${noticeVO.search}'/>");
					
					if($("#search").val()!='n_content'){
						if($("#search").val()=='n_title') value = "#list tr td.goDetail";
						
						$(value + ":contains('" + word + "')").each(function(){
							let regex = new RegExp(word, 'gi');	
							$(this).html($(this).html().replace(regex,"<span class='required'>" + word + "</span>"));
						})
					}
				};
				// 페이지 버튼 클릭시
				$(".page-item a").click(function(e){
					e.preventDefault();
					$("#searchForm").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				})
				
				//enter 제어
				$("#keyword").bind("keydown", function(e){
					if(e.keyCode == 13){
						$("#searchBtn").click();
					}
				});
				
				// 검색 대상 변경될때 처리
				$("#search").change(function(){
					if($("#search").val()=="all"){
						$("#keyword").val("전체 목록 조회합니다.");
						
					} else if($("#search").val() != "all"){
						$("#keyword").val("");
						$("#keyword").focus();
					}
				})
				
				// 검색 버튼 클릭 시 처리
				$("#searchBtn").click(function(){
					if($("#search").val()!="all"){
						if(!chkData("#keyword", "검색어를")) return;
					} 
					
					goPage();
				});
	
	    	
		    }); // $ 종료
		    
		 	// 검색을 위한 함수
			function goPage(){
				if($("#search").val()=="all"){
					$("#keyword").val("");
				}
				
				$("#searchForm").attr({
					"method":"get",
					"action":"/admin/notice/noticeList"
				});
				$("#searchForm").submit();
				
			};
			
			 // 선택된 항목 삭제 함수
	        function deleteSelectedItems() {
	            var selectedItems = [];
	            var checkboxes = document.getElementsByName('RowCheck');
	            
	            for (var i = 0; i < checkboxes.length; i++) {
	                if (checkboxes[i].checked) {
	                    selectedItems.push(checkboxes[i].value);
	                }
	            }
	            
	            if (selectedItems.length === 0) {
	                alert("선택된 항목이 없습니다.");
	                return;
	            }

	            if (confirm("영구적으로 삭제됩니다. 정말로 삭제하시겠습니까?")) {
	                var url = "/admin/notice/allNoticeDelete";
	                $.ajax({
	                    url: url,
	                    type: 'post',
	                    traditional: true,
	                    dataType: "text",
	                    data: {
	                        checkNumber: selectedItems
	                    },
	                    success: function(resultData) {
	                        if (resultData == "성공") {
	                            alert("삭제 성공하였습니다.");
	                            location.reload();
	                        } else {
	                            alert("삭제 실패하였습니다.");
	                            return;
	                        }
	                    }
	                });
	            } else {
	                return;
	            }
	        }

			 
			 
			 /*체크박스 전체체크와 부분체크*/
	        $(function() {
	           let chkObj = document.getElementsByName("RowCheck");
	           let rowCnt = chkObj.length;

	           $("input[name='allCheck']").click(function() {
	              let chk_listArr = $("input[name='RowCheck']");
	              for (let i = 0; i < chk_listArr.length; i++) {
	                 chk_listArr[i].checked = this.checked;
	              }
	           })

	           $("input[name='RowCheck']").click(function() {
	              if ($("input[name='Rowcheck']:checked").length == rowCnt) {
	                 $("input[name='allCheck']")[0].checked = true;
	              } else {
	                 $("input[name='allCheck']")[0].checked = false;
	              }
	           });
	        });
			 
	        /*체크박스*/
	        function deleteValue() {
	           let url = "/admin/notice/allNoticeDelete";
	           let valueArr = new Array();
	           let list = $("input[name='RowCheck']");
	           hasChecked = false; //체크 여부 변수

	           for (let i = 0; i < list.length; i++) { 
	              if (list[i].checked) { 
	                 hasChecked = true; 
	                 let answerCk = $(list[i]).parents("tr").children().eq(5).text(); 
	                 console.log("answerCk:" + answerCk);

	                 valueArr.push(list[i].value); 
	                 console.log("valueArr:" + valueArr);
	              }
	           }
	           if (!hasChecked) {
	              alert("선택된 글이 없습니다.");
	              return;
	           }

	           console.log("valueArr:" + valueArr);
	           if (confirm("영구적으로 삭제됩니다. 정말로 삭제하시겠습니까? ")) {
	              $.ajax({
	                 url : url,
	                 type : 'post',
	                 traditional : true,
	                 dataType : "text", 
	                 data : {
	                    checkNumber : valueArr
	                 },
	                 success : function(resultData) { 
	                    if (resultData == "성공") {
	                       alert("삭제 성공하였습니다.");
	                       actionProcess("post", url);
	                       location.reload(); 
	                    } else {
	                       alert("삭제 실패하였습니다.");
	                       return;
	                    }
	                 }
	              });
	           } else {
	              return;
	           }
	        }
		    
		</script>


      
   </head>
   <body>
   <%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>공지 관리</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="notice_header">
	        	<%-- ================= 검색 기능 시작============================= --%>
		   		<div id="eventSearch" class="search_wrap">
		   		
			   		<form id="searchForm" name="searchForm" class="form-inline">
			   			<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum }">
			   			<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount }">
			   			<div class="search_input">
				   			<select id="search" name="search" class="form-control" >
				   				<option value="all">전체 조회</option>
				   				<option value="n_title">제목</option>
				   				<option value="n_content">내용</option>
				   			</select>
				   			<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력해 주세요" class="form-control"/>
				   			<button type="button" id="searchBtn" class="btn search_btn">검색</button>
				   			<button type="button" id="insertBtn" class="btn insert_btn">추가</button>
		 					<input type="button" id="deleteFormBtn" class="btn delete_btn" value="삭제" onclick="deleteSelectedItems();"/>
			   			</div>
			   		</form>
		   		</div>
	             
	             
	       	</div>
       	
	   		<div class="notice_body">
	   			<%-- ========리스트 출력============ --%>
		   		<table class="table table-hover admin_table">
					<thead>
						<tr>
 							<th><input type="checkbox" id="allCheck" name="allCheck" class="text-left"/></th>
							<th class="text-center">번호</th>
							<th class="text-center">제목</th>
							<th class="text-center">등록일</th>
						</tr>
					</thead>
					<tbody id="list" class="table-striped">
	   					<!-- 데이터 출력 -->
	   					<c:choose>
	   						<c:when test="${not empty noticeList }">
	   							<c:forEach var="notice" items="${noticeList }" varStatus="status">
	   								<tr class="text-center" data-num="${notice.n_num }">
 	   									<td><input class="text-center" name="RowCheck" type="checkbox" value="${notice.n_num}"/></td>
	   									<td>${count-status.index}</td>
	   									<td class="goDetail text-left">${notice.n_title }</td> 
	   									<td class="text-left">${notice.n_date }</td>
<%-- 	   									<td class="text-center">${notice.readcnt }</td> --%>
	   								</tr>
	   							</c:forEach>
	   						</c:when>
	   						<c:otherwise>
	   							<tr>
	   								<td colspan="5" class="tac text-center">등록된 게시글이 존재하지 않습니다.</td>
	   							</tr>
	   						</c:otherwise>
	   					</c:choose>
		   			</tbody>
		 		</table>
	 		</div>
	 		
	 		<%-- 상세 정보 출력 --%>
	 		<div id="detailInfo">
        
        	</div>
        	
        	<%--=======================페이징 출력 시작================= --%>
	   		<div class="text-center">
	   			<ul class="pagination justify-content-center">
	   				<c:if test="${pageMaker.prev }">
	   					<li class="page-item previous">
	   						<a class="page-link" href="${pageMaker.startPage - 1 }">Previous</a>
	   					</li>
	   				</c:if>
	   				
	   				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
	   					<li class="page-item ${pageMaker.cvo.pageNum == num ? 'active' : '' }">
	   						<a class="page-link" href="${num }">${num }</a>
	   					</li>
	   				</c:forEach>
	   				
	   				<c:if test="${pageMaker.next }">
	   					<li class="page-item next">
	   						<a class="page-link" href="${pageMaker.endPage + 1 }">Next</a>
	   					</li>
	   				</c:if>
	   			</ul>
	   		</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<%@ include file="/WEB-INF/views/admin-template/footer.jsp"%>

	<script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
	<script type="text/javascript" src="/resources/include/js/common.js"></script>
	<script src="/resources/include/assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script src="/resources/include/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/include/assets/vendor/chart.js/chart.umd.js"></script>
	<script src="/resources/include/assets/vendor/echarts/echarts.min.js"></script>
	<script src="/resources/include/assets/vendor/quill/quill.min.js"></script>
	<script src="/resources/include/assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="/resources/include/assets/vendor/tinymce/tinymce.min.js"></script>
	<script src="/resources/include/assets/vendor/php-email-form/validate.js"></script>

	<!-- Template Main JS File -->
	<script src="/resources/include/assets/js/main.js"></script>

   </body>
</html>