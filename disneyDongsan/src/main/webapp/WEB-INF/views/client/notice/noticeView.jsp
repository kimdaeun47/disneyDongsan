<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>
      
      <style type="text/css">
      	.form-group {
			display: flex;
			align-items: center;
			float: right;
			margin-bottom: 10px;
			margin-top:30px;
		}
      
      	#keyword {
			font-size: 16px;
			width: 200px;
			height: 38px;
			outline: 2px solid #3c3c8c;
			border: none;
			margin-left: 10px;
		}
		
		#search {
			height: auto;
			display: inline-block;
			width: 150px;
			outline: 2px solid #3c3c8c;
			margin-left: 5px;
		}	
      
      	#searchData, #insertFormBtn {
			display: inline-block;
			height: 39px;
			width: 70px;
			font-weight: 600;
			font-size: 15px;
			line-height: 20px;
			margin-left: 10px;
			background-color: #3c3c8c;
			float: right;
			color:white;
		}
		
		#searchData:hover, #insertFormBtn:hover {
			border: 2px solid #3c3c8c;
			background-color: white;
			color:black;
		}
		
		.trColor th{background-color: #3c3c8c; color:white;}
		.page-item.active .page-link {
			 z-index: 4;
			 color: white;
			 font-weight:bold;
			 background-color: #3c3c8c;
			 border-color: #3c3c8c;
			 
		}
		
		h3{margin-top: 50px;}
		
		
      </style>
       
      
      <script type="text/javascript">
      	$(function(){
      		$(".goDetail").click(function(){
      			let n_num = $(this).parents("tr").attr("data-num");
				$("#n_num").val(n_num);
				$("#detailForm").attr({
					"method":"get",
					"action":"/notice/noticeDetail"
				});
				$("#detailForm").submit();
	      	});
      		
      		
      		
      		// 페이징 및 검색
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
			});
			
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
			})
      		
      		
      		
      	});// $ 종료
      	
     	// 검색을 위한 함수
		function goPage(){
			if($("#search").val()=="all"){
				$("#keyword").val("");
			}
			
			$("#searchForm").attr({
				"method":"get",
				"action":"/notice/noticeView"
			});
			$("#searchForm").submit();
			
		};
	      
      </script>
      
   </head>
   <body>
   	 <div class="container">
   	 
   	 	<!-- <div id="editor"></div>
   	 	<input type="hidden" id="quill_html" name="content"> -->
   	 	<form id="detailForm">
   	 		<input type="hidden" id="n_num" name="n_num" />
   	 	</form>
   	 	
   	 	<div class="text-center"><h3><strong>공지 사항</strong></h3></div><br/>
        <div class="notice_header">
             <%-- ================= 검색 기능 시작============================= --%>
		   		<div id="noticeSearch" class="text-right">
			   		<form id="searchForm" name="searchForm" class="form-inline">
			   			<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum }">
			   			<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount }">
			   			<div class="form-group">
				   			<select id="search" name="search" class="form-control" >
				   				<option value="all">전체 목록 조회</option>
				   				<option value="n_title">제목</option>
				   				<option value="n_content">내용</option>
				   			</select>
				   			<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력해 주세요" class="form-control"/>
				   			<button type="button" id="searchData" class="btn btn-success">검색</button>
			   			</div>
			   		</form>
		   		</div>
             
             
             <br>
       	</div>
       	
       	<!-- 데이터 출력 -->
       	<div>
	   		<table class="table table-hover">
				<thead>
					<tr >
						<th class="text-center">번호</th>
						<th class="text-center">제목</th>
						<th class="text-center">등록일</th>
					</tr>
				</thead>
				<tbody id="list" class="table-striped">
   					<!-- 데이터 출력 -->
   					<c:choose>
   						<c:when test="${not empty noticeList }">
   							<c:forEach var="notice" items="${noticeList}" varStatus="status">
							    <tr class="text-center" data-num="${notice.n_num}">
							        <td>${count-status.index}</td>
							        <td class="goDetail text-left">${notice.n_title}</td>
							        <td class="text-left">${notice.n_date}</td>
							        <%-- <td class="text-center">${notice.readcnt}</td> --%>
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
 		<!-- 데이터 출력 종료 -->
 		
 		<%--=======================페이징 출력 시작================= --%>
 		
 		<div class="pageMaker_wrap">
       		<ul class="pagination justify-content-center">
       			
       			<!-- 이전 버튼 -->
       			<c:if test="${pageMaker.prev }">
       				<li class="page-item prev">
       					<a class="page-link" href="${pageMaker.startPage -1}">이전</a>
       				</li>
       			</c:if>
       			
       			<!-- 페이지 번호 -->
       			<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
       				<li class="page-item ${pageMaker.cvo.pageNum == num ? 'active':''}">
       					<a class="page-link" href="${num}">${num}</a>
       				</li>	
       			</c:forEach>
       		
            	<!-- 다음 버튼 -->
            	<c:if test="${pageMaker.next}">
            		<li class="page-item next">
            			<a class="page-link" href="${pageMaker.endPage + 1 }">다음</a>
            		</li>
            	</c:if>
            </ul>
       	</div>
 		<!-- 페이징 종료 -->
 		
 		
 	  </div>
   </body>
</html>