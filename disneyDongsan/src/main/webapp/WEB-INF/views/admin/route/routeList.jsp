<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/admin-template/admin-common.jspf"%>

<link rel="stylesheet" href="/resources/include/css/commonList.css">

   <style type="text/css">
      td img{
         width: 150px;
      }
      .contentContainer{margin-bottom: 60px;}
      .required{color:red;}
      #b_header{
         text-align: center;
         width:1300px;
         margin: auto;
      }
  
   </style>
   <script type="text/javascript">
      $(function(){
         //검색 후 검색 대상과 검색 단어 출력
         let word="<c:out value='${routeVO.keyword}' />";
         let value="";
         if(word!=""){
            $("#keyword").val("<c:out value='${routeVO.keyword}' />");
            $("#search").val("<c:out value='${routeVO.search}' />");
            
            if($("#search").val()!='routeContent'){
               //:contains()는 텍스트를 포함한 요소반환
               if($("#search").val() == 'routeTitle') value = "#list tr td.goDetail";
               else if($("#search").val() == 'memberId') value = "#list tr td.name";
               console.log($(value+":contains('"+word+"')").html());
               
               //$("#list tr td.doDetail:contains('노력')").html()=><span class='required'>노력</span>에 대한 명언
               $(value+":contains('"+word+"')").each(function(){
                  let regex = new RegExp(word,'gi');
                  $(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
               });
            }
         }
         //입력 양식 enter 제거
         $("#keyword").bind("keydown", function(event){
            if(event.keyCode == 13){
               event.preventDefault();
            }
         });
         
         //검색 대상이 변경될 때마다 처리 이벤트
         $("#search").change(function(){
            if($("#search").val() == "all"){
               $("#keyword").val("전체 목록 조회 합니다.");
               $("#keyword").attr("readonly", true);
            }else if($("#search").val() !="all"){
               $("#keyword").val("");
               $("#keyword").focus();
               $("#keyword").removeAttr("readonly");
            }
         });
         
         //검색 버튼 클릭 시 처리 이벤트
         $("#searchData").click(function(){
            if($("#search").val() !="all"){ //제목/내용/작성자 선택시 검색어 유효성 체크
               if(!chkData("#keyword", "검색어를")) return;
            }
            $("#pageNum").val(1);//페이지 초기화
            goPage();
         });
         
         
         //제목 클릭시 상세 페이지 이동을 위한 처리 이벤트
         $(".goDetail").click(function(){
            let routeNo = $(this).parents("tr").attr("data-num");
            $("#routeNo").val(routeNo);
            console.log("글번호 : " + routeNo);
            //상세 페이지로 이동하기 위한 form 추가(id: detailForm)
            $("#detailForm").attr({
               "method": "get",
               "action": "/admin/routeDetail"
            });
            $("#detailForm").submit();

         });
         
         $(".page-item a").click(function(e){
            e.preventDefault();
            $("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
            goPage();
         })
      });
      
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
                // 선택된 항목을 서버로 전송하고 삭제 처리
                var url = "/admin/adminAllRouteDelete";
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
                            // 페이지 새로고침 또는 다른 작업 수행
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

        
        
        function actionProcess(method, goUrl){
           method==="get"? $("#routeImage").remove():"";
           $("#detailForm").attr({
              "method":method,
              "action":goUrl
           });
           $("#detailForm").submit();
        }

      
      //검색을 위한 실질적인 처리 함수
      function goPage(){
         if($("#search").val()=="all"){
            $("#keyword").val("");
         }
         $("#f_search").attr({
            "method":"get",
            "action":"/admin/routeList"
         });
         $("#f_search").submit();
      }
      /*체크박스*/
      /*         function deleteValue() {
                 let url = "/admin/adminAllRouteDelete";
                 let valueArr = new Array();
                 let list = $("input[name='RowCheck']");
                 hasChecked = false; //체크 여부 변수

                 for (let i = 0; i < list.length; i++) { //체크된 갯수 추출
                    if (list[i].checked) { // 선택이 되어있으면 배열에 값을 넣는다.
                       hasChecked = true; //체크된 값이 있으면 true 설정
                       //console.log(list[i].value);
                       let answerCk = $(list[i]).parents("tr").children().eq(5).text(); //배열의 있는 값의 부모요소를 찾아가 답변여부를 text로 가져온다.
                       console.log("answerCk:" + answerCk);

                       valueArr.push(list[i].value); //push함수를 이용해 valueArr에 값을 추가
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
                       traditional : true,//traditional은 배열을 넘겨주는 옵션이다.
                       dataType : "text", //가져올 값의 타입을 텍스트로 설정
                       data : {
                          checkNumber : valueArr
                       //보내려는 데이터 변수 선언
                       },
                       success : function(resultData) { //통신이 성공정으로 이루어졌을때 실행
                          if (resultData == "성공") {
                             alert("삭제 성공하였습니다.");
                             
                             actionProcess("post", url);
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
              } */
   
   </script>

   </head>
      <body>
         <%@ include file="/WEB-INF/views/admin-template/header.jsp"%>
	<%@ include file="/WEB-INF/views/admin-template/sidebar.jsp"%>
	
	<main id="main" class="main">
		<div class="pagetitle">
			<h1>추천 코스 게시물 관리</h1>
		</div>
		<section class="section dashboard">
			<div class="row">
				<div class="col-lg-12">
					<div class="card">
						<div class="card-body">
         					<div class="search_wrap" id="boardSearch" class="text-right">
               <form id="f_search" name="f_search" class="form-inline">
                  <%--페이징 처리를 위한 파라미터 --%>
                  <input type="hidden" name="pageNum" id="pageNum" value="${pageMaker.cvo.pageNum}" />
                  <input type="hidden" name="amount" id="amount" value="${pageMaker.cvo.amount}" />
                  <div class="search_input">
                     <select id="search" name="search" class="form-control">
                        <option value="all">전체조회</option>
                        <option value="routeTitle">제목</option>
                        <option value="routeContent">내용</option>
                        <option value="memberId">작성자</option>
                     </select> 
                     <input type="text" name=keyword id="keyword" value="검색어를 입력하세요" class="form-control" />
                     <button type="button" id="searchData" class="btn search_btn">검색</button>
                     <input type="button" id="deleteFormBtn" class="btn delete_btn" value="삭제" onclick="deleteSelectedItems();"/>
      
                  </div>
               </form>
            </div>
            <%-- ======================== 리스트 시작 ============================== --%>
            <div id="boardList" class="table-heigh">
               <table summary="게시판 리스트" class="table table-hover admin_table">
                  <thead>
                     <tr>
                        <th data-value="b_num" class="order text-center col-md-1">글번호</th>
                        <th class="col-md-6 text-center">글제목</th>
                        <th class="col-md-2 text-center">작성자</th>
                        <th data-value="b_date" class="order col-md-2 text-center">작성일</th>
                        <th class="col-md-1 text-center">조회수</th>
                        <th><input type="checkbox" id="allCheck" name="allCheck" class="text-left"/></th>
                        

                     </tr>
                  </thead>
                  <tbody id="list" class="table-striped">
                     <!-- 데이터 출력 -->
                     <c:choose>
                        <c:when test="${not empty routeList}">
                           <c:forEach var="route" items="${routeList}" varStatus="status">
                              <tr class="text-center" data-num="${route.routeNo}">
                              	 <%-- <td>${pageDTO.total - (pageDTO.total - ((pageDTO.pageNum - 1) * pageDTO.amount + status.index)-1)}</td> --%>
                                 <%-- <td>${route.routeNo}</td> --%>
                                 <td>${count - status.index}</td>
                                 <td class="text-left goDetail">${route.routeTitle}</td>
                                 <td class="name">${route.memberId}</td>
                                 <td class="text-center">${route.routeDate}</td>
                                 <td class="text-center">${route.routeHits}</td>
                                 <td>
                                 	<input class="text-left" name="RowCheck" type="checkbox" value="${route.routeNo}"/>
                                    <form name="detailForm" id="detailForm">
                                       <input type="hidden" name="routeNo" id="routeNo" value="${route.routeNo}" />
                                       <input type="hidden" name="routeImage" id="routeImage" value="${route.routeImage}" />
                                    </form>
                                 </td>
<%--                                  <td>
                                    <form name="detailForm" id="detailForm">
                                       <input type="hidden" name="routeNo" id="routeNo" value="${route.routeNo}" />
                                       <input type="hidden" name="routeImage" id="routeImage" value="${route.routeImage}" />
                                    </form>
                                 </td> --%>
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
                     <li class="page-item previous">
                        <a class="page-link" href="${pageMaker.startPage -1}">Previous</a>
                     </li>
                  </c:if>
                  
                  <!-- 바로가기 번호 출력 -->
                  <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                     <li class="page-item ${pageMaker.cvo.pageNum == num ? 'active':''}">
                        <a class="page-link" href="${num}">${num}</a>
                     </li>
                  </c:forEach>
                  
                  <!-- 다음 바로가기 10개 존재 여부를 next 필드의 값으로 확인. -->
                  <c:if test="${pageMaker.next}">
                     <li class="page-item next">
                        <a class="page-link" href="${pageMaker.endPage +1}">Next</a>
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
