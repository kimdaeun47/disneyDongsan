<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>

<link rel="stylesheet" href="/resources/include/css/commonList.css">

<style type="text/css">

	.choiceDelete_btn{
		 display: inline-block;
	     height: 32px;
	     width: 70px;
	     font-weight: 600;
	     font-size: 15px;
	     line-height: 20px;
	     margin-left: 10px;
	     background-color: #c3daf7;
	     float: right;
	     margin : 10px
	}
	.choiceDelete_btn:hover{
     border: 2px solid #c3daf7;
     background-color: white;
   }

</style>

<script type="text/javascript">
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

		let f_search = $("#f_search");
		$(".page-item a").click(function(e) {
			e.preventDefault();
			f_search.find("input[name='pageNum']").val($(this).attr("href"));
			f_search.attr("action", "/admin/answerList");
			f_search.submit();

		});
	});

	/*체크박스*/

	function deleteValue() {
		let url = "/admin/answerDelete";
		let valueArr = new Array();
		let list = $("input[name='RowCheck']");
		hasChecked = false; //체크 여부 변수

		for (let i = 0; i < list.length; i++) { //체크된 갯수 추출
			if (list[i].checked) { // 선택이 되어있으면 배열에 값을 넣는다.
				hasChecked = true; //체크된 값이 있으면 true 설정
				//console.log(list[i].value);
				let answerCk = $(list[i]).parents("tr").children().eq(4).text(); //배열의 있는 값의 부모요소를 찾아가 답변여부를 text로 가져온다.
				console.log("answerCk:" + answerCk);
				if (answerCk === "n") { //답변 여부 체크
					alert("답변을 하지않은 항목이 있습니다.");
					return;
				} else {
					valueArr.push(list[i].value); //push함수를 이용해 valueArr에 값을 추가
					console.log("valueArr:" + valueArr);
				}
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
				traditional : true,//traditional은 배열을 넘겨주는 옵션이다.
				dataType : "text", //가져올 값의 타입을 텍스트로 설정
				data : {
					valueArr : valueArr
				//보내려는 데이터 변수 선언
				},
				success : function(resultData) { //통신이 성공정으로 이루어졌을때 실행
					if (resultData == "성공") {
						alert("삭제 성공하였습니다.");
						location.reload(); //페이지 새로고침
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

	/*답변 등록 페이지로 이동*/
	$(function() {
		$(".goDetail").click(function() {
			let qa_no = $(this).parents("tr").attr("data-num");
			$("#qa_no").val(qa_no);
			console.log("문의 번호:" + qa_no);

			$("#updateForm").attr({
				"method" : "get",
				"action" : "/admin/answerUpdateForm"
			});
			$("#updateForm").submit();
		});

	});
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	<main id="main" class="main">
		<form name="updateForm" id="updateForm">
			<input type="hidden" name="qa_no" id="qa_no" />
		</form>

		<form id="f_search" name="f_search" class="form-inline">
			<input type="hidden" name="pageNum" id="pageNum"
				value="${pageMaker.cvo.pageNum}"> <input type="hidden"
				name="amount" id="amount" value="${pageMaker.cvo.amount}">
		</form>
		<div class="pagetitle">
			<h1>문의 관리</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
							<div class="text-right">
								<input type="button" id="deleteFormBtn" value="삭제"
									onclick="deleteValue();" class='btn choiceDelete_btn'/>
							</div>
							<div id="qaList">
								<table summary="게시판 리스트" class="table table-hover admin_table">
									<thead>
										<tr>
											<th class="col-md-1 text-center">No</th>
											<th class="col-md-1 text-center">회원 아이디</th>
											<th class="col-md-5 text-center">제목</th>
											<th class="col-md-1 text-center">작성일</th>
											<th class="col-md-1 text-center">답변 유무</th>
											<th class="col-md-1 text-center"><input type="checkbox"
												id="allCheck" name="allCheck" /></th>
										</tr>
									</thead>
									<tbody id="list" class="table-striped">
										<!-- 데이터 출력 -->
										<c:choose>
											<c:when test="${not empty anList}">
												<c:forEach var="anList" items="${anList}" varStatus="status">
													<tr class="text-center" data-num="${anList.qa_no}">
														<td><c:out
																value="${(pageMaker.cvo.pageNum - 1) * pageMaker.cvo.amount + status.index +1}" /></td>
														<td>${anList.member_id}</td>
														<td class="goDetail">${anList.title}</td>
														<td>${anList.qa_date}</td>
														<td>${anList.askyn}</td>
														<td><input name="RowCheck" type="checkbox"
															value="${anList.qa_no}" /></td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="5" class="text-center">등록된 게시물이 존재하지
														않습니다.</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
							<div class="text-center">
								<ul class="pagination justify-content-center">
									<!--  이전 바로가기 10개 존재 여부를 prev 필드의 값으로 확인. -->
									<c:if test="${pageMaker.prev}">
										<li class="page-item previous"><a class="page-link" 
											href="${pageMaker.startPage - 1}">Previous</a></li>
									</c:if>

									<!-- 바로가기 번호 출력-->
									<c:forEach var="num" begin="${pageMaker.startPage}"
										end="${pageMaker.endPage}">
										<li
											class="page-item ${pageMaker.cvo.pageNum == num ? 'active':''}">
											<a class="page-link" href="${num}">${num}</a>
										</li>
									</c:forEach>

									<!--  다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인. -->
									<c:if test="${pageMaker.next}">
										<li class="page-item next"><a class="page-link" 
											href="${pageMaker.endPage + 1 }">Next</a></li>
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