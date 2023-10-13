<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<style type="text/css">
		td img {width: 150px;}
		.contentContainer {margin-bottom: 60px;}
		.required {color: blue;}
		#b_header {
			text-align: center;
			width: 1300px;
			margin: auto;
		}
		#movementImg img {width: 600px; margin: 20px;}
		#b_body {whdth: 1000px; margin: auto;}
		td img {width: 150px;}
		.title {padding:50px 30px 30px 30px;}
		
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
		.form-group {
			display: flex;
			align-items: center;
			float: right;
			margin-bottom: 10px;
			margin-top:30px;
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
		.titleImg{width: 100px; padding-bottom: 10px;}
		
		/* .textSub{background-color:#c3daf7; height: 100px; padding:20px;} */
</style>
	<script type="text/javascript">
		$(function() {
			//검색 후 검색 대상과 검색 단어 출력
			let word = "<c:out value='${routeVO.keyword}' />";
			let value = "";
			if (word != "") {
				$("#keyword").val("<c:out value='${routeVO.keyword}' />");
				$("#search").val("<c:out value='${routeVO.search}' />");

				if ($("#search").val() != 'routeContent') {
					//:contains()는 텍스트를 포함한 요소반환
					if ($("#search").val() == 'routeTitle')
						value = "#list tr td.goDetail";
					else if ($("#search").val() == 'memberId')
						value = "#list tr td.name";
					console.log($(value + ":contains('" + word + "')").html());

					//$("#list tr td.doDetail:contains('노력')").html()=><span class='required'>노력</span>에 대한 명언
					$(value + ":contains('" + word + "')").each(
							function() {
								let regex = new RegExp(word, 'gi');
								$(this).html(
										$(this).html().replace(
												regex,
												"<span class='required'>"
														+ word + "</span>"));
							});
				}
			}
			//입력 양식 enter 제거
			$("#keyword").bind("keydown", function(event) {
				if (event.keyCode == 13) {
					event.preventDefault();
				}
			});

			//검색 대상이 변경될 때마다 처리 이벤트
			$("#search").change(function() {
				if ($("#search").val() == "all") {
					$("#keyword").val("전체 목록 조회 합니다.");
					$("#keyword").attr("readonly", true);
				} else if ($("#search").val() != "all") {
					$("#keyword").val("");
					$("#keyword").focus();
					$("#keyword").removeAttr("readonly");
				}
			});

			//검색 버튼 클릭 시 처리 이벤트
			$("#searchData").click(function() {
				if ($("#search").val() != "all") { //제목/내용/작성자 선택시 검색어 유효성 체크
					if (!chkData("#keyword", "검색어를"))
						return;
				}
				$("#pageNum").val(1);//페이지 초기화
				goPage();
			});

			//글쓰기 버튼 클릭 시 처리 이벤트
			$("#insertFormBtn").click(function() {
				//console.log("글쓰기 버튼 클릭");//콘솔에 출력하는 이유는 이벤트가 정상적으로 실행되는지 확인하기 위해서
				location.href = "/route/routeInsertForm";
			});

			//제목 클릭시 상세 페이지 이동을 위한 처리 이벤트
			$(".goDetail").click(function() {
				let routeNo = $(this).parents("tr").attr("data-num");
				$("#routeNo").val(routeNo);
				console.log("글번호 : " + routeNo);
				//상세 페이지로 이동하기 위한 form 추가(id: detailForm)
				$("#detailForm").attr({
					"method" : "get",
					"action" : "/route/routeDetail"
				});
				$("#detailForm").submit();

			});

			$(".paginate_button a").click(
					function(e) {
						e.preventDefault();
						$("#f_search").find("input[name='pageNum']").val(
								$(this).attr("href"));
						goPage();
					})
		});

		//검색을 위한 실질적인 처리 함수
		function goPage() {
			if ($("#search").val() == "all") {
				$("#keyword").val("");
			}
			$("#f_search").attr({
				"method" : "get",
				"action" : "/route/routeList"
			});
			$("#f_search").submit();
		}
	</script>

	</head>
		<body>
			<div class="contentContainer container">
				<div id="b_header">
					<div class="text-center">
					<!-- <button id="btn1">div1로 이동</button> -->
						<h1 class="title"><img class="titleImg" alt="/" src="/resources/images/route/gg.png">추천 코스</h1>
						<h5>어트랙션 즐기기 추천코스 기상 상황 및 시즌에 따라 어트랙션 및 공연 관람이 변동될 수 있습니다.</h5>
					</div>
					<div id="movementImg">
						<img alt="/" src="/resources/images/route/147.PNG">
						<img alt="/" src="/resources/images/route/034307.PNG">
					</div>
					<hr />
					<h5 class="textSub">디즈니 동산에서 신나고 행복했던 추억을 쌓았나요?<br />
					 고객님께서 경험한 가장 좋았던 코스와 장소를 추천해 주세요~!</h5>
				</div>
				<%--post 방식으로 전송 시 반드시 form 태그 추가해 주어야 합니다. --%>
				<form name="detailForm" id="detailForm">
					<input type="hidden" name="routeNo" id="routeNo" />
				</form>
				<%-- ========================검색 폼 태그================================== --%>
				<div id="boardSearch" class="text-right">
					<form id="f_search" name="f_search" class="form-inline">
						<%--페이징 처리를 위한 파라미터 --%>
						<input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}" />
						<input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}" />
						<div class="form-group"> 
							<select id="search" name="search" class="form-control">
								<option value="all">전체조회</option>
								<option value="routeTitle">제목</option>
								<option value="routeContent">내용</option>
								<option value="memberId">작성자</option>
							</select> 
							<input type="text" name=keyword id="keyword" value="검색어를 입력하세요" class="form-control" />
							<button type="button" id="searchData" class="btn">검색</button>
							<input type="button" value="글쓰기" id="insertFormBtn" class="btn" />
		
						</div>
					</form>
				</div>
				<%-- ======================== 리스트 시작 ============================== --%>
				<div id="boardList" class="table-heigh">
					<table summary="게시판 리스트" class="table">
						<thead>
							<tr class="trColor">
								<th data-value="b_num" class="order text-center col-md-1">글번호</th>
								<th class="col-md-4 text-center">글제목</th>
								<th class="col-md-2 text-center">작성자</th>
								<th data-value="b_date" class="order col-md-1 text-center">작성일</th>
								<th class="col-md-1 text-center">조회수</th>

							</tr>
						</thead>
						<tbody id="list" >
							<!-- 데이터 출력 -->
							<c:choose>
								<c:when test="${not empty routeList}">
									<c:forEach var="route" items="${routeList}" varStatus= "status">
										<tr class="text-center trColor" data-num="${route.routeNo}">
											<td>${count - status.index}</td>
											<td class="text-left goDetail">${route.routeTitle}</td>
											<td class="name">${route.memberId}</td>
											<td class="text-left">${route.routeDate}</td>
											<td class="text-center">${route.routeHits}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="5" class="text-center">등록된 게시물이 존재하지 않습니다.</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
				<%--=================== 리스트 종료 ================ --%>
				
				<%--=================== 페이징 출력 시작 ================ --%>
				<div class="text-center">
					<ul class="pagination justify-content-center">
						<!-- 이전 바로가기 10개 존재 여부를 prew 팔드의 값으로 확인 -->
						<c:if test="${pageMaker.prev}">
							<li class="paginate_button previous page-item">
								<a class="page-link"  href="${pageMaker.startPage -1}">Previous</a>
							</li>
						</c:if>
						
						<!-- 바로가기 번호 출력 -->
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="paginate_button page-item ${pageMaker.cvo.pageNum == num ? 'active':''}">
								<a class="page-link"  href="${num}">${num}</a>
							</li>
						</c:forEach>
						
						<!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인. -->
						<c:if test="${pageMaker.next}">
							<li class="paginate_button next page-item">
								<a class="page-link"  href="${pageMaker.endPage +1}">Next</a>
							</li>
						</c:if>
					</ul>
				</div>
				
				<%--=================== 글쓰기 버튼 출력 시작 ================ --%>
<!-- 				<div class="contentBtn text-right">
					<input type="button" value="글쓰기" id="insertFormBtn" class="btn" />
				</div> -->
			</div>
	</body>
</html>