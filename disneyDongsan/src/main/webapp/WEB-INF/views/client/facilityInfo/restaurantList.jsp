<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
 		<style type="text/css">
			.restaurant{
			  text-align: center;
			  margin: auto;
			  width: 1320px;
			}
			
			.screen img{
			  width: 450px;
			  height: 250px;
			}
			
			.restaurant_img_padding{
			  width: 400px;
			  height: 310px;
			  margin: auto;
			  font-size: 25px;
			  font-weight: 800;
			}
			
			.restaurant_img_size{
			  padding: 20px;
			}
			
			.restaurant_img_size:hover .screen_top{
			  bottom:52%;
			}
			.restaurant_img_size:hover .screen_bottom{
			  top:52%;
			}
			
			.screen{
			  position: relative;
			  overflow: hidden;
			
			}
			td .screen::after{
			  content: '';
			  display: block;
			  position: absolute;
			  top:0;
			  left: 0;
			  width: 100%;
			  height: 100%;
			  background-color: rgba(255, 255, 255, 0.8);
			  z-index: l;
			  opacity: 0;
			  transition: all .35s;
			}
			tr .restaurant_img_size:hover .screen::after{
			  opacity: 1;
			}
			.screen_top{
			  position: absolute;
			  bottom: 150%;
			  left: 10px;
			  right: 10px;
			  z-index: 2;
			  color: black;
			  font-size: 22px;
			  font-weight: 900;
			  transition: all .35s;
			}
			.screen_bottom{
			  position: absolute;
			  top: 200%;
			  left: 10px;
			  right: 10px;
			  z-index: 2;
			  color: black;
			  font-size: 12px;
			  transition: all .35s;
			}
			.restaurant_title{
			  font-size: 20px;
			  text-align: center;
			  color: black;
			  width: 400px;
			  height: 50px;
			  margin: auto;
			}
			.goUpdate{padding:13px;}
			#keyword{
				font-size: 16px;
				width: 200px;
				height: 38px;
				outline: 2px solid #3c3c8c;
				border: none;
				margin-left:10px; 
			}
			#search{
				height: 38px;
				display: inline-block;
				width: 150px;
				outline: 2px solid #3c3c8c;
				margin-left:5px; 
			}
			#boardSearch {text-align: right;}
			.form-group{display: flex; align-items: center; float: right;}
			#searchData{
				display: inline-block;
			     height: 39px;
			     width: 70px;
			     font-weight: 600;
			     font-size: 15px;
			     line-height: 20px;
			     margin-left: 10px;
			     background-color: #3c3c8c;
			     color:white;
			     }
		     #searchData:hover{
			     border: 2px solid #3c3c8c;
			     background-color: white;
			     color:black;
			    }
		    .page-item.active .page-link {
				 z-index: 4;
				 color: white;
				 font-weight:bold;
				 background-color: #3c3c8c;
				 border-color: #3c3c8c;
				 
				}
		</style>
		<script type="text/javascript">
			$(function(){
				//검색 후 검색 대상과 검색 단어 출력
				let word="<c:out value='${restaurantVO.keyword}' />";
				let value="";
				if(word!=""){
					$("#keyword").val("<c:out value='${restaurantVO.keyword}' />");
					$("#search").val("<c:out value='${restaurantVO.search}' />");
					
						//:contains()는 텍스트를 포함한 요소반환
						if($("#search").val() == 'restTitle') value = "div .goUpdate";
						console.log($(value+":contains('"+word+"')").html());
						
						//$("#list tr td.doDetail:contains('노력')").html()=><span class='required'>노력</span>에 대한 명언
						$(value+":contains('"+word+"')").each(function(){
							let regex = new RegExp(word,'gi');
							$(this).html($(this).html().replace(regex,"<span class='required'>"+word+"</span>"));
						});				
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
				
				
				
				$(".paginate_button a").click(function(e){
					e.preventDefault();
					$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
					goPage();
				});
				
			});
			
			//검색을 위한 실질적인 처리 함수
			function goPage(){
				if($("#search").val()=="all"){
					$("#keyword").val("");
				}
				$("#f_search").attr({
					"method":"get",
					"action":"/facilityInfo/restaurantList"
				});
				$("#f_search").submit();
			}

		</script>		

	</head>
	<body>
		<div class="restaurant">
			<h1 style="margin-top:50px;">레스토랑</h1>
			<%-- ========================검색 폼 태그================================== --%>
 			<div id="boardSearch" class="text-right">
				<form id="f_search" name="f_search" class="form-inline">
					<input type="hidden" name="pageNum" id="pageNum"
						value="${pageMaker.cvo.pageNum}" /> <input type="hidden"
						name="amount" id="amount" value="${pageMaker.cvo.amount}" />
					<div class="form-group">
						<select id="search" name="search" class="form-control">
							<option value="all">전체조회</option>
							<option value="restTitle">레스토랑 이름</option>
						</select> 
						<input type="text" name=keyword id="keyword" value="검색어를 입력하세요"
							class="form-control" />
						<button type="button" id="searchData" class="btn">검색</button>
					</div>
				</form>
			</div>
			<%-- ======================== 리스트 시작 ============================== --%>
			<div id="boardList" class="table-heigh">
				<table class="restaurant_table">
					<tbody class="restaurant_img">
							<c:choose>
								<c:when test="${not empty restaurantList}"><%int i=0; %>		
									<c:forEach var="re" items="${restaurantList}" varStatus="status">
									<%if(i%3 == 0){%><tr><%i++;}else{i++;} %>
										<td class="restaurant_img_size" data-num="${re.restNo}">
											<div class="restaurant_img_padding">
												<div class='screen'>
													<div class='screen_top'>${re.restSubTitle}</div>
													<div class='screen_bottom'>${re.restContent}</div>
													<img src="/dongsanStorage/facilityInfo/${re.restImage}" alt="/" />
												</div>
												<div class="restaurant_title">
													<h4 class="goUpdate">${re.restTitle}</h4> 
													<p>
												</div>
											</div>
										</td>
									</c:forEach>				
								</c:when>
								<c:otherwise>
									<td colspan="5" class="text-center">등록된 게시물이 존재하지 않습니다.</td>
								</c:otherwise>
							</c:choose>
					</tbody>
				</table>
			</div>
			<%--=================== 리스트 종료 ================ --%>
	
			<%--=================== 페이징 출력 시작 ================ --%>
			<div class="text-center">
				<ul class="pagination justify-content-center">

					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous page-item"><a class="page-link"
							href="${pageMaker.startPage -1}">Previous</a></li>
					</c:if>
	
					<!-- 바로가기 번호 출력 -->
					<c:forEach var="num" begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}">
						<li
							class="paginate_button page-item ${pageMaker.cvo.pageNum == num ? 'active':''}">
							<a class="page-link"  href="${num}">${num}</a>
						</li>
					</c:forEach>
	
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next page-item"><a class="page-link" 
							href="${pageMaker.endPage +1}">Next</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</body>
</html>