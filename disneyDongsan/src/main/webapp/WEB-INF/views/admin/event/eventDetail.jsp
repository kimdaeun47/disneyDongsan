<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
      
      <title>eventDetail</title>
      
      <link rel="shortcut icon" href="/resources/image/icon.png" />
      <link rel="apple-touch-icon" href="/resources/image/icon.png" />
      
      
      <script type="text/javascript" src="/resources/include/js/jquery-3.7.0.min.js"></script>
      <script type="text/javascript" src="/resources/include/js/common.js"></script>
      
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      
      <!--[if lt IE 9]>
      <script src="../js/html5shiv.js"></script>
      <![endif]-->
      
      <link rel="stylesheet" href="/resources/include/css/commonDetail.css"/>
      
      <style type="text/css">
      	.thum {width: 605px; height:200px;}
      	.img {width:300px; height:200px;}
      </style>
      
      <script type="text/javascript">
      	$(function(){
      		let errorMsg = "${errorMsg}";
      		if(errorMsg != ''){
      			alert(errorMsg);
      			errorMsg = '';
      		};
      		
      		var e_no = "${detail.e_no}";
      	    var e_thum = "${detail.e_thum}";
      	    var e_img1 = "${detail.e_img1}";
      	    var e_img2 = "${detail.e_img2}";
      	    
      	    $("#updateFormBtn").click(function(){
      	        $("#e_no").val(e_no);
      	        $("#e_thum").val(e_thum);
      	        $("#e_img1").val(e_img1);
      	        $("#e_img2").val(e_img2);
      	        
      	        
      	        $("#f_data").attr({
      	            "method": "get",
      	            "action": "/admin/event/updateForm"
      	        });
      	        $("#f_data").submit();
      	    });
      	    
      		// 삭제 버튼 클릭 시 이벤트
      	    $("#eventDeleteBtn").click(function(){
    	        if(confirm("삭제하시겠습니까?")){
    	        	$("#f_data").attr({
    	        		"method":"post",
    	        		"action":"/admin/event/eventDelete"
    	        	});
    	        	$("#f_data").submit();
    	            /* $.ajax({
    	                type: "POST",
    	                url: "/admin/event/eventDelete",
    	                data: $("#f_data").serialize(),
    	                success: function(response) {
    	                    if (response === "success") {
    	                        alert("삭제되었습니다.");
    	                    } else {
    	                        alert("삭제에 실패했습니다.");
    	                    }
    	                },
    	                error: function() {
    	                    alert("삭제 실패했습니다.");
    	                }
    	            }); */
    	        }
    	    });
      	    
      		
      		
      	});
      	
      	$(document).ready(function() {   
      	    var e_time = "${detail.e_time}";
      	    if (e_time === "on") {
      	        $("td.col-md-8.text-left").filter(":contains('on')").text("상시");
      	    }
      	});
      </script>
      
   </head>
   <body>
   		<div class="contentContainer container">
	   		<form name="f_data" id="f_data">
	        	<input type="hidden" id="e_no" name="e_no" value="${detail.e_no}" />
	        	<input type="hidden" name="e_thum" value="${detail.e_thum }" />
	        	<input type="hidden" id="e_img1" name="e_img1" value="${detail.e_img1 }" />
	        	<input type="hidden" id="e_img2" name="e_img2" value="${detail.e_img2 }" />
	        </form>	
   			<div class="contentTB text-center">
	         <table class="table table-bordered">
	         	<colgroup>
                   <col width="15%" />
                   <col width="35%" />
                   <col width="15%" />
                   <col width="35%" />
                </colgroup>
	            <tbody>
	               <tr>
	                  <td>제목</td>
	                  <td colspan="3" class="text-left">${detail.e_title}</td>
	               </tr>
	               <tr>
	                  <td>시작일</td>
	                  <td class="text-left">${detail.e_start}</td>
	                  <td>종료일</td>
	                  <td class="text-left">${detail.e_end}</td>
	               </tr>
	               <tr>
	                  <td>시간</td>
	                  <td colspan="3" class="text-left">${detail.e_time}</td>
	               </tr>
	               <tr class="table-tr-height">
	                  <td>내용</td>
	                  <td colspan="3" class="text-left">${detail.e_content}</td>
	               </tr>
	               <c:if test="${not empty detail.e_img1 || not empty detail.e_img2 || not empty detail.e_thum }">
		               <tr>
		               		<td>이미지</td>
		               		<td colspan="3" class="text-left image">
		               			섬네일:<br/>
		               			<c:choose>
		               				<c:when test="${not empty detail.e_thum }">
		               					<img src="/dongsanStorage/event/${detail.e_thum }" class="thum"/><br/>
		               				</c:when>
		               				<c:otherwise>
		               					<img alt="이미지 없을 시 대체이미지" src="/dongsanStorage/event/noimage.png" class="thum" />
		               				</c:otherwise>
		               			</c:choose>
		               			슬라이드 이미지:<br/>
		               			<c:choose>
		               				<c:when test="${not empty detail.e_img1 }">
		               					<img src="/dongsanStorage/event/${detail.e_img1 }" class="img"/>
		               				</c:when>
		               				<c:otherwise>
		               					<img alt="이미지 없을 시 대체이미지" src="/dongsanStorage/event/noimage.png" class="img" />
		               				</c:otherwise>
		               			</c:choose>
		               			<c:choose>
		               				<c:when test="${not empty detail.e_img2 }">
		               					<img src="/dongsanStorage/event/${detail.e_img2 }" class="img"/>
		               				</c:when>
		               				<c:otherwise>
		               					<img alt="이미지 없을 시 대체이미지" src="/dongsanStorage/event/noimage.png" class="img"/>
		               				</c:otherwise>
		               			</c:choose>
		               		</td>
		               </tr>
	               </c:if>
	               
	               
	               
	            </tbody>
	         </table>
	          <div class="text-right">
	            	<input type="button" value="수정" id="updateFormBtn" class="btn sty_btn" />
	            	<input type="button" value="삭제" id="eventDeleteBtn" class="btn sty_btn" />
	          </div>
          </div>
   		</div>
   </body>
</html>